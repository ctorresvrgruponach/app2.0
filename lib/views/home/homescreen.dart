import '../../libs/lib.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> argumentos = ['home'];
    final navegador = NavegadorDeRuta(context, argumentos);
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
            )),
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
                    "assets/images/fondo_azul.png",
                  ),
                  fit: BoxFit.cover),
            ),
            child: Column(
              children: [
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(80),
                    //set border radius more than 50% of height and width to make circle
                  ),
                  child: Container(
                    // width: displayWidth(context),
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/images/fondo_blanco.png",
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
                              future: SharedPreferencesHelper.getdatos(
                                  'nombreCompleto'),
                              initialData: '',
                              builder: (BuildContext context,
                                  AsyncSnapshot<String> snapshot) {
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
                                                        displayWidth(context) *
                                                            0.05,
                                                    vertical:
                                                        displayWidth(context) *
                                                            0.11),
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: displayWidth(
                                                              context) *
                                                          0.5,
                                                      height: displayWidth(
                                                              context) *
                                                          0.20,
                                                      child: Column(
                                                        children: [
                                                          Expanded(
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      top:
                                                                          12.0),
                                                              child: Text(
                                                                "¡Hola!",
                                                                style:
                                                                    TextStyle(
                                                                  fontSize:
                                                                      displayWidth(
                                                                              context) *
                                                                          0.05,
                                                                  color: const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      5,
                                                                      50,
                                                                      91),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                        12.0),
                                                            child: Text(
                                                              snapshot.data
                                                                  .toString(),
                                                              style: TextStyle(
                                                                fontSize:
                                                                    displayWidth(
                                                                            context) *
                                                                        0.03,
                                                                color: const Color
                                                                    .fromARGB(
                                                                    255,
                                                                    5,
                                                                    50,
                                                                    91),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: SizedBox(
                                                        width: displayWidth(
                                                                context) *
                                                            0.25,
                                                        height: displayWidth(
                                                                context) *
                                                            0.11,
                                                      ),
                                                    ),
                                                    Container(
                                                      width: displayWidth(
                                                              context) *
                                                          0.11,
                                                      height: displayWidth(
                                                              context) *
                                                          0.11,
                                                      decoration:
                                                          const BoxDecoration(
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 2,
                                                        vertical: 4),
                                                child: Text(
                                                  'BIENVENIDO',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.15,
                                                    color: const Color.fromARGB(
                                                        255, 5, 50, 91),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1,
                                                        vertical: 2),
                                                child: Text(
                                                  'AL PORTAL NACH',
                                                  style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.035,
                                                    color: const Color.fromARGB(
                                                        255, 5, 50, 91),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 1,
                                                        vertical: 2),
                                                child: Text(
                                                  '¡TU PORTAL DE EMPLEADO!',
                                                  style: TextStyle(
                                                    fontSize:
                                                        displayWidth(context) *
                                                            0.035,
                                                    color: const Color.fromARGB(
                                                        255, 5, 50, 91),
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
                ),
                Padding(
                  padding: EdgeInsets.only(top: displayWidth(context) * 0.05),
                  child: ElevatedButton(
                    //onPressed: () => ()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * 0.02),
                      ), // This is what you need!
                    ),
                    onPressed: () {},
                    child: SizedBox(
                      width: displayWidth(context) * 0.8,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: displayWidth(context) * 0.4,
                              child: const Image(
                                image: AssetImage(
                                  "assets/images/inicio.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: displayWidth(context) * 0.05),
                  child: ElevatedButton(
                    //onPressed: () => ()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * 0.02),
                      ), // This is what you need!
                    ),
                    onPressed: () async {
                      await navegador.algunlugar('actualizaempleado');
                    },
                    child: SizedBox(
                      width: displayWidth(context) * 0.8,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: displayWidth(context) * 0.4,
                              child: const Image(
                                image: AssetImage(
                                  "assets/images/datos.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: displayWidth(context) * 0.05),
                  child: ElevatedButton(
                    //onPressed: () => ()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * 0.02),
                      ), // This is what you need!
                    ),
                    onPressed: () async {
                      await navegador.algunlugar('solicitudes');
                    },
                    child: SizedBox(
                      width: displayWidth(context) * 0.8,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: displayWidth(context) * 0.4,
                              child: const Image(
                                image: AssetImage(
                                  "assets/images/solicitud.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: displayWidth(context) * 0.05),
                  child: ElevatedButton(
                    //onPressed: () => ()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(displayWidth(context) * 0.02),
                      ), // This is what you need!
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, 'recibos');
                    },
                    child: SizedBox(
                      width: displayWidth(context) * 0.8,
                      child: Center(
                        child: Row(
                          children: [
                            SizedBox(
                              width: displayWidth(context) * 0.4,
                              child: const Image(
                                image: AssetImage(
                                  "assets/images/recibos.png",
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: displayWidth(context) * 0.06,
                      bottom: displayWidth(context) * 0.15),
                  child: SizedBox(
                    width: displayWidth(context) * 0.4,
                    child: const Image(
                      image: AssetImage(
                        "assets/images/NACHlogotipo.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: const MyBottomNavigationBar(
          selectedIndex: 2,
        ),
      ),
    );
  }
}
