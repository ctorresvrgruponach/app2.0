import 'package:com.gruponach.nach_empleado/libs/lib.dart';
import 'package:com.gruponach.nach_empleado/views/prestamos/edita_prestamo.dart';

import '../../api/notificacion_detalle.dart';
import '../../api/solicitudes.dart';
import '../../ui/botondatatable.dart';
import '../prestamos/documentos.dart';

// import '../../api/solicitudes.dart';
// import 'package:intl/intl.dart';

class MisSolicitudes extends ConsumerStatefulWidget {
  const MisSolicitudes({super.key});

  @override
  MisSolicitudesState createState() => MisSolicitudesState();
}

class MisSolicitudesState extends ConsumerState<MisSolicitudes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 0,
      ),
      appBar: AppBar(
        title: const Text('Solicitudes'),
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: <Widget>[
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            child: FutureBuilder<Map<String, dynamic>>(
                future: ref.watch(solicitudesActivas.future),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!['servicios'] != null) {
                    final servicios = snapshot.data!['servicios'];
                    // print(servicios.runtimeType);
                    // return Text(servicios.toString());
                    return Column(
                      children: <Widget>[
                        const SizedBox(
                          child: Padding(
                            padding: EdgeInsets.all(12.0),
                            child: Text(
                              'Actualmente cuentas con las siguientes solicitudes disponibles',
                              style: TextStyle(
                                fontSize: 28,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            // border: Border.all(width: 2),
                            borderRadius: BorderRadius.circular(12),
                            color: const Color.fromARGB(255, 208, 206, 202),
                          ),
                          // color: Color.fromARGB(255, 63, 37, 255),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height * 0.3,
                            width: MediaQuery.of(context).size.height * 0.4,
                            child: PageView.builder(
                              itemCount: servicios.length,
                              itemBuilder: (context, index) {
                                var currentItem = servicios[index];
                                // Verifica el tipo del elemento y muestra contenido en consecuencia
                                if (currentItem is Map<String, dynamic>) {
                                  // Si es un mapa (posiblemente una Autorizacion), extrae información
                                  return SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: ListTile(
                                      leading: Image.asset(
                                          'assets/images/logonach_azul.png'),
                                      title: Text(
                                        currentItem['nombre'],
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                      subtitle:
                                          const Text('Ver mas detalles...'),
                                      onTap: () {
                                        // SharedPreferencesHelper.setdatos('idSolucitud', '$currentItem['id_solicitud']');
                                        SharedPreferencesHelper.setdatos(
                                            'idSolucitud',
                                            '${currentItem['id_solicitud']}');
                                        // Navigator.pushNamed(context, currentItem['ruta']);
                                        // Navigator.pushNamed(context, currentItem['ruta']);
                                        Navigator.pushNamed(
                                            context, 'solicitudesPendientes');
                                      },
                                    ),
                                  );
                                } else if (currentItem is String) {
                                  // Si es una cadena simple
                                  return ListTile(
                                    title: Text(currentItem),
                                  );
                                } else if (currentItem is int) {
                                  // Si es un entero
                                  return ListTile(
                                    title: Text(currentItem.toString()),
                                  );
                                } else {
                                  // Manejar otros tipos según sea necesario
                                  return Container();
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Marquee(
                        //   text: 'Este es un texto con efecto de deslizamiento hacia los lados. ',
                        //   style: TextStyle(fontSize: 16.0),
                        //   scrollAxis: Axis.horizontal,
                        //   crossAxisAlignment: CrossAxisAlignment.start,
                        //   blankSpace: 20.0,
                        //   velocity: 100.0,
                        //   startPadding: 10.0,
                        //   accelerationDuration: Duration(seconds: 1),
                        //   accelerationCurve: Curves.linear,
                        //   decelerationDuration: Duration(milliseconds: 500),
                        //   decelerationCurve: Curves.easeOut,
                        // ),
                        const SizedBox(
                          child:
                              Text('Desliza para describir mas solicitudes '),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error de conexion');
                    // return Text(snapshot.error.toString());
                  } else if (snapshot.hasData &&
                      snapshot.data!['mensaje'] != null) {
                    return alerterror(
                        message: snapshot.data!['mensaje'],
                        title: 'Notificación',
                        icon: Icons.notification_add,
                        color: Colors.white);

                    //  return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return const Cargando();
                }),
          )
        ],
      )),
    );
  }
}

class SolicitudesRealizadas extends ConsumerStatefulWidget {
  const SolicitudesRealizadas({super.key});

  @override
  SolicitudesRealizadasState createState() => SolicitudesRealizadasState();
}

class SolicitudesRealizadasState extends ConsumerState<SolicitudesRealizadas> {
  //  final List<String> items = [
  //   "Adelanto de nomina",
  //   "Prestamos de Nomina",
  //   "solicitud_vacaciones",
  //   // Agrega más elementos según sea necesario
  // ];

  String obtenerHoraActual() {
    DateTime ahora = DateTime.now();
    String hora = '${ahora.hour}:${ahora.minute}:${ahora.second}';
    return hora;
  }

  bool titulo = true;
  List<dynamic> avalesRechazados = [];

// int aceptar

  @override
  Widget build(BuildContext context) {
    fetchData() async {
      final token = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
      final idPrestamo =
          await SharedPreferencesHelper.getdatos('idPrestamoAval');

      final postDatas = {
        "token": token,
        "idEmpleado": idEmpleado,
        "id_prestamo": idPrestamo
      };

      final response = await fetchPostData(
          modo, completeUrldev, baseUrl, endpointMisNotificaciones, postDatas);
      if (response['success'] == true) {
        // print(response);
        return response;
      } else {
        throw Exception(response['mensaje']);
      }
    }
    // final enviaSolicitudVacaciones = ConfirmarRechazarVacaciones();
    // final enviaSolicitudVacaciones = ConfirmarVacaciones();
    // final customDialogManager = CustomDialogManager(context);

    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 0,
      ),
      appBar: AppBar(
        title: const Text('Mis Solicitudes'),
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
      ),
      body: Column(
        children: <Widget>[
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.1,
          // ),255, 183, 169, 169
          SizedBox(
            child: FutureBuilder<Map<String, dynamic>>(
                future: ref.watch(notificacionDetalles.future),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data!['solicitud'] != null) {
                    final solicitud = snapshot.data!['solicitud'];
                    final tipoServicio = snapshot.data!['nombre_servicio'];
                    // print(tipoServicio);
                    // if (solicitud.isEmpty) {
                    //     print('La lista está vacía  0');
                    //   } else {
                    //     print('La lista no está vacía 1');
                    //   }
                    return solicitud.isEmpty
                        ? Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.all(15),
                            elevation: 10,
                            child: const Column(
                              children: <Widget>[
                                ListTile(
                                  // ignore: unnecessary_const
                                  contentPadding:
                                      const EdgeInsets.fromLTRB(15, 10, 25, 0),
                                  title: Text('Nada que mostrar'),
                                  // subtitle: Text('El empleado ${currentItem['nombre_solicitante']} te ha seleccionado como aval por la cantidad de ${currentItem['cantidad']} pesos mexicanos.'),
                                  // leading: const Icon(Icons.notification_add_outlined),
                                ),
                                // Row(
                                //   mainAxisAlignment: MainAxisAlignment.end,
                                //   children: <Widget>[
                                //     ElevatedButton(onPressed: (){
                                //     }, child: const Text('Aceptar')
                                //   ),
                                //   const SizedBox(width: 20,),
                                //   ElevatedButton(onPressed: (){
                                //   }, child: const Text('Cancelar')),
                                //   const SizedBox(width: 8,)
                                //   ],
                                // )
                              ],
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            width: MediaQuery.of(context).size.height * 0.9,
                            child: ListView.builder(
                              itemCount: solicitud.length,
                              itemBuilder: (context, index) {
                                var currentItem = solicitud[index];
                                // print(currentItem.runtimeType);
                                // if (currentItem.isEmpty) {
                                //     print('El mapa está vacío');
                                //   } else {
                                //     print('El mapa no está vacío');
                                //   }
                                // Verifica el tipo del elemento y muestra contenido en consecuencia
                                if (currentItem is Map<String, dynamic>) {
                                  return Center(
                                    child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      margin: const EdgeInsets.all(15),
                                      elevation: 20,
                                      child: Column(
                                        children: [
                                          // Primera fila
                                          SizedBox(
                                            height:
                                                50, // Altura de la primera fila
                                            // color: Colors.blue,
                                            child: Center(
                                              child: Text(
                                                tipoServicio,
                                                style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 24),
                                              ),
                                            ),
                                          ),

                                          // Segunda fila
                                          Row(
                                            children: [
                                              // Primera columna de la segunda
                                              Expanded(
                                                child: SizedBox(
                                                  height:
                                                      100, // Altura de la segunda fila
                                                  // color: Colors.green,
                                                  child: Center(
                                                    //'Adelanto de Nomina'
                                                    //'Prestamo'
                                                    //'Solicitud de Vacaciones'
                                                    // child: Text( tipoServicio == 'Prestamo' ?
                                                    //   'Id Prestamo: '+ currentItem['id_solicitud'].toString() : 'ID:' + currentItem['id_solicitud'].toString(),
                                                    //   style: TextStyle(color: Colors.black),
                                                    // ),
                                                    child: Text(
                                                      tipoServicio ==
                                                              'Adelanto de Nomina'
                                                          ? '# ${currentItem['id_solicitud'].toString()}'
                                                          : tipoServicio ==
                                                                  'Prestamo'
                                                              ? '# ${currentItem['id_solicitud'].toString()}'
                                                              : '# ${currentItem['id_solicitud'].toString()}',
                                                      style: const TextStyle(
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                ),
                                              ),

                                              // Segunda columna de la segunda fila
                                              Expanded(
                                                child: SizedBox(
                                                  height:
                                                      100, // Altura de la segunda fila
                                                  // color: Colors.orange,
                                                  child: Center(
                                                    // child: Text( tipoServicio == 'Prestamo' ?
                                                    //   'Monto Prestamo ${currentItem['cantidad']}'.toString() : 'Dias Solicitados ${currentItem['cantidad']}'.toString(),
                                                    //   style: const TextStyle(color: Colors.black),
                                                    // ),
                                                    child: Text(
                                                        tipoServicio ==
                                                                'Adelanto de Nomina'
                                                            ? 'Monto: \$${currentItem['cantidad'].toString()} pesos.'
                                                            : tipoServicio ==
                                                                    'Prestamo'
                                                                ? 'Monto: \$${currentItem['cantidad'].toString()} pesos.'
                                                                : 'Dias: ${currentItem['cantidad'].toString()}',
                                                        style: const TextStyle(
                                                            fontSize: 20)),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          tipoServicio ==
                                                  'Solicitud de Vacaciones'
                                              ? Row(
                                                  children: [
                                                    // Primera columna de la segunda fila
                                                    Expanded(
                                                      child: SizedBox(
                                                        height:
                                                            100, // Altura de la segunda fila
                                                        // color: Colors.green,
                                                        child: Center(
                                                          child: Text(
                                                            'Fecha inicio: ${currentItem['fecha_inicio']} ',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ),

                                                    // Segunda columna de la segunda fila
                                                    Expanded(
                                                      child: SizedBox(
                                                        height:
                                                            100, // Altura de la segunda fila
                                                        // color: Colors.orange,
                                                        child: Center(
                                                          child: Text(
                                                            'Fecha fin: ${currentItem['fecha_fin']} ',
                                                            style: const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: 15),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              : const Text(''),
                                          //ESTATUS EN PARA SOLICITUDES
                                          //'Adelanto de Nomina'
                                          //'Prestamo'
                                          //'Solicitud de Vacaciones'
                                          tipoServicio == 'Adelanto de Nomina'
                                              ? SizedBox(
                                                  height:
                                                      50, // Altura de la primera fila
                                                  // color: currentItem['estatus']  == 'Inactivo' ? Colors.red : Colors.green,
                                                  // 0 POR AUTORIZAR
                                                  // 1 AUTORIZADO POR CHAYANE
                                                  // 2 RECHAZADO
                                                  child: Center(
                                                    child: Text(
                                                      currentItem['estatus'],
                                                      style: TextStyle(
                                                          color: currentItem[
                                                                      'estatus'] ==
                                                                  'Inactivo'
                                                              ? Colors.red
                                                              : Colors.green,
                                                          fontSize: 20),
                                                    ),
                                                  ),
                                                )
                                              : tipoServicio == 'Prestamo'
                                                  ? SizedBox(
                                                      height:
                                                          50, // Altura de la primera fila
                                                      // color: Colors.blue,
                                                      child: Center(
                                                        child: Text(
                                                          ' ${currentItem['estatus']}',
                                                          style:
                                                              const TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize: 18),
                                                        ),
                                                      ),
                                                    )
                                                  : SizedBox(
                                                      height: 40,
                                                      width: MediaQuery.of(
                                                                  context)
                                                              .size
                                                              .height *
                                                          0.3, // Altura de la primera fila
                                                      // color: const Color.fromARGB(255, 5, 50, 91),
                                                      // 0 POR AUTORIZAR
                                                      // 1 AUTORIZADO POR CHAYANE
                                                      // 2 RECHAZADO
                                                      child: Center(
                                                        child: Text(
                                                          currentItem['id_estatus'] ==
                                                                  0
                                                              ? 'POR AUTORIZAR'
                                                              : currentItem[
                                                                          'id_estatus'] ==
                                                                      1
                                                                  ? 'AUTORIZADO'
                                                                  : 'RECHAZADO',
                                                          style: TextStyle(
                                                              color: currentItem[
                                                                          'id_estatus'] ==
                                                                      0
                                                                  ? Colors.blue
                                                                  : currentItem[
                                                                              'id_estatus'] ==
                                                                          1
                                                                      ? Colors
                                                                          .green
                                                                      : Colors
                                                                          .red),
                                                        ),
                                                      ),
                                                    ),
                                          // TODOS LOS BOTONES QUE OCUPAMOS MOSTRAR DEPENDIEDNO LA SOLICITUD
                                          //'Adelanto de Nomina'
                                          //'Prestamo'
                                          //'Solicitud de Vacaciones'
                                          //todo este show REVISAR
                                          tipoServicio == 'Adelanto de Nomina'
                                              ? Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: <Widget>[
                                                    // currentItem['id_estatus'] == 0 ?
                                                    // // ElevatedButton(onPressed: () => {}, child: Text('Aceptar'))
                                                    // Botondocup(
                                                    //   texto:   'Ver avales elegidos',
                                                    //   indiceadelanto:
                                                    //       '${currentItem['id_solicitud']}',
                                                    //   idoperacion:
                                                    //       '',
                                                    //   // someAvalesMap: 'currentItem',
                                                    //   notificacion: 1,
                                                    // )
                                                    // :
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                    Botoneditar(
                                                        texto: 'Editar',
                                                        indiceadelanto:
                                                            '${currentItem['id_solicitud']}'),
                                                    const SizedBox(
                                                      width: 12,
                                                    ),
                                                  ],
                                                )
                                              :
                                              //todo lo relacionado con prestamos
                                              tipoServicio == 'Prestamo'
                                                  ? Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment.end,
                                                      children: <Widget>[
                                                        currentItem['id_estatus'] ==
                                                                0
                                                            ? ElevatedButton(
                                                                onPressed: () {
                                                                  // print('me tocaste ');
                                                                  int idPrestamo =
                                                                      currentItem[
                                                                          'id_solicitud'];
                                                                  int idoperacion =
                                                                      currentItem[
                                                                          'id_operacion']; //necesito la operacion
                                                                  SharedPreferencesHelper
                                                                      .setdatos(
                                                                          'idPrestamoAval',
                                                                          '$idPrestamo');

                                                                  // int idoperacion =currentItem['id_operacion']; //necesito la operacion
                                                                  fetchData().then(
                                                                      (response) {
                                                                    if (response[
                                                                            'success'] ==
                                                                        true) {
                                                                      //  print('LA DATA ESTA AQUI ');
                                                                      final rechazados =
                                                                          response[
                                                                              'avales_rechazados'];
                                                                      //  print(avales_rechazados.runtimeType);
                                                                      setState(
                                                                          () {
                                                                        avalesRechazados =
                                                                            rechazados;
                                                                      });
                                                                      _mostrarModal(
                                                                          context,
                                                                          idPrestamo,
                                                                          idoperacion);
                                                                    }
                                                                  }).catchError(
                                                                      (error) {
                                                                    // print(error);
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      barrierDismissible:
                                                                          false,
                                                                      builder:
                                                                          (BuildContext
                                                                              context) {
                                                                        return AlertDialog(
                                                                          title:
                                                                              const Text('Lo sentimos :('),
                                                                          content:
                                                                              Text(error.toString()),
                                                                          actions: <Widget>[
                                                                            TextButton(
                                                                              onPressed: () {
                                                                                Navigator.pushNamed(context, 'home');
                                                                              },
                                                                              child: const Text('Aceptar'),
                                                                            ),
                                                                          ],
                                                                        );
                                                                      },
                                                                    );

                                                                    // ignore: invalid_return_type_for_catch_error
                                                                    //   return alerterror(
                                                                    // message: error.toString(),
                                                                    // title: 'Notificación',
                                                                    // icon: Icons.notification_add,
                                                                    // color: Colors.white);
                                                                  });
                                                                },
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all<
                                                                          Color>(
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          5,
                                                                          50,
                                                                          91)),
                                                                ),
                                                                child: const Text(
                                                                    'Mis avales '))
                                                            // Botondocup(
                                                            //   texto:   'AVALES SELECCIONADO',
                                                            //   indiceadelanto:
                                                            //       '${currentItem['id_solicitud']}',
                                                            //   idoperacion:
                                                            //       '${currentItem['id_operacion']}',
                                                            //   // someAvalesMap: 'currentItem',
                                                            //   notificacion: 1,
                                                            // )
                                                            : const SizedBox(
                                                                width: 12,
                                                              ),
                                                        currentItem['id_estatus'] ==
                                                                1
                                                            ? ElevatedButton(
                                                                onPressed: () {
                                                                  int idPrestamo =
                                                                      currentItem[
                                                                          'id_solicitud'];
                                                                  int idoperacion =
                                                                      currentItem[
                                                                          'id_operacion']; //necesito la operacion

                                                                  Navigator
                                                                      .push(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                      builder: (context) => VerDocumentos(
                                                                          data:
                                                                              idPrestamo,
                                                                          idoperacion:
                                                                              idoperacion),
                                                                    ),
                                                                  );
                                                                },
                                                                style:
                                                                    ButtonStyle(
                                                                  backgroundColor: MaterialStateProperty.all<
                                                                          Color>(
                                                                      const Color
                                                                          .fromARGB(
                                                                          255,
                                                                          5,
                                                                          50,
                                                                          91)),
                                                                ),
                                                                child: const Text(
                                                                    'Documentos'))
                                                            : const Text(''),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                      ],
                                                    )
                                                  : const Text(''),
                                        ],
                                      ),
                                    ),
                                  );
                                } else if (currentItem is String) {
                                  // Si es una cadena simple
                                  return ListTile(
                                    title: Text(currentItem),
                                  );
                                } else if (currentItem is int) {
                                  // Si es un entero
                                  return ListTile(
                                    title: Text(currentItem.toString()),
                                  );
                                } else {
                                  // Manejar otros tipos según sea necesario
                                  return Container();
                                }
                              },
                            ),
                          );
                  } else if (snapshot.hasError) {
                    return const Text('Error de conexion');
                    // return Text(snapshot.error.toString());
                  } else if (snapshot.hasData &&
                      snapshot.data!['mensaje'] != null) {
                    // return alerterror(
                    //     message: snapshot.data!['mensaje'],
                    //     title: 'Notificación',
                    //     icon: Icons.notification_add,
                    //     color: Colors.white);

                    return const Text('Error');
                  }
                  // By default show a loading spinner.
                  return const Cargando();
                }),
          )
        ],
      ),
    );
  }

  void _mostrarModal(BuildContext context, int solicitud, int operacion) {
    String contenidoModal = "";

    // Iterar a través de la lista y construir la cadena
    for (var elemento in avalesRechazados) {
      contenidoModal +=
          "El emplado ${elemento['nombre_aval']} a rechazado la oferta...";
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(avalesRechazados.isEmpty
              ? 'Presiona en ver avales para verificar el estatus de tus avales'
              : "Solicitud rechazada "),
          content: Text(contenidoModal),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Cerrar el modal al hacer clic en el botón "Cerrar"
                // print(avalesRechazados);
                Navigator.of(context).pop();
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 231, 0, 0)),
              ),
              child: const Text(
                "Cerrar",
                style: TextStyle(color: Colors.white),
              ),
            ),
            // TextButton(
            //   onPressed: () {
            //     // Cerrar el modal al hacer clic en el botón "Cerrar".
            //     Navigator.of(context).pop();
            //   },
            //   child: Text("Seleccionar nuevo aval "),
            // ),
            // Botondocup(
            //   texto: ,
            //   indiceadelanto:
            //       solicitud.toString(),
            //   idoperacion:
            //       operacion.toString(),
            //   // someAvalesMap: 'currentItem',
            //   notificacion: 1,
            // ),
            Botonc(
              // texto: avalesTextList.isNotEmpty ? 'Selecciona Nuevos Avales' : 'Ver Mis Avales',
              texto: avalesRechazados.isEmpty ? 'Ver avales' : 'Nuevo aval',
              onPressed: () {
                if (kDebugMode) {}
                // if (kDebugMode) {
                // String? idPrestamo = widget.indiceadelanto;
                // String? idoperacion = widget.idoperacion;
                // print(idoperacion);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EditaPrestamo(data: solicitud, idoperacion: operacion),
                  ),
                );
                // }
              },
            ),

            // TextButton(
            //   onPressed: () {
            //     // Cerrar el modal al hacer clic en el botón "Cerrar".
            //     Navigator.of(context).pop();
            //   },
            //   child: Text("Detalles avales"),
            // ),
          ],
        );
      },
    );
  }
}
