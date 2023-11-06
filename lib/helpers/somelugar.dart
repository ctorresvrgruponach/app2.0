import '../libs/lib.dart';
import 'package:flutter/material.dart';

class NavegadorDeRuta {
  final BuildContext context;

  NavegadorDeRuta(this.context);

  Future<void> algunlugar(lugar) async {
    Navigator.pushNamedAndRemoveUntil(context, lugar, (route) => false);
  }
}
