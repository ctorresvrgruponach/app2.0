import 'package:flutter/material.dart';

import '../libs/lib.dart';

class NavegadorDeRuta {
  final BuildContext context;

  NavegadorDeRuta(this.context);

  Future<void> algunlugar(lugar) async {
    Navigator.pushNamedAndRemoveUntil(context, lugar, (route) => false);
  }
}

// class NavegadorDeRuta {
//   final BuildContext context;
//   final List<dynamic> argumentos;

//   NavegadorDeRuta(this.context, this.argumentos);

//   Future<void> algunlugar(lugar) async {
//     Navigator.pushNamedAndRemoveUntil(context, lugar, (route) => false,
//         arguments: argumentos);
//   }
// }