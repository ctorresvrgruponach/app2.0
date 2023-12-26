import 'package:com.gruponach.nach_empleado/libs/lib.dart';

import '../../api/enviaraprobacion.dart';
import '../../api/notificacion_detalle.dart';
import '../../api/solicitudes.dart';
// import '../../api/solicitudes.dart';
// import 'package:intl/intl.dart';

class Notificaciones extends ConsumerStatefulWidget {
  const Notificaciones({super.key});

  @override
  NotificacionesState createState() => NotificacionesState();
}

class NotificacionesState extends ConsumerState<Notificaciones> {
  // @override

  //  final List<String> items = [
  //   "Adelanto de nomina",
  //   "Prestamos de Nomina",
  //   "solicitud_vacaciones",
  //   // Agrega más elementos según sea necesario
  // ];

  String obtenerHoraActual() {
    DateTime ahora = DateTime.now();
    String hora = '${ahora.hour}:${ahora.minute}';
    return hora;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 1,
      ),
      appBar: AppBar(
        title: const Text('Notificaciones'),
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
      ),
      body: Column(
        children: <Widget>[
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.1,
          // ),
          SizedBox(
            child: FutureBuilder<Map<String, dynamic>>(
                future: ref.watch(solicitudesActivas.future),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!['autorizacion'] != null) {
                    // return Text('Tenemos la data bro');
                    final autorizacion = snapshot.data!['autorizacion'];
                    // print(autorizacion.runtimeType);
                    // return Text(autorizacion.toString());

                    // return SizedBox(
                    //   // width: displayWidth( context) * 0.8,
                    //   // height: displayWidth( context) * 0.8,
                    //   child:Container(
                    //     height: MediaQuery.of(context).size.height * 0.7,
                    //     width: MediaQuery.of(context).size.height * 0.9,
                    //     child: PageView.builder(
                    //       itemCount: items.length,
                    //       itemBuilder: (BuildContext context, int index) {
                    //         return Card(
                    //           margin: EdgeInsets.symmetric(horizontal: 10.0),
                    //           color: Colors.blue, // Puedes personalizar el color según tus necesidades
                    //           child: Center(
                    //             child: Text(
                    //               items[index],
                    //               style: TextStyle(fontSize: 20.0, color: Colors.white),
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //   ),
                    // );
                    return SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      width: MediaQuery.of(context).size.height * 0.9,
                      child: ListView.builder(
                        itemCount: autorizacion.length,
                        itemBuilder: (context, index) {
                          var currentItem = autorizacion[index];
                          // Verifica el tipo del elemento y muestra contenido en consecuencia
                          if (currentItem is Map<String, dynamic>) {
                            // Si es un mapa (posiblemente una Autorizacion), extrae información
                            return ListTile(
                              title: Text(currentItem['nombre']),
                              subtitle: const Text('Ver mas detalles...'),
                              trailing: Text(obtenerHoraActual()),
                              onTap: () {
                                // SharedPreferencesHelper.setdatos('idSolucitud', '$currentItem['id_solicitud']');
                                SharedPreferencesHelper.setdatos('idSolucitud',
                                    '${currentItem['id_solicitud']}');
                                // Navigator.pushNamed(context, currentItem['ruta']);
                                Navigator.pushNamed(
                                    context, 'detalles_notificacion');
                              },
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
                    return alerterror(
                        message: snapshot.data!['mensaje'],
                        title: 'Notificación',
                        icon: Icons.notifications_active,
                        color: Colors.white);
                    //  return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return const Cargando();
                }),
          )
        ],
      ),
    );
  }
}

// import 'package:com.gruponach.nach_empleado/libs/lib.dart';

// import '../../api/solicitudes.dart';
// import '../../api/solicitudes.dart';
// import 'package:intl/intl.dart';

class DetallesNotificaciones extends ConsumerStatefulWidget {
  const DetallesNotificaciones({super.key});

  @override
  DetallesNotificacionesState createState() => DetallesNotificacionesState();
}

class DetallesNotificacionesState
    extends ConsumerState<DetallesNotificaciones> {
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

  bool aceptavacaciones = false;
  bool rechazavacaciones = false;
  bool isLoading = false;

  void fetchData() async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final idSolicitud =
        await SharedPreferencesHelper.getdatos('id_solicitud_vacacion');
    final estatus =
        await SharedPreferencesHelper.getdatos('estatus_vacaciones');

    final postDatas = {
      "token": token,
      "id_solicitud": idSolicitud,
      "estatus": estatus,
    };

    final response = await fetchPostData(
        modo, completeUrldev, baseUrl, confirmaRechazaVacaciones, postDatas);

    if (response['success'] == true) {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      ref.refresh(notificacionDetalles);
      return
          // ignore: use_build_context_synchronously
          showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CustomAlertDialog(
              message: response['mensaje'],
              title: 'Éxito',
              icon: Icons.check,
              color: Colors.green);
        },
      );
    } else {
      setState(() {
        isLoading = false;
      });
      Navigator.of(context).pop();
      return
          // ignore: use_build_context_synchronously
          showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const CustomAlertDialog(
              message: 'Error al realizar la solicitud intentalo mas tarde.',
              title: 'Error...!',
              icon: Icons.error_sharp,
              color: Colors.red);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final enviaSolicitudVacaciones = ConfirmarRechazarVacaciones();
    // final enviaSolicitudVacaciones = ConfirmarVacaciones();
    final customDialogManager = CustomDialogManager(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis Notificaciones'),
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
      ),
      body: Column(
        children: <Widget>[
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.1,
          // ),
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
                              ],
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
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
                                  return Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.all(15),
                                    elevation: 10,
                                    child: Column(
                                      children: <Widget>[
                                        ListTile(
                                          contentPadding:
                                              const EdgeInsets.fromLTRB(
                                                  15, 10, 25, 0),
                                          title: Text(
                                            tipoServicio,
                                            style:
                                                const TextStyle(fontSize: 20),
                                          ),
                                          subtitle: tipoServicio ==
                                                  'Autorizacion de Aval'
                                              ? Text(
                                                  'El empleado ${currentItem['nombre_solicitante']} te ha seleccionado como aval por la cantidad de \$${currentItem['cantidad']} pesos mexicanos.',
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                )
                                              : Text(
                                                  'El empleado ${currentItem['nombre_solicitante']} ha solicitado ${currentItem['cantidad']} dias a cuenta de sus vacaciones que constan del dia  ${currentItem['fecha_inicio']}. al ${currentItem['fecha_fin']} del presenter año en curso.',
                                                  textAlign: TextAlign.justify,
                                                  style: const TextStyle(
                                                      fontSize: 14),
                                                ),
                                          leading: const Icon(
                                              Icons.notification_add_outlined),
                                        ),
                                        tipoServicio == 'Autorizacion de Aval'
                                            ? Row(
                                                //TODO CONFIRMAR AVAL LO RELACIONADO A AVALES
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        SharedPreferencesHelper
                                                            .setdatos('estatus',
                                                                '1'); //Autorizar
                                                        SharedPreferencesHelper
                                                            .setdatos(
                                                                'id_solicitud',
                                                                '${currentItem['id_solicitud']}');
                                                        // print('para avales');
                                                        await SharedPreferencesHelper
                                                            .remove('INE');
                                                        await SharedPreferencesHelper
                                                            .remove(
                                                                'Comprobante');
                                                        setState(() {
                                                          someMap.clear();
                                                        });
                                                        // ignore: use_build_context_synchronously
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SizedBox(
                                                            width: displayWidth(
                                                                    context) *
                                                                0.9,
                                                            height: displayHeight(
                                                                    context) *
                                                                0.6,
                                                            child: AlertDialog(
                                                              title: const Text(
                                                                  'Documentacion necesaria!'),
                                                              actions: <Widget>[
                                                                Column(
                                                                  children: [
                                                                    // ...avalesTextList,
                                                                    // avalesTextList.isNotEmpty
                                                                    //     ?
                                                                    // Visibility(
                                                                    //   visible:  true,
                                                                    //   child: Botonc(
                                                                    //           texto: avalesTextList.isNotEmpty ? 'Selecciona Nuevos Avales' : 'Ver Mis Avales',
                                                                    //           onPressed: () {
                                                                    //             if (kDebugMode) {}
                                                                    //             // if (kDebugMode) {
                                                                    //               String? idPrestamo = widget.indiceadelanto;
                                                                    //               String? idoperacion = widget.idoperacion;
                                                                    //               Navigator.push(
                                                                    //                 context,
                                                                    //                 MaterialPageRoute(
                                                                    //                   builder: (context) => EditaPrestamo(
                                                                    //                       data: idPrestamo,
                                                                    //                       idoperacion: idoperacion),
                                                                    //                 ),
                                                                    //               );
                                                                    //             // }
                                                                    //           },
                                                                    //         ),
                                                                    // ),
                                                                    //   // :
                                                                    // Text(widget.notificacion.toString()),
                                                                    // Text(avalesTextList.isNotEmpty .toString()),
                                                                    const Text(
                                                                        'Por favor adjunta los siguientes documentos'),
                                                                    const Botonfile(
                                                                        texto:
                                                                            'INE'),
                                                                    const Botonfile(
                                                                        texto:
                                                                            'Comprobante'),
                                                                    Visibility(
                                                                      visible:
                                                                          true,
                                                                      child:
                                                                          Botonc(
                                                                        texto:
                                                                            'Enviar',
                                                                        onPressed:
                                                                            () async {
                                                                          // print('Enviar datos');
                                                                          final ine =
                                                                              await SharedPreferencesHelper.getdatos('INE');
                                                                          final comprobante =
                                                                              await SharedPreferencesHelper.getdatos('Comprobante');
                                                                          // print('Esto es $ine');
                                                                          if (ine ==
                                                                              '') {
                                                                            // ignore: use_build_context_synchronously
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return const CustomAlertDialog(message: 'El INE no han sido cargado.', title: 'Atención', icon: Icons.error_outline, color: Colors.amber);
                                                                              },
                                                                            );
                                                                            // print ('El INE o el comprobante no han sido cargados.');
                                                                            return;
                                                                          } else if (comprobante ==
                                                                              '') {
                                                                            // ignore: use_build_context_synchronously
                                                                            showDialog(
                                                                              context: context,
                                                                              builder: (BuildContext context) {
                                                                                return const CustomAlertDialog(message: 'El Comprobante no han sido cargado.', title: 'Atención', icon: Icons.error_outline, color: Colors.amber);
                                                                              },
                                                                            );
                                                                          } else {
                                                                            // print('LLEGO BB');
                                                                            await customDialogManager.showCustomDialog(
                                                                              icon: Icons.warning,
                                                                              message: 'Al dar clic se tendrá acceso a tu último recibo de nómina.',
                                                                              title: '',
                                                                              color: const Color.fromARGB(255, 244, 54, 54),
                                                                            );
                                                                            // setState(() {
                                                                            //   btn = 1;
                                                                            // });
                                                                            final confrimaRechazaAval =
                                                                                EnviaAprobacionClass();
                                                                            final resp =
                                                                                await confrimaRechazaAval.enviaAprobacion(
                                                                              1,
                                                                            );
                                                                            SharedPreferencesHelper.setdatos('id_solicitud_aval',
                                                                                '${currentItem['id_solicitud']}');
                                                                            if (resp['success']) {
                                                                              await customDialogManager.showCustomDialog(icon: Icons.check, title: resp['mensaje'], message: '', color: const Color.fromARGB(255, 54, 244, 76));
                                                                              await SharedPreferencesHelper.remove('INE');
                                                                              await SharedPreferencesHelper.remove('Comprobante');
                                                                              setState(() {
                                                                                someMap.clear();
                                                                              });
                                                                              ref.refresh(notificacionDetalles);
                                                                              await SharedPreferencesHelper.remove('idSolucitud');
                                                                              // ref.refresh(solicitudesActivas);
                                                                              // ref.refresh(notificacionDetalles);
                                                                              // ignore: use_build_context_synchronously
                                                                              Navigator.of(context).pop();
                                                                              // ignore: use_build_context_synchronously
                                                                              // Navigator.push(
                                                                              //   context,
                                                                              //   MaterialPageRoute(builder: (context) => const Noto()),
                                                                              // );
                                                                            } else {
                                                                              await customDialogManager.showCustomDialog(icon: Icons.warning, title: resp['mensaje'], message: '', color: const Color.fromARGB(255, 244, 54, 54));
                                                                            }
                                                                          }
                                                                        },
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        5,
                                                                        50,
                                                                        91)),
                                                      ),
                                                      child: const Text(
                                                          'Aceptar')),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        SharedPreferencesHelper
                                                            .setdatos('estatus',
                                                                '2'); //Autorizar
                                                        showDialog<String>(
                                                          context: context,
                                                          builder: (BuildContext
                                                                  context) =>
                                                              SizedBox(
                                                            width: displayWidth(
                                                                    context) *
                                                                0.9,
                                                            height: displayHeight(
                                                                    context) *
                                                                0.6,
                                                            child: AlertDialog(
                                                              title: const Text(
                                                                  "¿Deseas rechazar ser aval?"),
                                                              content:
                                                                  const Text(
                                                                      ''),
                                                              actions: <Widget>[
                                                                Column(
                                                                  children: [
                                                                    Botonc(
                                                                      texto:
                                                                          'SI',
                                                                      onPressed:
                                                                          () async {
                                                                        // print('ENVIAMOS SOLICITUD');
                                                                        SharedPreferencesHelper.setdatos('id_solicitud_aval', '${currentItem['id_solicitud']}');
                                                                        final instanciaEnviaAdelanto =
                                                                            EnviaAprobacionClass();
                                                                        final resp =
                                                                            await instanciaEnviaAdelanto.enviaAprobacion(2);
                                                                        if (kDebugMode) {
                                                                          print(
                                                                              resp['mensaje']);
                                                                        }
                                                                        if (resp[
                                                                            'success']) {
                                                                          ref.refresh(
                                                                              notificacionDetalles);

                                                                          await customDialogManager.showCustomDialog(
                                                                              icon: Icons.check,
                                                                              title: resp['mensaje'],
                                                                              message: '',
                                                                              color: const Color.fromARGB(255, 54, 244, 76));
                                                                          // ignore: use_build_context_synchronously
                                                                          // Navigator.of(context).pop();
                                                                          // ignore: use_build_context_synchronously
                                                                          // Navigator
                                                                          //     .push(
                                                                          //   context,
                                                                          //   MaterialPageRoute(builder: (context) => const HomeScreen()),
                                                                          // );
                                                                          // ref.refresh(solicitudesActivas);
                                                                          // ref.refresh(notificacionDetalles);
                                                                          Navigator.of(context)
                                                                              .pop();

                                                                          await SharedPreferencesHelper.remove(
                                                                              'idSolucitud');
                                                                          // await SharedPreferencesHelper.remove('Identificación (INE)');
                                                                        } else {
                                                                          await customDialogManager.showCustomDialog(
                                                                              icon: Icons.warning,
                                                                              title: resp['mensaje'],
                                                                              message: '',
                                                                              color: const Color.fromARGB(255, 244, 54, 54));
                                                                        }
                                                                      },
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        222,
                                                                        0,
                                                                        0)),
                                                      ),
                                                      child: const Text(
                                                          'Rechazar')),
                                                  const SizedBox(
                                                    width: 8,
                                                  )
                                                ],
                                              )
                                            : Row(
                                                //TODO RELACIONADO CONFIRMA VACACIONES
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: <Widget>[
                                                  ElevatedButton(
                                                      onPressed: () async {
                                                        SharedPreferencesHelper
                                                            .setdatos(
                                                                'estatus_vacaciones',
                                                                '1'); //ACEPTAR
                                                        SharedPreferencesHelper
                                                            .setdatos(
                                                                'id_solicitud_vacacion',
                                                                '${currentItem['id_solicitud']}');
                                                        modalCargando();
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        5,
                                                                        50,
                                                                        91)),
                                                      ),
                                                      child: const Text(
                                                          'Aceptar')),
                                                  const SizedBox(
                                                    width: 20,
                                                  ),
                                                  ElevatedButton(
                                                      //TODO RECHAZA VACACIONES
                                                      onPressed: () async {
                                                        SharedPreferencesHelper
                                                            .setdatos(
                                                                'estatus_vacaciones',
                                                                '2'); //RECHAZAR
                                                        SharedPreferencesHelper
                                                            .setdatos(
                                                                'id_solicitud_vacacion',
                                                                '${currentItem['id_solicitud']}');
                                                        modalCargando();
                                                      },
                                                      style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    const Color
                                                                        .fromARGB(
                                                                        255,
                                                                        222,
                                                                        0,
                                                                        0)),
                                                      ),
                                                      child: const Text(
                                                          'Rechazar')),
                                                  const SizedBox(
                                                    width: 8,
                                                  )
                                                ],
                                              )
                                      ],
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

  void modalCargando() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return AbsorbPointer(
          absorbing: true, // Establece en true para bloquear la interacción
          child: Container(
            height: MediaQuery.of(context).size.height * 0.3,
            padding: const EdgeInsets.all(12),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Procesando solicitud, por favor espere...'),
                const SizedBox(height: 30),
                SizedBox(
                  width: MediaQuery.of(context).size.height * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: const CircularProgressIndicator(
                    strokeWidth: 8,
                    backgroundColor: Color.fromARGB(255, 5, 50, 91),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color.fromARGB(255, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    fetchData();
  }
}
