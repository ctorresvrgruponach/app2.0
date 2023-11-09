import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../api/firmaapi.dart';
import '../../helpers/guardarvars.dart';
import '../../helpers/somelugar.dart';
import '../../ui/alerts.dart';

class ReviewSignaturePage extends StatelessWidget {
  final Uint8List? signature;

  const ReviewSignaturePage({Key? key, this.signature}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: true,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Text(''),

              label: '',
              // label: 'Home',
              backgroundColor: Color.fromARGB(255, 209, 207, 207),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.save),

              activeIcon:
                  Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.save),
              label: 'Guardar',

              //label: 'Business',

              backgroundColor: Color.fromARGB(255, 209, 207, 207),
            ),
          ],
          currentIndex: 1,
          fixedColor: const Color.fromARGB(255, 5, 50, 91),
          onTap: (int index) {
            switch (index) {
              case 1:
                saveSignature(context)?.then((value) =>
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false));

                break;
            }
          },
        ),
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 5, 50, 91),
          centerTitle: true,
          title: const Text('Guardar Firma'),
        ),
        body: Center(
          child: Image.memory(signature!),
        ));
  }

  Future? saveSignature(BuildContext context) async {
    // final status = await Permission.storage.status;
    String base64String = base64.encode(signature!);
    final customDialogManager = CustomDialogManager(context);
    List<dynamic> argumentos = ['home'];
    final navegador = NavegadorDeRuta(context, argumentos);

    //Clipboard.setData(ClipboardData(text: base64String));
    SharedPreferencesHelper.setdatos("imagen_emplaedo", base64String);
    final instanciaEnviaFirma = EnviaFirmaClass();
    final resultado = await instanciaEnviaFirma.enviaFirma(base64String);
    // print(resultado['success']);
    if (resultado['success']) {
      await customDialogManager.showCustomDialog(
        icon: Icons.airlines_rounded,
        message: resultado['mensaje'],
        title: resultado['mensaje'],
        color: const Color.fromARGB(255, 98, 54, 244),
      );
      final firma = await SharedPreferencesHelper.getdatos('flag_firma');
      if (int.parse(firma) == 0) {
        await navegador.algunlugar('actualizaempleado');
      } else {
        await navegador.algunlugar('home');
      }
    } else {
      await customDialogManager.showCustomDialog(
        icon: Icons.airlines_rounded,
        message: resultado['mensaje'],
        title: resultado['mensaje'],
        color: const Color.fromARGB(255, 244, 54, 54),
      );
    }
  }
}
