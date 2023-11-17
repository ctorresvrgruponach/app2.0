import '../../api/apiadelanto.dart';
import '../../api/pediradelantoapi.dart';
import '../../libs/lib.dart';

String? html;
bool readmonto = false;
String? montototal;
String? comisiontotal;
String? montoenviar;
String? idopselect;
bool ishiden = false;
bool ishiden2 = false;
bool ishiden20 = true;
bool ishiden4 = false;
bool hidendobleIne = true;
bool hidendobleCurp = true;
bool isLoading = false;
bool enviados = true;
bool isblank = true;
bool btnsolicitaPrestamo = false;

bool visibleBt = false;
int textomarcoemail = 0;
String? salarioMensual;
String? montoMaximoAdelanto;
String? folioConsulta;
String? curp;

String? actualizadireccionEstado;
String? actualizadireccionExt;
String? actualizadireccionInt;
String? actualizadireccionMunicipio;
String? actualizacurp;

String? actualizadireccionColonia;
String? actualizadireccionCp;
String? actualizanombre;
String? actualizaapellidoMaterno;
String? actualizaapellidoPaterno;

String? actualizacorreo;
String? actualizatelefono;

class ValoresPedirAdelantoScreen extends ConsumerStatefulWidget {
  const ValoresPedirAdelantoScreen({super.key});
  @override
  ValoresPedirAdelantoScreenState createState() =>
      ValoresPedirAdelantoScreenState();
}

class ValoresPedirAdelantoScreenState
    extends ConsumerState<ValoresPedirAdelantoScreen> {
  @override
  void initState() {
    super.initState();
  }

  var textomarcoemail = 255;

  double _currentSliderValue = 100;
  TextEditingController monto = TextEditingController();
  double montomaximo = 1;

  TextEditingController comision = TextEditingController();
  TextEditingController tdescontar = TextEditingController();
  TextEditingController nombret = TextEditingController();
  TextEditingController correo = TextEditingController();
  TextEditingController sueldoMensual = TextEditingController();

  TextEditingController telefonot = TextEditingController();
  TextEditingController emailt = TextEditingController();
  Map<String, String> someMap = {};

  @override
  Widget build(BuildContext context) {
    // var datos = getdatos();

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              FutureBuilder<Map<String, dynamic>>(
                future: ref.watch(postPedirAdelantoProviders.future),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!['informacion_adelanto'] != null) {
                    if (kDebugMode) {
                      print(snapshot.data!);
                    }
                    final operaciones = snapshot.data!['informacion_adelanto'];
                    sueldoMensual.text =
                        operaciones['salario_mensual'].toString();

                    correo.text = operaciones['email'].toString();
                    String periodosPagos;

                    if (operaciones["tipo_nomina"] == 'Semanal') {
                      periodosPagos = '52';
                    } else if (operaciones["tipo_nomina"] == 'Catorcenal') {
                      periodosPagos = '26';
                    } else if (operaciones["tipo_nomina"] == 'Quincenal') {
                      periodosPagos = '24';
                    } else if (operaciones["tipo_nomina"] == 'Mensual') {
                      periodosPagos = '12';
                    } else if (operaciones["tipo_nomina"] == 'Unidad obra') {
                      periodosPagos = '17';
                    } else {
                      periodosPagos = '';
                    }
                    SharedPreferencesHelper.setdatos(
                        "periodosPagos", periodosPagos);
                    final customDialogManager = CustomDialogManager(context);

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
                            textoFijo10(context, 'Sueldo Mensual'),
                            SizedBox(
                              child: TextFormField(
                                readOnly: true,
                                controller: sueldoMensual,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      //r'^[-]{0,1}[0-9]*[,]?[0-9]*', //signed regex
                                      r'[1-9]*[.]?[0-9]',
                                    ),
                                  ),
                                ],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(128, 190, 191, 194),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      width: 2, //<-- SEE HERE
                                      color: Color.fromARGB(255, 190, 191, 194),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 5, //<-- SEE HERE
                                        color:
                                            Color.fromARGB(128, 190, 191, 194),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 5, 50, 91)),
                                ),
                              ),
                            ),
                            textoFijo10(context, 'Monto a Solicitar'),
                            SizedBox(
                              child: Slider(
                                activeColor:
                                    const Color.fromARGB(255, 5, 50, 91),
                                inactiveColor:
                                    const Color.fromARGB(255, 120, 120, 120),
                                value: _currentSliderValue,
                                max: double.parse(
                                    operaciones['monto_real_prestamo']),
                                min: 100,
                                // divisions: 6,
                                label: _currentSliderValue
                                    .round()
                                    .toStringAsFixed(2),
                                onChanged: readmonto
                                    ? null
                                    : (double value) {
                                        SharedPreferencesHelper.setdatos(
                                            "montoapedir", monto.text);
                                        setState(() {
                                          _currentSliderValue = value;
                                          monto.text = _currentSliderValue
                                              .toStringAsFixed(2);

                                          montototal = monto.text;

                                          comision.text =
                                              ((_currentSliderValue * 0.13)
                                                  .toStringAsFixed(2));

                                          comisiontotal = comisiontotal =
                                              (double.parse(comision.text) +
                                                      (double.parse(
                                                              comision.text) *
                                                          0.16))
                                                  .toString();
                                          SharedPreferencesHelper.setdatos(
                                              "comision", comisiontotal);
                                          montoenviar = monto.text;
                                          sueldoMensual.text =
                                              salarioMensual.toString();

                                          tdescontar.text =
                                              ((((_currentSliderValue * 0.13) +
                                                          (_currentSliderValue *
                                                                  0.13) *
                                                              0.16) +
                                                      _currentSliderValue)
                                                  .toStringAsFixed(2));
                                          SharedPreferencesHelper.setdatos(
                                              "totaldescontar",
                                              tdescontar.text);
                                        });
                                      },
                              ),
                            ),
                            SizedBox(
                              child: TextFormField(
                                controller: monto,
                                readOnly: readmonto,
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      //r'^[-]{0,1}[0-9]*[,]?[0-9]*', //signed regex
                                      r'[1-9]*[.]?[0-9]',
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  SharedPreferencesHelper.setdatos(
                                      "montoapedir", monto.text);
                                  if (double.parse(monto.text) > 100) {
                                    setState(() {
                                      if (monto.text != '') {
                                        if (double.parse(monto.text) <
                                            montomaximo) {
                                          _currentSliderValue =
                                              double.parse(monto.text);
                                          comision.text =
                                              (((_currentSliderValue * 0.13))
                                                  .toStringAsFixed(2));
                                          montoenviar = monto.text;
                                          tdescontar.text =
                                              ((((_currentSliderValue * 0.13) +
                                                          (_currentSliderValue *
                                                                  0.13) *
                                                              0.16) +
                                                      _currentSliderValue)
                                                  .toStringAsFixed(2));
                                          SharedPreferencesHelper.setdatos(
                                              "totaldescontar",
                                              tdescontar.text);
                                          comisiontotal = (double.parse(
                                                      comision.text) +
                                                  (double.parse(comision.text) *
                                                      0.16))
                                              .toString();
                                          SharedPreferencesHelper.setdatos(
                                              "comision", comisiontotal);
                                        } else {
                                          _currentSliderValue = montomaximo;
                                          monto.text = '$montomaximo';
                                          montoenviar = monto.text;
                                          comision.text =
                                              (((_currentSliderValue * 0.13))
                                                  .toStringAsFixed(2));

                                          comisiontotal = (double.parse(
                                                      comision.text) +
                                                  (double.parse(comision.text) *
                                                      0.16))
                                              .toString();
                                          SharedPreferencesHelper.setdatos(
                                              "comision", comisiontotal);
                                          tdescontar.text =
                                              ((((_currentSliderValue * 0.13) +
                                                          (_currentSliderValue *
                                                                  0.13) *
                                                              0.16) +
                                                      _currentSliderValue)
                                                  .toStringAsFixed(2));
                                          SharedPreferencesHelper.setdatos(
                                              "totaldescontar",
                                              tdescontar.text);
                                        }
                                      }
                                    });
                                  } else {}
                                },
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(128, 190, 191, 194),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      width: 2, //<-- SEE HERE
                                      color: Color.fromARGB(128, 190, 191, 194),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 5, //<-- SEE HERE
                                        color:
                                            Color.fromARGB(128, 190, 191, 194),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 5, 50, 91)),
                                ),
                              ),
                            ),
                            textoFijo10(context, 'Comisión'),
                            SizedBox(
                              child: TextFormField(
                                readOnly: true,
                                controller: comision,
                                onChanged: (value) {
                                  SharedPreferencesHelper.setdatos(
                                      "comision", value);
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      //r'^[-]{0,1}[0-9]*[,]?[0-9]*', //signed regex
                                      r'[1-9]*[.]?[0-9]',
                                    ),
                                  ),
                                ],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(128, 190, 191, 194),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      width: 2, //<-- SEE HERE
                                      color: Color.fromARGB(255, 190, 191, 194),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 5, //<-- SEE HERE
                                        color:
                                            Color.fromARGB(128, 190, 191, 194),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  labelStyle: TextStyle(
                                      color: Color.fromARGB(255, 5, 50, 91)),
                                ),
                              ),
                            ),
                            textoFijo10(context, 'Total a descontar'),
                            SizedBox(
                              child: TextFormField(
                                readOnly: true,
                                controller: tdescontar,
                                onChanged: (value) {
                                  SharedPreferencesHelper.setdatos(
                                      "totaldescontar", value);
                                },
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                    RegExp(
                                      //r'^[-]{0,1}[0-9]*[,]?[0-9]*', //signed regex
                                      r'[1-9]*[.]?[0-9]',
                                    ),
                                  ),
                                ],
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 5, 50, 91)),
                                keyboardType:
                                    const TextInputType.numberWithOptions(),
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Color.fromARGB(128, 190, 191, 194),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5.0)),
                                    borderSide: BorderSide(
                                      width: 2, //<-- SEE HERE
                                      color: Color.fromARGB(255, 190, 191, 194),
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 5, //<-- SEE HERE
                                        color:
                                            Color.fromARGB(128, 190, 191, 194),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0))),
                                  labelStyle: TextStyle(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                              ),
                            ),
                            textoFijo10(
                                context, 'Correo electrónico (obligatorio)'),
                            SizedBox(
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  controller: correo,
                                  onChanged: (text) {},
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 5, 50, 91)),
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(128, 190, 191, 194),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        width: 2, //<-- SEE HERE
                                        color: Color.fromARGB(0, 237, 0, 0),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0.1, //<-- SEE HERE
                                        color:
                                            Color.fromARGB(128, 190, 191, 194),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    labelText: 'Correo',
                                    labelStyle: TextStyle(
                                        color: Color.fromARGB(255, 5, 50, 91)),
                                    iconColor:
                                        Color.fromARGB(255, 255, 255, 255),
                                  ),
                                ),
                              ),
                            ),
                            Stack(
                              children: [
                                Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color.fromARGB(
                                              someMap["boton"] != "boton"
                                                  ? 255
                                                  : 50,
                                              5,
                                              50,
                                              91),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                                displayWidth(context) * 0.02),
                                          ),
                                        ),
                                        onPressed: () async {
                                          Navigator.pushNamed(
                                              context, 'vista_html');

                                          setState(() {
                                            // ishiden = true;
                                          });
                                        },
                                        child:
                                            const Text("Ver contrato y anexos"),
                                      ),
                                    ),
                                    const Botonfile(
                                      texto: 'INE',
                                    ),
                                    const Botonfile(
                                      texto: 'Comprobante',
                                    ),
                                    const Botonfile(
                                      texto: 'CURP',
                                    ),
                                    Botonc(
                                      texto: 'Aceptar Adelanto',
                                      onPressed: btnsolicitaPrestamo
                                          ? null
                                          : () async {
                                              setState(() {
                                                btnsolicitaPrestamo = true;
                                              });
                                              final instanciaEnviaAdelanto =
                                                  EnviaAdelantoClass();
                                              final resultado =
                                                  await instanciaEnviaAdelanto
                                                      .enviaadelanto();
                                              await customDialogManager
                                                  .showCustomDialog(
                                                icon: Icons.airlines_rounded,
                                                message: resultado['mensaje'],
                                                title: resultado['mensaje'],
                                                color: const Color.fromARGB(
                                                    255, 244, 54, 54),
                                              );
                                            },
                                    ),
                                  ],
                                ),
                              ],
                            ),
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

textoFijo10(context, texto) {
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

textot10(BuildContext context, String? texto) {
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
