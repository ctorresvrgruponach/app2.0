import '../../api/apicaja.dart';

import '../../libs/lib.dart';
import '../../ui/decoracioninput.dart';
import '../../ui/inputpersona.dart';

bool readmonto = false;
String? montototal;
String? comisiontotal;
String? montoenviar;

bool btnsolicitaPrestamo = false;

String? salarioMensual;
String? montoMaximoAdelanto;

String? actualizanombre;
String? actualizaapellidoMaterno;
String? actualizaapellidoPaterno;

class ValoresPedirCajaScreen extends ConsumerStatefulWidget {
  const ValoresPedirCajaScreen({super.key});
  @override
  ValoresPedirCajaScreenState createState() => ValoresPedirCajaScreenState();
}

class ValoresPedirCajaScreenState
    extends ConsumerState<ValoresPedirCajaScreen> {
  @override
  void initState() {
    super.initState();
  }

  var textomarcoemail = 255;

  double _currentSliderValue = 100;
  TextEditingController monto = TextEditingController();

  TextEditingController mperiodo = TextEditingController();

  TextEditingController sueldoMensual = TextEditingController();
  TextEditingController nombre = TextEditingController();
  TextEditingController porcentaje = TextEditingController();
  TextEditingController apellidopaterno = TextEditingController();
  TextEditingController apellidomaterno = TextEditingController();
  TextEditingController fechadenacimiento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var datos = getdatos();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<Map<String, dynamic>>(
                future: ref.watch(postPedirCajaProviders.future),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!['info_empleado'] != null) {
                    if (kDebugMode) {
                      print(snapshot.data!);
                    }
                    final operaciones = snapshot.data!['info_empleado'];
                    sueldoMensual.text =
                        operaciones['salario_mensual'].toString();
                    double sueldo =
                        double.parse(operaciones['salario_mensual']);

                    double periodosPagos;
                    double montomaximo =
                        double.parse(operaciones['salario_mensual']) * 0.20;

                    if (operaciones["tipo_nomina"] == 'Semanal') {
                      periodosPagos = 4;
                    } else if (operaciones["tipo_nomina"] == 'Catorcenal') {
                      periodosPagos = 2;
                    } else if (operaciones["tipo_nomina"] == 'Quincenal') {
                      periodosPagos = 2;
                    } else if (operaciones["tipo_nomina"] == 'Mensual') {
                      periodosPagos = 1;
                    } else if (operaciones["tipo_nomina"] == 'Unidad obra') {
                      periodosPagos = 2;
                    } else {
                      periodosPagos = 0;
                    }
                    nombre.text = operaciones['nombres'];
                    apellidopaterno.text = operaciones['apellido_paterno'];
                    apellidomaterno.text = operaciones['apellido_materno'];
                    fechadenacimiento.text = operaciones['fecha_nacimiento'];
                    return Card(
                      child: Container(
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                "assets/images/fondo_blanco.png",
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            textosFijo10(context, 'Nombre(s)'),
                            SizedBox(
                              child: TextFormField(
                                controller: nombre,
                                readOnly: true,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration:
                                    DecoracionPersonal.decoracionPersonal,
                              ),
                            ),
                            textosFijo10(context, 'Apellido Paterno'),
                            SizedBox(
                              child: TextFormField(
                                controller: apellidopaterno,
                                readOnly: true,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration:
                                    DecoracionPersonal.decoracionPersonal,
                              ),
                            ),
                            textosFijo10(context, 'Apellido Materno'),
                            SizedBox(
                              child: TextFormField(
                                readOnly: true,
                                controller: apellidomaterno,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration:
                                    DecoracionPersonal.decoracionPersonal,
                              ),
                            ),
                            textosFijo10(context, 'Fecha de nacimiento'),
                            SizedBox(
                              child: TextFormField(
                                readOnly: true,
                                controller: fechadenacimiento,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration:
                                    DecoracionPersonal.decoracionPersonal,
                              ),
                            ),
                            textosFijo10(context, 'Sueldo Mensual'),
                            SizedBox(
                              child: TextFormField(
                                readOnly: true,
                                controller: sueldoMensual,
                                inputFormatters:
                                    DecoracionPersonal.inputFormatters,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration:
                                    DecoracionPersonal.decoracionPersonal,
                              ),
                            ),
                            textosFijo10(context, 'Monto a Solicitar'),
                            SizedBox(
                              child: Slider(
                                activeColor:
                                    const Color.fromARGB(255, 5, 50, 91),
                                inactiveColor:
                                    const Color.fromARGB(255, 120, 120, 120),
                                value: _currentSliderValue,
                                max: montomaximo,
                                min: 100,
                                // divisions: 6,
                                label: _currentSliderValue
                                    .round()
                                    .toStringAsFixed(2),
                                onChanged: readmonto
                                    ? null
                                    : (double value) {
                                        setState(() {
                                          _currentSliderValue = value;
                                          monto.text = _currentSliderValue
                                              .toStringAsFixed(2);
                                          mperiodo.text = (double.parse(
                                                      _currentSliderValue
                                                          .toString()) /
                                                  periodosPagos)
                                              .toStringAsFixed(2)
                                              .toString();

                                          porcentaje.text = ((double.parse(
                                                          _currentSliderValue
                                                              .toString()) /
                                                      sueldo) *
                                                  100)
                                              .toStringAsFixed(2)
                                              .toString();

                                          if (kDebugMode) {
                                            print(montototal);
                                          }
                                        });
                                      },
                              ),
                            ),
                            SizedBox(
                              child: TextFormField(
                                controller: monto,
                                inputFormatters:
                                    DecoracionPersonal.inputFormatters,
                                onChanged: (value) {
                                  try {
                                    double montoDouble =
                                        double.parse(monto.text);
                                    if (montoDouble >= 100) {
                                      setState(() {});
                                    } else {}
                                  } catch (e) {
                                    if (kDebugMode) {
                                      print(
                                          'Error al parsear el monto a double: $e');
                                    }
                                    // Manejar el error, por ejemplo, mostrar un mensaje al usuario
                                  }
                                },
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration:
                                    DecoracionPersonal.decoracionPersonal,
                              ),
                            ),
                            textosFijo10(context, 'Monto por Periodo'),
                            SizedBox(
                              child: TextFormField(
                                controller: mperiodo,
                                onChanged: (value) {},
                                inputFormatters:
                                    DecoracionPersonal.inputFormatters,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration:
                                    DecoracionPersonal.decoracionPersonal,
                              ),
                            ),
                            textosFijo10(context, 'Porcentaje:'),
                            SizedBox(
                              child: TextFormField(
                                controller: porcentaje,
                                onChanged: (value) {},
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration:
                                    DecoracionPersonal.decoracionPersonal,
                              ),
                            ),
                            const SizedBox(
                              height: 400,
                              child: PersonasListWidget(),
                            ),
                            // Stack(
                            //   children: [
                            //     Column(
                            //       children: [
                            //         Botonc(
                            //           texto: 'Aceptar Caja',
                            //           onPressed: btnsolicitaPrestamo
                            //               ? null
                            //               : () async {
                            //                   setState(() {
                            //                     someMap['Aceptar Caja'] =
                            //                         'Aceptar Caja';
                            //                     btnsolicitaPrestamo = true;
                            //                   });
                            //                   // final instanciaEnviaAdelanto =
                            //                   //     EnviaAdelantoClass();
                            //                   // final resultado =
                            //                   //     await instanciaEnviaAdelanto
                            //                   //         .enviaadelanto();
                            //                   // if (resultado['success']) {
                            //                   //   if (kDebugMode) {
                            //                   //     print(resultado);
                            //                   //   }
                            //                   //   final customDialogManager =
                            //                   //       // ignore: use_build_context_synchronously
                            //                   //       CustomDialogManager(
                            //                   //           context);
                            //                   //   List<dynamic> argumentos = [];
                            //                   //   final navegador =
                            //                   //       // ignore: use_build_context_synchronously
                            //                   //       NavegadorDeRuta(
                            //                   //           context, argumentos);
                            //                   //   await navegador
                            //                   //       .algunlugar('home');
                            //                   //   setState(() {
                            //                   //     someMap.clear();
                            //                   //   });
                            //                   //   setState(() {
                            //                   //     btnsolicitaPrestamo = false;
                            //                   //   });
                            //                   //   await customDialogManager
                            //                   //       .showCustomDialog(
                            //                   //     icon: Icons.airlines_rounded,
                            //                   //     message: resultado['mensaje'],
                            //                   //     title: resultado['mensaje'],
                            //                   //     color: const Color.fromARGB(
                            //                   //         255, 244, 54, 54),
                            //                   //   );
                            //                   // }
                            //                 },
                            //         ),
                            //       ],
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('data');
                    // return Text(snapshot.error.toString());
                  } else if (snapshot.hasData &&
                      snapshot.data!['mensaje'] != null) {
                    return const Text('data');
                    // return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return const Cargando();
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: const MyBottomNavigationBar(
          selectedIndex: 1,
        ),
      ),
    );
  }
}

//void datos(codigoPostal) {
//  final GetCopo auth = GetCopo();
//  auth.getCopo(codigoPostal);
//}

textosFijo10(context, texto) {
  return Padding(
    padding: EdgeInsets.all(displayWidth(context) * 0.02),
    child: SizedBox(
      child: Text(
        texto,
        style: TextStyle(fontSize: displayWidth(context) * 0.05),
      ),
    ),
  );
}

textost10(BuildContext context, String? texto) {
  return SizedBox(
    width: displayWidth(context) * 0.4,
    child: Padding(
      padding: EdgeInsets.all(displayWidth(context) * 0.03),
      child: Text(
        '$texto',
        style: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
        ),
      ),
    ),
  );
}
