import 'package:flutter/material.dart';

class InicioSplashScreen extends StatefulWidget {
  const InicioSplashScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _InicioSplashScreen();
  }
}

class _InicioSplashScreen extends State<InicioSplashScreen> {
  int splashtime = 6;
  // duration of splash screen on second

  @override
  void initState() {
    Future.delayed(Duration(seconds: splashtime), () async {
      Navigator.pushNamedAndRemoveUntil(context, 'login', (route) => false);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/Pantallainicioapp.gif",
                  ),
                  fit: BoxFit.cover),
            ),
            alignment: Alignment.center,
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              //vertically align center
            )));
  }
}
