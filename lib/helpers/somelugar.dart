import '../libs/lib.dart';
import 'package:flutter/material.dart';

class NavegadorDeRuta {
  final BuildContext context;
  final List<dynamic> argumentos;

  NavegadorDeRuta(this.context, this.argumentos);

  Future<void> algunlugar(lugar) async {
    Navigator.pushNamedAndRemoveUntil(context, lugar, (route) => false,
        arguments: argumentos);
  }
}
