import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../helpers/guardarvars.dart';

class ReviewSignaturePage extends StatelessWidget {
  final Uint8List signature;

  const ReviewSignaturePage({Key? key, required this.signature})
      : super(key: key);

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
          child: Image.memory(signature),
        ));
  }

  Future? saveSignature(BuildContext context) async {
    // final status = await Permission.storage.status;
    String base64String = base64.encode(signature);
    // final result =
    //     await ImageGallerySaver.saveImage(signature, name: 'datos.png');

    ////print(base64String);
    //Clipboard.setData(ClipboardData(text: base64String));
    SharedPreferencesHelper.setdatos("imagen_emplaedo", base64String);
  }
}
