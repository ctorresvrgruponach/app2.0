import 'package:com.gruponach.nach_empleado/config/vistas.dart';
import 'package:flutter_swiper_plus/flutter_swiper_plus.dart';
import 'package:local_auth/local_auth.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../api/apilogin.dart';
import '../../libs/lib.dart';

bool isAuthenticating = false;

class Login extends ConsumerStatefulWidget {
  const Login({super.key});
  @override
  LoginState createState() => LoginState();
}

class LoginState extends ConsumerState<Login> {
  final LocalAuthentication auth = LocalAuthentication();

  @override
  void initState() {
    super.initState();
    someFunction();
  }

  // Future<void> somelugar(int firma) async {
  //   final firmas = await SharedPreferencesHelper.getdatos('imagen_emplaedo');
  //   if (firma == 0 || firmas.isEmpty) {
  //     // ignore: use_build_context_synchronously
  //     Navigator.pushNamedAndRemoveUntil(context, 'firma', (route) => false);
  //   } else {
  //     // ignore: use_build_context_synchronously
  //     Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
  //   }
  // }


  Future<void> somelugar(int firma, String version,) async {
    // final firmas = await SharedPreferencesHelper.getdatos('imagen_emplaedo');
    PackageInfo versionApp = await PackageInfo.fromPlatform();
    if(versionApp.buildNumber == version){
      if(firma == 0){
         // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Firma( data: firma),
          ),
        );
      }else{
        // ignore: use_build_context_synchronously
        Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
      }
    }else {
      muestraAlerta();
    }
    // if (firma == 0) {
    //   // ignore: use_build_context_synchronously
    //   // Navigator.pushNamedAndRemoveUntil(context, 'firma', (route) => false);
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => Firma( data: firma),
    //       ),
    //     );
    // } else{
    //   // ignore: use_build_context_synchronously
    //   Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
    // }
  }

  Future<void> someFunction() async {
    final customDialogManager = CustomDialogManager(context);
    //print("object");
    final token = await SharedPreferencesHelper.getdatos('token');
    final imss = await SharedPreferencesHelper.getdatos('imss');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleadoId');

    String noEmpleado;
    String empleadoIMSS;
    String cerrar = '';

    isAuthenticating = true;
    final LocalAuthentication auth = LocalAuthentication();
    final isBiometricAvailable = await auth.canCheckBiometrics;

    if (token.isNotEmpty && token.length > 2) {
      //   print("object1");
      if (isBiometricAvailable) {
        //  print("object2");
        try {
          final isBiometricAuthorized = await auth.authenticate(
            localizedReason: 'Autenticación biométrica requerida',
          );

          if (isBiometricAuthorized) {
            //  print("object3");
            // print(imss);
            noEmpleado = empleadoId;
            empleadoIMSS = imss;
          } else {
            // print("object44645");
            noEmpleado = '';
            empleadoIMSS = '';
            await customDialogManager.showCustomDialog(
              icon: Icons.abc,
              message: 'Fallo la autenticación biométrica',
              title: 'Fallo la autenticación biométrica',
              color: Colors.red,
            );
            // print('Fallo la autenticación biométrica');
          }
        } catch (e) {
          //print("object44645");
          noEmpleado = '';
          empleadoIMSS = '';
          await SharedPreferencesHelper.remove('token');
          await SharedPreferencesHelper.remove('imss');
          await SharedPreferencesHelper.remove('empleadoId');
          if (kDebugMode) {
            print('Error de autenticación biométrica: $e');
          }
        }
      } else {
        await SharedPreferencesHelper.remove('token');
        await SharedPreferencesHelper.remove('imss');
        await SharedPreferencesHelper.remove('empleadoId');
        await customDialogManager.showCustomDialog(
          icon: Icons.abc,
          message: 'El biométrico no está disponible en este dispositivo',
          title: 'El biométrico no está disponible en este dispositivo',
          color: Colors.red,
        );
        // print('El biométrico no está disponible en este dispositivo');
        noEmpleado = '';
        empleadoIMSS = '';
      }
    } else {
      await SharedPreferencesHelper.remove('token');
      await SharedPreferencesHelper.remove('imss');
      await SharedPreferencesHelper.remove('empleadoId');
      final employeeNumberController =
          ref.read(employeeNumberControllerProvider);
      final imssController = ref.read(imssControllerProvider);
      noEmpleado = employeeNumberController.text;
      empleadoIMSS = imssController.text;
      cerrar = await SharedPreferencesHelper.getdatos('cerrar');
    }
    // print(empleadoIMSS);
    if (noEmpleado.isNotEmpty && empleadoIMSS.isNotEmpty && cerrar != 'si') {
      final postDatas = {
        'no_empleado': noEmpleado,
        'imss': empleadoIMSS,
      };
      final data = await fetchPostData(
        modo,
        completeUrldev,
        baseUrl,
        endpointLogin,
        postDatas,
      );

      if (data['success'] == true) {
        final stateController = ref.read(labelTextProvider.notifier);
        SharedPreferencesHelper.setdatos('token', data['token']);
        SharedPreferencesHelper.setdatos('empleadoId', noEmpleado);
        SharedPreferencesHelper.setdatos('imss', empleadoIMSS);
        SharedPreferencesHelper.setdatos(
            'empleado', data['empleado']['idEmpleado'].toString());
        SharedPreferencesHelper.setdatos(
            'nombres', data['empleado']['nombres']);
        SharedPreferencesHelper.setdatos(
            'apellidoPaterno', data['empleado']['apellidoPaterno']);
        SharedPreferencesHelper.setdatos(
            'apellidoMaterno', data['empleado']['apellidoMaterno']);
        SharedPreferencesHelper.setdatos('success', data['success'].toString());
        SharedPreferencesHelper.setdatos('nombreCompleto',
            '${data['empleado']['nombres']} ${data['empleado']['apellidoPaterno']} ${data['empleado']['apellidoMaterno']}');
        SharedPreferencesHelper.setdatos(
            'flag_firma', data['flag_firma'].toString());
        SharedPreferencesHelper.setdatos('notificaciones', data['notificaciones'].toString());
        var firma = data['flag_firma'];
        var versionApp = data['version_app'];
        somelugar(firma, versionApp);
        stateController.state = false;
      } else {
        SharedPreferencesHelper.setdatos('token', '');
        SharedPreferencesHelper.setdatos('empleadoId', '');
        SharedPreferencesHelper.setdatos('imss', '');
        if (data['mensaje'] == null) {
          await customDialogManager.showCustomDialog(
              icon: Icons.warning,
              title: data['mensaje'],
              message: data['mensaje'],
              color: Colors.red);
        } else {
          await customDialogManager.showCustomDialog(
              icon: Icons.warning,
              title: 'Login incorrecto',
              message: 'Las accesos proporcionados son incorrectos',
              color: Colors.red);
        }
      }
    } else {
      if (kDebugMode) {
        print("object");
      }
    }
  }

  somealgo() {
    final stateController = ref.read(labelTextProvider.notifier);
    stateController.state = true;
    SharedPreferencesHelper.setdatos('token', '');
    SharedPreferencesHelper.setdatos('empleadoId', '');
    SharedPreferencesHelper.setdatos('imss', '');
    final imssController = ref.read(imssControllerProvider);
    final employeeNumberController = ref.read(employeeNumberControllerProvider);
    employeeNumberController.clear();
    imssController.clear();
    someFunction();
  }

  @override
  Widget build(BuildContext context) {
    final employeeNumberController = ref.read(employeeNumberControllerProvider);
    final imssController = ref.read(imssControllerProvider);
    final labelText = ref.watch(labelTextProvider);

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: displayWidth(context) * 0.05,
                        vertical: displayWidth(context) * 0.1),
                    child: Row(
                      children: [
                        Container(
                          width: displayWidth(context) * 0.25,
                          height: displayWidth(context) * 0.11,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/images/logonach_azul.png",
                                ),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                            width: displayWidth(context) * 0.25,
                            height: displayWidth(context) * 0.11,
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 2, vertical: 4),
                    child: Text(
                      '¡HOLA!',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: displayWidth(context) * 0.15,
                        color: const Color.fromARGB(255, 5, 50, 91),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                    child: Text(
                      '¡QUE GUSTO DE VERTE!',
                      style: TextStyle(
                        fontSize: displayWidth(context) * 0.035,
                        color: const Color.fromARGB(255, 5, 50, 91),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
                    child: Text(
                      'INGRESA A TU PORTAL NACH',
                      style: TextStyle(
                        fontSize: displayWidth(context) * 0.035,
                        color: const Color.fromARGB(255, 5, 50, 91),
                      ),
                    ),
                  ),
                  Center(
                    child: Column(
                      children: [
                        labelText
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  controller: employeeNumberController,
                                  onChanged: (value) {
                                    //   actualizausuarios = value;
                                  },
                                  style: const TextStyle(color: Colors.white),
                                  keyboardType:
                                      const TextInputType.numberWithOptions(),
                                  decoration: const InputDecoration(
                                    filled: true,
                                    fillColor: Color.fromARGB(255, 5, 50, 91),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        width: 2,
                                        color: Color.fromARGB(255, 5, 50, 91),
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          width: 5, //<-- SEE HERE
                                          color: Color.fromARGB(255, 5, 50, 91),
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(5.0))),
                                    labelStyle: TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    labelText: 'Usuario',
                                  ),
                                ),
                              )
                            : const Text(''),
                        labelText
                            ? Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                child: TextFormField(
                                  controller: imssController,
                                  onChanged: (value) {
                                    //  actualizacontrasena = value;
                                  },
                                  obscureText: obsecureText,
                                  style: const TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          obsecureText = !obsecureText;
                                          //print(actualizacontrasena);
                                        });
                                      },
                                      icon: Icon(
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        obsecureText
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        const Color.fromARGB(255, 5, 50, 91),
                                    focusedBorder: const OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                      borderSide: BorderSide(
                                        width: 2, //<-- SEE HERE
                                        color: Color.fromARGB(255, 5, 50, 91),
                                      ),
                                    ),
                                    border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                        width: 0.1, //<-- SEE HERE
                                        color: Color.fromARGB(255, 5, 50, 91),
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(5.0)),
                                    ),
                                    labelText: 'Contraseña',
                                    labelStyle: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 255, 255, 255)),
                                    iconColor: const Color.fromARGB(
                                        255, 255, 255, 255),
                                  ),
                                ),
                              )
                            : Center(
                                child: InkWell(
                                  onTap: () {
                                    SharedPreferencesHelper.borrashared();
                                    SharedPreferencesHelper.setdatos(
                                        'cerrar', '');
                                    // Your action or function to be executed on tap goes here
                                    somealgo();
                                  },
                                  child: const Text(
                                    'Cambiar de usuario',
                                    style: TextStyle(
                                      fontSize: 20,
                                      decoration: TextDecoration.underline,
                                      color: Color.fromARGB(255, 5, 50, 91),
                                    ),
                                  ),
                                ),
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                              top: displayWidth(context) * 0.07),
                          child: labelText
                              ? ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        const Color.fromARGB(255, 5, 50, 91),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          displayWidth(context) * 0.02),
                                    ), // This is what you need!
                                  ),
                                  onPressed: () async {
                                    someFunction();
                                  },
                                  child: SizedBox(
                                    width: displayWidth(context) * 0.4,
                                    child: Center(
                                      child: Text(
                                          labelText
                                              ? 'Iniciar Sesión'
                                              : 'Iniciar Sesión',
                                          style: TextStyle(
                                            fontSize:
                                                displayWidth(context) * 0.055,
                                          )),
                                    ),
                                  ),
                                )
                              : const Text(''),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(top: displayWidth(context) * 0.1),
                    child: SizedBox(
                      width: displayWidth(context) * 0.90,
                      height: displayWidth(context) * 0.7,
                      child: OverflowBox(
                        child: Swiper(
                          itemBuilder: (context, index) {
                            final image = listImages[index];
                            return Image.asset(
                              image,
                              fit: BoxFit.fill,
                            );
                          },
                          indicatorLayout: PageIndicatorLayout.COLOR,
                          autoplay: true,
                          itemCount: listImages.length,
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
    );
  }
  void muestraAlerta() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Actualizar Aplicación"),
          content: const Text("Hay una nueva versión disponible. Por favor, actualiza la aplicación."),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cerrar"),
            ),
            TextButton(
              onPressed: () {
                abrirPlayStore();
                Navigator.of(context).pop();
              },
              child:const Text("Actualizar"),
            ),
          ],
        );
      },
    );
  }
  void abrirPlayStore() async {
    const url = 'https://play.google.com/store/apps/details?id=com.gruponach.nach_empleado';
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'No se pudo abrir la Play Store';
    }
  }

  //   void checkForUpdate() {
  //   // Comparar versiones
  //   if (currentAppVersion != latestAppVersion) {
  //     showUpdateAlert();
  //   } else {
  //     showToast("La aplicación está actualizada");
  //   }
  // }
}
