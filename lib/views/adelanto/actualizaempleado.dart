import '../../api/actualizadatosempleado.dart';
import '../../api/apiadelanto.dart';
import '../../libs/lib.dart';

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
  Map<String, String> someMap = {};

  @override
  Widget build(BuildContext context) {
    final customDialogManager = CustomDialogManager(context);
    final navegador = NavegadorDeRuta(context);
    // var datos = getdatos();
    telefonof = FocusNode();
    emailf = FocusNode();
    return Scaffold(
      //  appBar: AppBar(
      //    title: const Text('portal empleado nach'),
      //    backgroundColor: const Color.fromARGB(255, 5, 23, 183),
      //  ),
      //drawer: const MenuLateral(),
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
                                      textot1(context, 'Nombre(s) *'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: nombret,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'nombrese', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color: Color.fromARGB(
                                                    240, 190, 191, 194),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(context, 'Apellido Paterno'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: apellidoPaternot,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'apellidoPaternoe', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'Apellido Materno'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: apellidoMaternot,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'apellidoMaternoe', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(
                                          context, 'Folio de consulta Buro'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: folioConsultat,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'CURP'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
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
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(context, 'Código postal'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: direccionCpt,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'direccionCp', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'Calle'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: direccionCallet,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'direccionCalle', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(context, 'Número exterior'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: direccionExtt,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'direccionExt', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'Número interior'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: direccionIntt,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'direccionInt', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(context, 'Municipio'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: direccionMunicipiot,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'Municipio', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      240, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'Colonia'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: direccionColoniat,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'Colonia', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(context, 'Estado'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: direccionEstadot,
                                          onChanged: (value) {
                                            SharedPreferencesHelper.setdatos(
                                                'Estado', value);
                                          },
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    0, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'Lugar de nacimiento'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: lugardenact,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(context, 'Fecha de nacimiento'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: fechadenact,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    0, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'Nacionalidad'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: nacionalidadt,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(context, 'Género'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: generot,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color:
                                                    Color.fromARGB(0, 5, 5, 5),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    0, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'Email'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
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
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: const Color.fromARGB(
                                                0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color: Color.fromARGB(
                                                    textomarcoemail, 255, 0, 0),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  textomarcoemail, 251, 16, 4),
                                            )),
                                            border: const OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      textot1(context, 'País'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
                                        child: TextFormField(
                                          controller: paist,
                                          readOnly: true,
                                          style: const TextStyle(
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 0, 54, 215),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color: Color.fromARGB(
                                                    0, 247, 0, 0),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color: Color.fromARGB(
                                                  0, 190, 191, 194),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    0, 5, 49, 91)),
                                          ),
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
                                      textot1(context, 'Teléfono'),
                                      SizedBox(
                                        width: displayWidth(context) * 0.45,
                                        height: 60,
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
                                          decoration: const InputDecoration(
                                            filled: true,
                                            fillColor:
                                                Color.fromARGB(0, 229, 4, 4),
                                            focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              borderSide: BorderSide(
                                                width: 2, //<-- SEE HERE
                                                color: Color.fromARGB(
                                                    0, 254, 0, 0),
                                              ),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                              width: 5, //<-- SEE HERE
                                              color:
                                                  Color.fromARGB(0, 254, 0, 0),
                                            )),
                                            border: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                  width: 5, //<-- SEE HERE
                                                  color: Color.fromARGB(
                                                      0, 190, 191, 194),
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(5.0))),
                                            labelStyle: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 5, 49, 91)),
                                          ),
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
                                        Visibility(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: displayWidth(context) *
                                                    0.02),
                                            child: ElevatedButton(
                                              // onPressed: ,
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    const Color.fromARGB(
                                                        255, 123, 124, 124),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          displayWidth(
                                                                  context) *
                                                              0.02),
                                                ), // This is what you need!
                                              ),
                                              onPressed: () async {
                                                final enviaDatosEmpleado =
                                                    EnviaDatosEmpleadoClass();
                                                final resultado =
                                                    await enviaDatosEmpleado
                                                        .enviaDatos();
                                                if (resultado['success'] ==
                                                    false) {
                                                  await customDialogManager
                                                      .showCustomDialog(
                                                    icon:
                                                        Icons.airlines_rounded,
                                                    message:
                                                        resultado['mensaje'],
                                                    title: resultado['mensaje'],
                                                    color: const Color.fromARGB(
                                                        255, 244, 54, 54),
                                                  );
                                                }

                                                if (resultado.isNotEmpty) {
                                                  // Navigator
                                                  //     .pushNamedAndRemoveUntil(
                                                  //         context,
                                                  //         'valores_pedir_adelanto',
                                                  //         (route) => false);
                                                  await navegador.algunlugar(
                                                      'valores_pedir_adelanto');
                                                }

                                                // print(resultado['success']);
                                              },
                                              child: SizedBox(
                                                width:
                                                    displayWidth(context) * 0.6,
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
      ),
      bottomNavigationBar: bottomNachBar(context, 1),
    );
  }
}

//void datos(codigoPostal) {
//  final GetCopo auth = GetCopo();
//  auth.getCopo(codigoPostal);
//}

textoFijo(context, texto) {
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

textot1(BuildContext context, String? texto) {
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

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }
}
