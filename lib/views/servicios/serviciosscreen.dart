import '../../libs/lib.dart';

class ServiciosScreen extends ConsumerStatefulWidget {
  const ServiciosScreen({super.key});
  @override
  ServiciosState createState() => ServiciosState();
}

class ServiciosState extends ConsumerState<ServiciosScreen> {
  @override
  Widget build(BuildContext context) {
    // var datos = getdatos();
    Future<bool> showExitPopup() async {
      return await showDialog(
            //show confirm dialogue
            //the return value will be from "Yes" or "No" options
            context: context,
            builder: (context) => const SingleChildScrollView(
              child: Salirdeapp(
                message: 'salir',
                title: 'salir',
                icon: Icons.exit_to_app,
                color: Color.fromARGB(221, 255, 0, 0),
              ),
            ),
          ) ??
          false; //if showDialouge had returned null, then return false
    }

    return WillPopScope(
      onWillPop: showExitPopup,
      child: Scaffold(
        //  appBar: AppBar(
        //    title: const Text('portal empleado nach'),
        //    backgroundColor: const Color.fromARGB(255, 5, 23, 183),
        //  ),
        //drawer: const MenuLateral(),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/fondo_blanco.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  tarjeta(context),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 1.0, bottom: 1.0, left: 8.0, right: 8.0),
                      child: Consumer(builder: (context, watch, child) {
                        final postMisserviciosProvider =
                            ref.watch(postMisserviciosProviders);
                        return postMisserviciosProvider.when(
                          data: (data) {
                            if (data["success"] != null && data["success"]) {
                              // Procesar y mostrar datos en DataTable
                              // print(data['servicios'][0]["nombre_servicio"]);
                              List<Widget> buildServiciosItems(
                                  BuildContext context,
                                  List<dynamic> servicios) {
                                List<Widget> items = [];

                                for (var servicio in servicios) {
                                  items.add(item(
                                    context,
                                    servicio["imagen_servicio"],
                                    servicio["nombre_servicio"],
                                    servicio["descripcion_servicio"],
                                    servicio["ruta_servicio"],
                                  ));
                                }

                                return items;
                              }

                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: buildServiciosItems(
                                    context, data['servicios']),
                              );
                            } else {
                              // Manejar caso en que rows es nulo o vacío
                              return Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 3,
                                      height: 100,
                                      child: const Text(
                                        "No se encontraron servicios.",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 1),
                                        ),
                                        textAlign: TextAlign
                                            .left, // Set the text alignment to the left
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          },
                          loading: () => Center(
                              child: Padding(
                            padding: const EdgeInsets.all(40.0),
                            child: SizedBox(
                              width: displayWidth(context) * 0.8,
                              child: const Column(
                                children: [
                                  Cargando(),
                                ],
                              ),
                            ),
                          )),
                          error: (error, stackTrace) {
                            // Manejar el error de la solicitud
                            return Center(child: Text('Error: $error'));
                          },
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: const MyBottomNavigationBar(
          selectedIndex: 1,
        ),
      ),
    );
  }

  Card tarjeta(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(displayWidth(context) * 0.1),
        //set border radius more than 50% of height and width to make circle
      ),
      child: Container(
        // width: displayWidth(context),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(displayWidth(context) * 0.1),
            bottomLeft: Radius.circular(displayWidth(context) * 0.1),
          ),
          image: const DecorationImage(
              image: AssetImage(
                "assets/images/fondo_azul.png",
              ),
              fit: BoxFit.cover),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              FutureBuilder<String>(
                  // get the languageCode, saved in the preferences
                  future: SharedPreferencesHelper.getdatos('nombreCompleto'),
                  initialData: '',
                  builder:
                      (BuildContext context, AsyncSnapshot<String> snapshot) {
                    return snapshot.hasData
                        ? Padding(
                            padding: EdgeInsets.only(
                                top: displayWidth(context) * 0.1),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            displayWidth(context) * 0.05,
                                        vertical: displayWidth(context) * 0.11),
                                    child: Row(
                                      children: [
                                        SizedBox(
                                          width: displayWidth(context) * 0.5,
                                          height: displayWidth(context) * 0.20,
                                          child: Column(
                                            children: [
                                              Expanded(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 12.0),
                                                  child: Text(
                                                    "¡Hola!",
                                                    style: TextStyle(
                                                      fontSize: displayWidth(
                                                              context) *
                                                          0.05,
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              255,
                                                              255,
                                                              255),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 12.0),
                                                child: Text(
                                                  snapshot.data.toString(),
                                                  style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.03,
                                                    color: const Color.fromARGB(
                                                        255, 255, 255, 255),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: SizedBox(
                                            width: displayWidth(context) * 0.25,
                                            height:
                                                displayWidth(context) * 0.11,
                                          ),
                                        ),
                                        Container(
                                          width: displayWidth(context) * 0.11,
                                          height: displayWidth(context) * 0.11,
                                          decoration: const BoxDecoration(
                                            image: DecorationImage(
                                                image: AssetImage(
                                                  "assets/images/logo_sesion.png",
                                                ),
                                                fit: BoxFit.cover),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 3),
                                    child: Text(
                                      'SERVICIOS',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: displayWidth(context) * 0.15,
                                        color: const Color.fromARGB(
                                            255, 248, 248, 248),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 1, vertical: 20),
                                    child: Text(
                                      'SOLICITUDES DEL EMPLEADO',
                                      style: TextStyle(
                                        fontSize: displayWidth(context) * 0.035,
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Container();
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

item(context, imagen, texto1, texto2, ruta) {
  Uint8List bytes = base64.decode(imagen);
  final image = MemoryImage(bytes);
  return Padding(
    padding: EdgeInsets.only(top: displayWidth(context) * 0.05),
    child: ElevatedButton(
      //onPressed: () => ()),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
        ), // This is what you need!
      ),
      onPressed: () {},
      child: SizedBox(
        width: displayWidth(context) * 0.8,
        child: Row(
          children: [
            Center(
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(displayWidth(context) * 0.05),
                    child: SizedBox(
                      width: displayWidth(context) * 0.25,
                      child: Image(
                        image: image,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: displayWidth(context) * 0.5,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: displayWidth(context) * 0.08),
                          child: Text(
                            texto1,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 0, 0, 0),
                                fontSize: displayWidth(context) * 0.04),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(displayWidth(context) * 0.02),
                          child: Text(texto2,
                              style: TextStyle(
                                  color: const Color.fromARGB(255, 0, 0, 0),
                                  fontSize: displayWidth(context) * 0.035)),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: displayWidth(context) * 0.02),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, ruta);

                              print(ruta);
                              // Future<String> html =
                              // SharedPreferencesHelper.getdatos(
                              //         'imagen_emplaedo')
                              //     .then((value) =>
                              //         checafirma(value, context, ruta));
                            },
                            //  onPressed: () => authinticateS(
                            //      contrasena.text,
                            //      usuario.text,
                            //      context
                            // ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 5, 50, 91),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    displayWidth(context) * 0.02),
                              ), // This is what you need!
                            ),
                            child: SizedBox(
                              width: displayWidth(context) * 0.2,
                              child: Center(
                                child: Text('Solicitar',
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.04,
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

checafirma(String value, context, ruta) {
  try {
    if (value == "") {
      //   showExitPopup(context);
    } else {
      Navigator.pushNamed(context, ruta);
    }
  } catch (e) {
    if (kDebugMode) {
      //print(e);
    }
  }
}


//
//class MenuLateral extends StatelessWidget {
//  const MenuLateral({super.key});
//
//  @override
//  Widget build(BuildContext context) {
//    return Drawer(
//      backgroundColor: const Color.fromARGB(255, 5, 23, 183),
//      child: ListView(
//        children: <Widget>[
//          Center(
//            child: Padding(
//              padding: const EdgeInsets.all(4.0),
//              child: Row(
//                children: const [
//                  Text("HOME"),
//                  Center(
//                    child: SizedBox(
//                      width: 100,
//                      child: Image(
//                        image: AssetImage(
//                          "assets/images/NACHlogotipo.png",
//                        ),
//                      ),
//                    ),
//                    // fit: BoxFit.cover,
//                  ),
//                ],
//              ),
//            ),
//          ),
//          Ink(
//            color: Colors.indigo,
//            // ignore: prefer_const_constructors
//            child: ListTile(
//              title: const Text(
//                "Inicio",
//              ),
//            ),
//          ),
//          ListTile(
//            title: const Text("Datos generales"),
//            onTap: () {},
//          ),
//          ListTile(
//            title: const Text("Caja ahorro / prestamos"),
//            onTap: () {},
//          ),
//          ListTile(
//            title: const Text("Solicitudes de empleado"),
//            onTap: () {},
//          ),
//          ListTile(
//            title: const Text("Valores agregados"),
//            onTap: () {},
//          ),
//          ListTile(
//            title: const Text("Recibos Nomina"),
//            onTap: () {},
//          ),
//          ListTile(
//            title: const Text("Adelanto de nomina"),
//            onTap: () {},
//          ),
//          ListTile(
//            title: const Text("cerrar sesion"),
//            onTap: () {
//              SharedPreferencesHelper.setdatos("usuario", "");
//              SharedPreferencesHelper.setdatos("contrasena", "");
//              SharedPreferencesHelper.setdatos("token", "");
//              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//            },
//          )
//        ],
//      ),
//    );
//  }
//}
//