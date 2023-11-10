import 'package:com.gruponach.nach_empleado/views/home/homescreen.dart';
import 'package:com.gruponach.nach_empleado/views/misadelantos/mis_adelantos.dart';
import 'package:flutter/material.dart';

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
            child: const Text(
              'Ok',
              style: TextStyle(
                color: Colors.white,
                // backgroundColor: Colors.amber,
                fontSize: 14,
              ),
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>( const Color.fromARGB(255, 5, 50, 91)), // Color de fondo
            ),
          ),
        ),
      ],
    );
  }
}


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
              Navigator.push(context,MaterialPageRoute(builder: (context) => HomeScreen()),);
            },
            child: const Text(
              'Aceptar',
              style: TextStyle(
                color: Colors.white,
                // backgroundColor: Colors.amber,
                fontSize: 14,
              ),
            ),
            style: ButtonStyle(
             backgroundColor: MaterialStateProperty.all<Color>( const Color.fromARGB(255, 0, 4, 125)), // Color de fondo
           ),
          ),
        ),
      ],
    );
  }
}


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
              Navigator.push(context,MaterialPageRoute(builder: (context) => MisAdelantos()),);
            },
            child: const Text(
              'Mas información',
              style: TextStyle(
                color: Colors.white,
                // backgroundColor: Colors.amber,
                fontSize: 14,
              ),
            ),
            style: ButtonStyle(
             backgroundColor: MaterialStateProperty.all<Color>( const Color.fromARGB(255, 5, 50, 91)), // Color de fondo
           ),
          ),
        ),
      ],
    );
  }
}
