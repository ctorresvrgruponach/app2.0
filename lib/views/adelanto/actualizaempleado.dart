import '../../ui/decoracioninput.dart';
import '../../api/actualizadatosempleado.dart';
import '../../api/apiadelanto.dart';
import '../../libs/lib.dart';
import '../docshtml/documentodeidentidad.dart';

class ActualizaEmpleadoScreen extends ConsumerStatefulWidget {
  const ActualizaEmpleadoScreen({super.key});
  @override
  ActualizaEmpleadoScreenState createState() => ActualizaEmpleadoScreenState();
}

class ActualizaEmpleadoScreenState
    extends ConsumerState<ActualizaEmpleadoScreen> {
  @override
  void initState() {
    super.initState();
  }

  var textomarcoemail = 0;
  var textomarco = 0;
  late FocusNode telefonof;
  late FocusNode emailf;
  var selectedEstado = 0;

  TextEditingController monto = TextEditingController();
  double montomaximo = 1;
  TextEditingController curpt = TextEditingController();
  TextEditingController apellidoMaternot = TextEditingController();
  TextEditingController apellidoPaternot = TextEditingController();
  TextEditingController comision = TextEditingController();
  TextEditingController tdescontar = TextEditingController();
  TextEditingController nombret = TextEditingController();
  TextEditingController correo = TextEditingController();

  TextEditingController folioConsultat = TextEditingController();
  TextEditingController direccionCpt = TextEditingController();
  TextEditingController direccionExtt = TextEditingController();
  TextEditingController direccionIntt = TextEditingController();
  TextEditingController direccionMunicipiot = TextEditingController();

  TextEditingController direccionEstadot = TextEditingController();
  TextEditingController direccionColoniat = TextEditingController();
  TextEditingController direccionCallet = TextEditingController();
  TextEditingController lugardenact = TextEditingController();
  TextEditingController fechadenact = TextEditingController();
  TextEditingController nacionalidadt = TextEditingController();
  TextEditingController generot = TextEditingController();

  TextEditingController paist = TextEditingController();
  TextEditingController telefonot = TextEditingController();
  TextEditingController emailt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final String argumento1;
    List<dynamic> argumentos = [''];
    final argumentosw = ModalRoute.of(context)?.settings.arguments;
    if (argumentosw is List<dynamic>) {
      argumento1 = argumentosw[0] as String;
    } else {
      argumento1 = 'home';
    }

    final navegador = NavegadorDeRuta(context, argumentos);
    //InputDecoration decoration = CustomInputDecoration.getDecoration();
    CustomTitulo customTitulo = CustomTitulo();
    PdfGenerator pdfGenerator = PdfGenerator(context);
    double resultadoResta = 0.0;

    // var datos = getdatos();
    telefonof = FocusNode();
    emailf = FocusNode();
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 5, 50, 91),
      body: SingleChildScrollView(
        child: SafeArea(
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
                    Datosgenerales datosGenerales = Datosgenerales();
                    final operaciones = snapshot.data!['informacion_adelanto'];
                    final folioConsulta = snapshot.data!['folio_consulta'];

                    // final estados = snapshot.data!['estados'];
                    final prestamosAnteriores =
                        operaciones['prestamosAnteriores'];
                    final montoRealPrestamo =
                        operaciones['monto_real_prestamo'];

                    double? prestamosAnterioresNumero =
                        double.tryParse(prestamosAnteriores?.toString() ?? '');
                    double? montoRealPrestamoNumero =
                        double.tryParse(montoRealPrestamo?.toString() ?? '');

                    if (prestamosAnterioresNumero != null &&
                        montoRealPrestamoNumero != null) {
                      // Realizar la resta
                      resultadoResta =
                          montoRealPrestamoNumero - prestamosAnterioresNumero;

                      // Verificar la condición
                      if (resultadoResta < 100) {
                        if (kDebugMode) {
                          print(resultadoResta);
                        }
                      }
                    }

                    nombret.text = snapshot.data!['nombres'].toString();
                    apellidoMaternot.text =
                        snapshot.data!['apellidoMaterno'].toString();
                    apellidoPaternot.text =
                        snapshot.data!['apellidoPaterno'].toString();
                    curpt.text = operaciones['curp'].toString();
                    direccionCpt.text = operaciones['direccion_cp'].toString();
                    direccionCallet.text =
                        operaciones['direccion_calle'].toString();
                    direccionColoniat.text =
                        operaciones['direccion_colonia'].toString();
                    direccionEstadot.text =
                        operaciones['direccion_estado'].toString();
                    direccionMunicipiot.text =
                        operaciones['direccion_municipio'].toString();
                    direccionExtt.text =
                        operaciones['direccion_ext'].toString();
                    direccionIntt.text =
                        operaciones['direccion_int'].toString();
                    emailt.text = operaciones['email'].toString();
                    telefonot.text = operaciones['telefono'].toString();
                    paist.text = datosGenerales
                        .funcioncurppais(operaciones['curp'].toString());
                    generot.text = datosGenerales
                        .funcioncurpgen(operaciones['curp'].toString());
                    lugardenact.text = datosGenerales
                        .funcioncurpln(operaciones['curp'].toString());
                    fechadenact.text = datosGenerales
                        .funcioncurpfn(operaciones['curp'].toString());
                    nacionalidadt.text = datosGenerales
                        .funcioncurpna(operaciones['curp'].toString());
                    folioConsultat.text = folioConsulta.toString();

                    SharedPreferencesHelper.setdatos('nombrese', nombret.text);
                    SharedPreferencesHelper.setdatos(
                        'apellidoPaternoe', apellidoPaternot.text);
                    SharedPreferencesHelper.setdatos(
                        'apellidoMaternoe', apellidoMaternot.text);
                    SharedPreferencesHelper.setdatos('curpe', curpt.text);
                    SharedPreferencesHelper.setdatos(
                        'direccionCp', direccionCpt.text);
                    SharedPreferencesHelper.setdatos(
                        'direccionCalle', direccionCallet.text);
                    SharedPreferencesHelper.setdatos(
                        'direccionInt', direccionIntt.text);
                    SharedPreferencesHelper.setdatos(
                        'direccionExt', direccionExtt.text);
                    SharedPreferencesHelper.setdatos(
                        'direccionMunicipio', direccionMunicipiot.text);
                    SharedPreferencesHelper.setdatos(
                        'direccionColonia', direccionColoniat.text);
                    SharedPreferencesHelper.setdatos(
                        'claveEstado', operaciones['clave_estado'].toString());
                    SharedPreferencesHelper.setdatos(
                        'direccionEstado', direccionEstadot.text);
                    SharedPreferencesHelper.setdatos(
                        'telefono', telefonot.text);
                    SharedPreferencesHelper.setdatos('email', emailt.text);
                    SharedPreferencesHelper.setdatos(
                        'rfc', operaciones['RFC'].toString());
                    List<dynamic> estadosList = snapshot.data!['estados'] ?? [];

                    // Convierte la lista a una lista de cadenas (String)
                    List<Map<String, dynamic>> estadosData =
                        estadosList.cast<Map<String, dynamic>>();

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * 0.1),
                        //set border radius more than 50% of height and width to make circle
                      ),
                      child: Container(
                        // width: displayWidth(context),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft:
                                Radius.circular(displayWidth(context) * 0.1),
                            topRight:
                                Radius.circular(displayWidth(context) * 0.1),
                            bottomRight:
                                Radius.circular(displayWidth(context) * 0.1),
                            bottomLeft:
                                Radius.circular(displayWidth(context) * 0.1),
                          ),
                          image: const DecorationImage(
                              image: AssetImage(
                                "assets/images/fondo_azul.png",
                              ),
                              fit: BoxFit.cover),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 20.0, bottom: 10, left: 0, right: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Nombre(s) *'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: nombret,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'nombrese', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Apellido Paterno'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: apellidoPaternot,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'apellidoPaternoe', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 20, left: 0, right: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Apellido Materno'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: apellidoMaternot,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'apellidoMaternoe', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Folio de consulta Buro'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: folioConsultat,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 20, left: 0, right: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(context, 'CURP'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: curpt,
                                          readOnly: true,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'curpe', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Código postal'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: direccionCpt,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'direccionCp', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 20, left: 0, right: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(context, 'Calle'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: direccionCallet,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'direccionCalle', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Número exterior'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: direccionExtt,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'direccionExt', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10.0, bottom: 0, left: 0, right: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Número interior'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: direccionIntt,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'direccionInt', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Municipio'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: direccionMunicipiot,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'Municipio', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 0, left: 0, right: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(context, 'Colonia'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: direccionColoniat,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'Colonia', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(context, 'Estado'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: Column(
                                          children: [
                                            DropdownButton<
                                                Map<String, dynamic>>(
                                              dropdownColor:
                                                  const Color.fromARGB(
                                                      255, 5, 49, 91),
                                              style: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 255, 255, 255),
                                              ),
                                              value: selectedEstado != 0
                                                  ? estadosData[selectedEstado]
                                                  : estadosData[int.parse(
                                                          operaciones[
                                                                  'id_estado']
                                                              .toString()) -
                                                      1],
                                              items: estadosData
                                                  .map((estado) =>
                                                      DropdownMenuItem<
                                                          Map<String, dynamic>>(
                                                        value: estado,
                                                        child: Text(estado[
                                                            'direccion_estado']),
                                                      ))
                                                  .toList(),
                                              onChanged: (newValue) {
                                                // Manejar el cambio de valor aquí
                                                nuevo(newValue);
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 0, left: 0, right: 0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Lugar de nacimiento'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: lugardenact,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Fecha de nacimiento'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: fechadenact,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 0, left: 0, right: 0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(
                                          context, 'Nacionalidad'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: nacionalidadt,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(context, 'Género'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: generot,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 0, left: 0, right: 0),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(context, 'Email'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: emailt,
                                          focusNode: emailf,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'email', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      customTitulo.textot1(context, 'País'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: paist,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 0.0, bottom: 0, left: 0, right: 20),
                              child: Row(
                                children: [
                                  Column(
                                    children: [
                                      customTitulo.textot1(context, 'Teléfono'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 80,
                                        child: TextFormField(
                                          controller: telefonot,
                                          focusNode: telefonof,
                                          maxLength: 10,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'telefono', value);
                                          },
                                          keyboardType: TextInputType.phone,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: CustomInputDecoration
                                              .getDecoration(),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  top: 0.0,
                                  bottom: displayWidth(context) * 0.09,
                                  left: displayWidth(context) * 0.08,
                                  right: 20),
                              child: Center(
                                child: Row(
                                  children: [
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top:
                                                  displayWidth(context) * 0.02),
                                          child: ElevatedButton(
                                            // onPressed: ,
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  const Color.fromARGB(
                                                      255, 123, 124, 124),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        displayWidth(context) *
                                                            0.02),
                                              ), // This is what you need!
                                            ),
                                            onPressed: () async {
                                              final resulta =
                                                  pdfGenerator.generatePdf();
                                              if (await resulta) {
                                                final enviaDatosEmpleado =
                                                    EnviaDatosEmpleadoClass();
                                                final resultado =
                                                    await enviaDatosEmpleado
                                                        .enviaDatos();
                                                if (resultado['success'] ==
                                                    false) {
                                                  // await customDialogManager
                                                  //     .showCustomDialog(
                                                  //   icon:
                                                  //       Icons.airlines_rounded,
                                                  //   message:
                                                  //       resultado['mensaje'],
                                                  //   title: resultado['mensaje'],
                                                  //   color: const Color.fromARGB(
                                                  //       255, 244, 54, 54),
                                                  // );
                                                }

                                                if (resultado.isNotEmpty) {
                                                  // ignore: use_build_context_synchronously
                                                  final customDialogManager =
                                                      // ignore: use_build_context_synchronously
                                                      CustomDialogManager(
                                                          context);
                                                  if (resultadoResta < 100 &&
                                                      argumento1 ==
                                                          'valores_pedir_adelanto') {
                                                    await customDialogManager
                                                        .showCustomDialog(
                                                      icon: Icons
                                                          .airlines_rounded,
                                                      message:
                                                          'La suma de tus adelantos supera el disponible para solicitar',
                                                      title:
                                                          'La suma de tus adelantos supera el disponible para solicitar',
                                                      color:
                                                          const Color.fromARGB(
                                                              255, 244, 54, 54),
                                                    );
                                                    await navegador
                                                        .algunlugar('home');
                                                  } else {
                                                    await navegador
                                                        .algunlugar(argumento1);
                                                  }
                                                }

                                                // // print(resultado['success']);
                                              }
                                            },
                                            child: SizedBox(
                                              width:
                                                  displayWidth(context) * 0.7,
                                              child: Align(
                                                alignment: Alignment.center,
                                                child: Center(
                                                  child: Text(
                                                      'Acepto que los datos son correctos',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: displayWidth(
                                                                context) *
                                                            0.04,
                                                      )),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Text('Error');
                    // return Text(snapshot.error.toString());
                  } else if (snapshot.hasData &&
                      snapshot.data!['mensaje'] != null) {
                    return Text(snapshot.data!['mensaje']);
                    // return Text(snapshot.error.toString());
                  }
                  // By default show a loading spinner.
                  return const Cargando();
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 1,
      ),
    );
  }

  void nuevo(Map<String, dynamic>? newValue) {
    if (newValue != null) {
      setState(() {
        actualiza(newValue);
      });
      SharedPreferencesHelper.setdatos('id_estado', "${newValue['id_estado']}");
      SharedPreferencesHelper.setdatos(
          'direccionEstado', newValue['direccion_estado']);
      SharedPreferencesHelper.setdatos('claveEstado', newValue['clave_estado']);

      if (kDebugMode) {
        print('Seleccionaste el estado con id: ${newValue['id_estado']}');
      }
      if (kDebugMode) {
        print('Dirección del estado: ${newValue['direccion_estado']}');
      }
      if (kDebugMode) {
        print('Clave del estado: ${newValue['clave_estado']}');
      }
    }
  }

  void actualiza(Map<String, dynamic> newValue) {
    int? idEstado = int.tryParse(newValue['id_estado'].toString());
    selectedEstado = (idEstado! - 1);
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
