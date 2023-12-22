import 'package:com.gruponach.nach_empleado/views/prestamos/edita_prestamo.dart';

import '../api/enviaraprobacion.dart';
import '../libs/lib.dart';

class Botoneditar extends ConsumerStatefulWidget {
  final String texto;
  final String? indiceadelanto;
// BOTON DE ADELANTO EDICION
  const Botoneditar({
    Key? key,
    required this.texto,
    required this.indiceadelanto,
  }) : super(key: key);

  @override
  BotoneditarState createState() => BotoneditarState();
}

class BotoneditarState extends ConsumerState<Botoneditar> {
  @override
  void initState() {
    super.initState();
    setState(() {
      setState(() {
        filterColor = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(filterColor ? 255 : 50, 5, 50, 91),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
        ),
      ),
      onPressed: () {
        final notifier = ref.read(idAdelantoProvider.notifier);
        notifier.updateIdAdelanto(widget.indiceadelanto as String);

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            width: displayWidth(context) * 0.9,
            height: displayHeight(context) * 0.6,
            child: AlertDialog(
              title: const Text("Visualizar archivos"),
              content: const Text(''),
              actions: <Widget>[
                Column(
                  children: [
                    const Text('Selecciona que archivo quieres editar'),
                    const Botonfile(texto: 'INE'),
                    const Botonfile(texto: 'Comprobante'),
                    const Botonfile(texto: 'CURP'),
                    const Text('Selecciona que archivo quieres visualizar'),
                    Center(
                      child: SizedBox(
                        width: displayWidth(context) * 1.9,
                        height: displayHeight(context) * 0.5,
                        child: FutureBuilder<Map<String, dynamic>>(
                          future: ref
                              .watch(postMisAdelantosdetalleProviders.future),
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data!['success']) {
                              if (snapshot.data!['adelantos'].isEmpty) {
                                // Si 'adelantos' está vacío
                                return const Center(
                                  child: Text('No hay datos disponibles.'),
                                );
                              } else {
                                // Si hay datos en 'adelantos'
                                return ListView.builder(
                                    itemCount:
                                        snapshot.data!['adelantos'].length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Center(
                                        child: Container(
                                          width: displayWidth(context) * 0.6,
                                          color: const Color.fromARGB(
                                              0, 208, 7, 7),
                                          child: Center(
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: SizedBox(
                                                child: Row(
                                                  children: [
                                                    Center(
                                                      child: Padding(
                                                        padding: EdgeInsets.only(
                                                            top: displayWidth(
                                                                    context) *
                                                                0.05),
                                                        child: ElevatedButton(
                                                          style: ElevatedButton
                                                              .styleFrom(
                                                            backgroundColor:
                                                                const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    5,
                                                                    50,
                                                                    91),
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius.circular(
                                                                      displayWidth(
                                                                              context) *
                                                                          0.02),
                                                            ), // This is what you need!
                                                          ),
                                                          onPressed: () {
                                                            String url;
                                                            if ((snapshot.data![
                                                                        'adelantos']
                                                                        [index][
                                                                        'mobil']
                                                                    .toString()) ==
                                                                "0") {
                                                              url =
                                                                  """https://nachservice.com.mx/${snapshot.data!['adelantos'][index]['archivo_adelanto'].toString()}""";
                                                            } else {
                                                              var protocolo = modo ==
                                                                      'dev'
                                                                  ? protocolodev
                                                                  : protocolossl;
                                                              var apiii = modo ==
                                                                      'dev'
                                                                  ? completeUrldev
                                                                  : baseUrl;
                                                              url =
                                                                  '$protocolo://$apiii/${snapshot.data!['adelantos'][index]['archivo_adelanto'].toString().replaceAll('uploads', 'pdf')}';
                                                            }
                                                            SharedPreferencesHelper
                                                                .setdatos(
                                                                    "urlPdfVisor",
                                                                    url);
                                                            Navigator.pushNamed(
                                                                context, 'pdf');
                                                          },
                                                          child: Text(
                                                            snapshot.data![
                                                                    'adelantos']
                                                                    [index][
                                                                    'nombre_archivo']
                                                                .toString()
                                                                .toUpperCase(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }
                            } else if (snapshot.data?['success'] == false) {
                              return const Center(
                                  child: Text('No hay datos disponibles.'));
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('No hay datos disponibles.'));
                            } else if (snapshot.hasError) {
                              return const Center(
                                  child: Text('No hay datos disponibles.'));
                            }
                            // By default show a loading spinner.
                            return const Center(child: Cargando());
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      child: Text(' ${widget.texto}'),
    );
  }
}

class Botondocu extends ConsumerStatefulWidget {
  final String texto;
  final String? indiceadelanto;

  const Botondocu({
    Key? key,
    required this.texto,
    required this.indiceadelanto,
  }) : super(key: key);

  @override
  BotondocuState createState() => BotondocuState();
}

class BotondocuState extends ConsumerState<Botondocu> {
  @override
  void initState() {
    super.initState();
    setState(() {
      setState(() {
        filterColor = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.indiceadelanto);
    }
    final customDialogManager = CustomDialogManager(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(filterColor ? 255 : 50, 5, 50, 91),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
        ),
      ),
      onPressed: () {
        final notifier = ref.read(idAdelantoProvider.notifier);
        notifier.updateIdAdelanto(widget.indiceadelanto as String);

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            width: displayWidth(context) * 0.9,
            height: displayHeight(context) * 0.6,
            child: AlertDialog(
              title: const Text("Adjuntar documentos"),
              content: const Text(''),
              actions: <Widget>[
                Column(
                  children: [
                    const Text('Selecciona que archivo quieres editar'),
                    const Botonfile(texto: 'INE'),
                    const Botonfile(texto: 'Comprobante'),
                    const Botonfile(texto: 'CURP'),
                    Botonc(
                      texto: 'Enviar',
                      onPressed: () async {
                        final instanciaEnviaAdelanto = EnviaAprobacionClass();
                        final resp = await instanciaEnviaAdelanto
                            .enviaAprobacion( 0);
                        if (kDebugMode) {
                          print(resp['mensaje']);
                        }
                        if (resp['success']) {
                          await customDialogManager.showCustomDialog(
                              icon: Icons.check,
                              title: resp['mensaje'],
                              message: '',
                              color: const Color.fromARGB(255, 54, 244, 76));
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
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
      child: Text(' ${widget.texto}'),
    );
  }
}





// BOTON DATA TABLE QUE CONFIRMA AVALES 
class Botondocup extends ConsumerStatefulWidget {
  final String texto;
  final String? indiceadelanto;
  final String? idoperacion;
  final int notificacion;
  final List<Map<String, dynamic>>? someAvalesMap;
  const Botondocup(
      {Key? key,
      required this.texto,
      required this.indiceadelanto,
      this.someAvalesMap,
      this.idoperacion,
      required this.notificacion})
      : super(key: key);

  @override
  BotondocupState createState() => BotondocupState();
}

class BotondocupState extends ConsumerState<Botondocup> {

  @override
  void initState() {
    super.initState();
    setState(() {
      setState(() {
        filterColor = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.indiceadelanto);
    }
    // if(widget.idoperacion > 0  ){


    // }
    // List<Widget> avalesTextList = widget.someAvalesMap!.map((aval) {
    //   // Convierte el mapa a una cadena para mostrarla en Text
    //   // String nombre = aval['nombre_aval'].toString();

    //   return Padding(
    //     padding: const EdgeInsets.all(8.0),
    //     child: SizedBox(
    //       child: Column(
    //         children: [
    //           Text('El aval ha'),
    //           const Text('rechazado la solicitud de ser aval'),
    //         ],
    //       ),
    //     ),
    //   );
    // }).toList();
    var numeroavales = (widget.someAvalesMap?.length);
    // int btn = 0;
    if (kDebugMode) {
      print(numeroavales);
    }
    final customDialogManager = CustomDialogManager(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(filterColor ? 255 : 50, 76, 175, 80),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
        ),
      ),
      onPressed: () async {
        await SharedPreferencesHelper.remove('INE');
        await SharedPreferencesHelper.remove('Comprobante');
        setState(() {
          someMap.clear();
        });
        final notifier = ref.read(idAdelantoProvider.notifier);
        notifier.updateIdAdelanto(widget.indiceadelanto as String);

        // ignore: use_build_context_synchronously
        showDialog<String>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            width: displayWidth(context) * 0.9,
            height: displayHeight(context) * 0.6,
            child: AlertDialog(
              // title:  widget.notificacion == 1 && avalesTextList.isNotEmpty == false ? const Text('Para obtener más información, acerca del estatus de tus avales, presiona en ver mis avales.', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),) : (widget.notificacion == 0 ? const Text("Adjuntar documentos") : const Text('')) ,
              title: const Text('Estatus'),
              actions: <Widget>[
                Column(
                  children: [
                    // ...avalesTextList,
                    // avalesTextList.isNotEmpty
                    //     ?
                    Visibility(
                      visible: widget.notificacion == 0 ? false : true,
                      child: Botonc(
                              // texto: avalesTextList.isNotEmpty ? 'Selecciona Nuevos Avales' : 'Ver Mis Avales',
                              texto: 'Mis avales seleccionados',
                              onPressed: () {
                                if (kDebugMode) {}
                                // if (kDebugMode) {
                                  String? idPrestamo = widget.indiceadelanto;
                                  String? idoperacion = widget.idoperacion;
                                  // print(idoperacion);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => EditaPrestamo(
                                          data: idPrestamo,
                                          idoperacion: idoperacion),
                                    ),
                                  );
                                // }
                              },
                            ),
                          );
                          // }
                        },
                      ),
                    ),
                      //   // :
                      // Text(widget.notificacion.toString()),
                      // Text(avalesTextList.isNotEmpty .toString()),
                      Text(widget.notificacion  == 1  ? '' : 'Selecciona que archivo que deseas adjuntar para '),
                      widget.notificacion  == 1 ? const  Text('') : const Botonfile(texto: 'INE'),
                    widget.notificacion == 1 ? const Text('') : const Botonfile(texto: 'Comprobante'),
                    Visibility(
                      visible: widget.notificacion == 1 ? false : true,
                      child: Botonc(
                        texto: 'Enviar',
                        onPressed: () async {
                          final ine =
                              await SharedPreferencesHelper.getdatos('INE');
                          final comprobante =
                              await SharedPreferencesHelper.getdatos(
                                  'Comprobante');
                          if (ine == '') {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomAlertDialog(
                                    message: 'El INE no han sido cargado.',
                                    title: 'Atención',
                                    icon: Icons.error_outline,
                                    color: Colors.amber);
                              },
                            );
                            // print ('El INE o el comprobante no han sido cargados.');
                            return;
                          } else if (comprobante == '') {
                            // ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomAlertDialog(
                                    message:
                                        'El Comprobante no han sido cargado.',
                                    title: 'Atención',
                                    icon: Icons.error_outline,
                                    color: Colors.amber);
                              },
                            );
                          } else {
                            // print('LLEGO BB');
                            setState(() {
                              // btn = 1;
                            });
                            // print('nuevo valor $btn');
                            await customDialogManager.showCustomDialog(
                              icon: Icons.warning,
                              message:
                                  'Al dar click se tendrá acceso a tu último recibo de nómina.',
                              title: '',
                              color: const Color.fromARGB(255, 244, 54, 54),
                            );
                            setState(() {
                              // btn = 1;
                            });
                            final instanciaEnviaAdelanto = EnviaAprobacionClass();
                            final resp = await instanciaEnviaAdelanto
                                .enviaAprobacion( 1);
                            if (kDebugMode) {
                              print(resp['mensaje']);
                            }
                            if (resp['success']) {
                              await customDialogManager.showCustomDialog(
                                  icon: Icons.check,
                                  title: resp['mensaje'],
                                  message: '',
                                  color:
                                      const Color.fromARGB(255, 54, 244, 76));
                              await SharedPreferencesHelper.remove('INE');
                              await SharedPreferencesHelper.remove(
                                  'Comprobante');
                              setState(() {
                                someMap.clear();
                              });
                              ref.refresh(
                                  postMisNotificacionesdetalleProviders);
                              ref.refresh(postMisAdelantosProviders);
                              // ignore: use_build_context_synchronously
                              Navigator.of(context).pop();
                            } else {
                              await customDialogManager.showCustomDialog(
                                  icon: Icons.warning,
                                  title: resp['mensaje'],
                                  message: '',
                                  color:
                                      const Color.fromARGB(255, 244, 54, 54));
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
      child: Text(' ${widget.texto}'),
    );
  }
}

class Botondocur extends ConsumerStatefulWidget {
  final String texto;
  final String? indiceadelanto;

  const Botondocur({
    Key? key,
    required this.texto,
    required this.indiceadelanto,
  }) : super(key: key);

  @override
  BotondocurState createState() => BotondocurState();
}

class BotondocurState extends ConsumerState<Botondocur> {
  @override
  void initState() {
    super.initState();
    setState(() {
      setState(() {
        filterColor = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print(widget.indiceadelanto);
    }
    final customDialogManager = CustomDialogManager(context);
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(filterColor ? 255 : 50, 244, 54, 54),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
        ),
      ),
      onPressed: () {
        final notifier = ref.read(idAdelantoProvider.notifier);
        notifier.updateIdAdelanto(widget.indiceadelanto as String);

        showDialog<String>(
          context: context,
          builder: (BuildContext context) => SizedBox(
            width: displayWidth(context) * 0.9,
            height: displayHeight(context) * 0.6,
            child: AlertDialog(
              title: const Text("¿Deseas rechazar ser aval?"),
              content: const Text(''),
              actions: <Widget>[
                Column(
                  children: [
                    Botonc(
                      texto: 'SI',
                      onPressed: () async {
                        final instanciaEnviaAdelanto = EnviaAprobacionClass();
                        final resp = await instanciaEnviaAdelanto
                            .enviaAprobacion( 2);
                        if (kDebugMode) {
                          print(resp['mensaje']);
                        }
                        if (resp['success']) {
                          await customDialogManager.showCustomDialog(
                              icon: Icons.check,
                              title: resp['mensaje'],
                              message: '',
                              color: const Color.fromARGB(255, 54, 244, 76));
                          // ignore: use_build_context_synchronously
                          Navigator.of(context).pop();
                          ref.refresh(postMisNotificacionesdetalleProviders);
                          ref.refresh(postMisAdelantosProviders);
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
      child: Text(' ${widget.texto}'),
    );
  }
}
