import 'package:com.gruponach.nach_empleado/views/firma/signaturepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:signature/signature.dart';

import '../../ui/barra_abajo.dart';

class Firma extends StatefulWidget {
  const Firma({Key? key}) : super(key: key);

  @override
  State<Firma> createState() => _FirmaState();
}

class _FirmaState extends State<Firma> {
  SignatureController? controller;

  @override
  void initState() {
    // we initialize the signature controller
    controller = SignatureController(penStrokeWidth: 5, penColor: Colors.white);
    super.initState();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.teal,
      body: Column(
        children: [
          Expanded(
            child: Signature(
              controller: controller!,
              backgroundColor: const Color.fromARGB(255, 53, 86, 117),
            ),
          ),
          buttonWidgets(context)!,
        ],
      ),
      bottomNavigationBar: bottomNachBar(context, 3),
    );
  }

  Widget? buildSwapOrientation(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        final newOrientation =
            isPortrait ? Orientation.landscape : Orientation.portrait;

        controller!.clear();

        setOrientation(newOrientation);
      },
      child: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isPortrait
                  ? Icons.screen_lock_portrait
                  : Icons.screen_lock_landscape,
              size: 40,
            ),
            const SizedBox(
              width: 12,
            ),
            const Text(
              'Toque para cambiar la orientación de la firma',
              style: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  void setOrientation(Orientation orientation) {
    if (orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }
  }

  Widget? buttonWidgets(BuildContext context) => Container(
        color: const Color.fromARGB(255, 5, 50, 91),
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          const Text(
            'Firma sobre el área Azul',
            style: TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
            ),
          ),
          IconButton(
              onPressed: () async {
                if (controller!.isNotEmpty) {
                  final signature = await exportSignature();

                  await Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: ((context) =>
                          ReviewSignaturePage(signature: signature!)),
                    ),
                  );

                  controller!.clear();
                }
              },
              iconSize: 40,
              color: Colors.white,
              icon: const Icon(Icons.verified_rounded)),
          IconButton(
              onPressed: () {
                controller!.clear();
              },
              iconSize: 40,
              color: Colors.red,
              icon: const Icon(Icons.close)),
        ]),
      );

  Future<Uint8List?> exportSignature() async {
    final exportController = SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: const Color.fromARGB(0, 255, 255, 255),
      penColor: Colors.black,
      points: controller!.points,
    );

    final signature = exportController.toPngBytes();

    //clean up the memory
    exportController.dispose();

    return signature;
  }
}
