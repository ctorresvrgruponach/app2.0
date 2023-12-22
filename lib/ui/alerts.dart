import 'package:com.gruponach.nach_empleado/views/home/homescreen.dart';
import 'package:flutter/material.dart';

import '../views/misservicios/servicios_activos.dart';

class CustomDialogManager {
  final BuildContext context;

  CustomDialogManager(this.context);

  Future<void> showCustomDialog({
    required IconData icon,
    required String title,
    required String message,
    required Color color,
  }) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return CustomAlertDialog(
          icon: icon,
          title: title,
          message: message,
          color: color,
        );
      },
    );
  }
}

class CustomAlertDialog extends StatelessWidget {
  final String message;
  final String title;
  final IconData icon;
  final Color color;

  const CustomAlertDialog({
    super.key,
    required this.message,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(129, 0, 0, 0),
      icon: Icon(
        icon,
        size: 150,
        color: color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      // backgroundColor: Colors.amber,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      actions: <Widget>[
        // DecoratedBox(decoration: BoxDecoration(
        //   border: Border.all(
        //     color: Colors.amber,
        //     width: 30,
        //   ),
        // )),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                12.0), // Ajusta el radio de borde según tus necesidades
            // border: Border.all(
            //    color: const Color.fromARGB(255, 0, 4, 125), // Color del borde
            //   width: 4.0, // Ancho del borde
            // ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 5, 50, 91)), // Color de fondo
            ),
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Colors.white,
                // backgroundColor: Colors.amber,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class alersuccess extends StatelessWidget {
  final String message;
  final String title;
  final IconData icon;
  final Color color;

  const alersuccess({
    super.key,
    required this.message,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(129, 0, 0, 0),
      icon: Icon(
        icon,
        size: 150,
        color: color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      // backgroundColor: Colors.amber,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      actions: <Widget>[
        // DecoratedBox(decoration: BoxDecoration(
        //   border: Border.all(
        //     color: Colors.amber,
        //     width: 30,
        //   ),
        // )),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                12.0), // Ajusta el radio de borde según tus necesidades
            // border: Border.all(
            //    color: const Color.fromARGB(255, 0, 4, 125), // Color del borde
            //   width: 4.0, // Ancho del borde
            // ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomeScreen()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 5, 50, 91)), // Color de fondo
            ),
            child: const Text(
              'Aceptar',
              style: TextStyle(
                color: Colors.white,
                // backgroundColor: Colors.amber,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class alerterror extends StatelessWidget {
  final String message;
  final String title;
  final IconData icon;
  final Color color;

  const alerterror({
    super.key,
    required this.message,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(129, 0, 0, 0),
      icon: Icon(
        icon,
        size: 150,
        color: color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      // backgroundColor: Colors.amber,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      actions: <Widget>[
        // DecoratedBox(decoration: BoxDecoration(
        //   border: Border.all(
        //     color: Colors.amber,
        //     width: 30,
        //   ),
        // )),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                12.0), // Ajusta el radio de borde según tus necesidades
            // border: Border.all(
            //    color: const Color.fromARGB(255, 0, 4, 125), // Color del borde
            //   width: 4.0, // Ancho del borde
            // ),
          ),
          child: TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MisSolicitudes()),
              );
            },
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                  const Color.fromARGB(255, 5, 50, 91)), // Color de fondo
            ),
            child: const Text(
              'Mas información',
              style: TextStyle(
                color: Colors.white,
                // backgroundColor: Colors.amber,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ignore: camel_case_types
class Salirdeapp extends StatelessWidget {
  final String message;
  final String title;
  final IconData icon;
  final Color color;

  const Salirdeapp({
    super.key,
    required this.message,
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(129, 0, 0, 0),
      icon: Icon(
        icon,
        size: 150,
        color: color,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      // backgroundColor: Colors.amber,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            message,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
      actions: <Widget>[
        // DecoratedBox(decoration: BoxDecoration(
        //   border: Border.all(
        //     color: Colors.amber,
        //     width: 30,
        //   ),
        // )),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                12.0), // Ajusta el radio de borde según tus necesidades
            // border: Border.all(
            //    color: const Color.fromARGB(255, 0, 4, 125), // Color del borde
            //   width: 4.0, // Ancho del borde
            // ),
          ),
          child: Row(
            children: [
              TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/');
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 5, 50, 91)), // Color de fondo
                ),
                child: const Text(
                  'SI',
                  style: TextStyle(
                    color: Colors.white,
                    // backgroundColor: Colors.amber,
                    fontSize: 14,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 5, 50, 91)), // Color de fondo
                ),
                child: const Text(
                  'NO',
                  style: TextStyle(
                    color: Colors.white,
                    // backgroundColor: Colors.amber,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
