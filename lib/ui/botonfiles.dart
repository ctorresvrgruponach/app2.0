import 'dart:io';
// Importa la biblioteca de permisos
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../libs/lib.dart';
import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';

import '../config/htmls.dart';

bool hayDatos = true;
bool filterColor = true;
final imageProvider = StateNotifierProvider<ImageNotifier, File?>((ref) {
  return ImageNotifier();
});

class ImageNotifier extends StateNotifier<File?> {
  ImageNotifier() : super(null);

  final picker = ImagePicker();
  final imagePicker = ImagePicker();

  Future<void> pickImage(
      String tipo, String texto, BuildContext context) async {
    final imagenpdf = Imagenpdf(context);
    // Verifica y solicita los permisos de cámara y galería
    if (tipo == 'camara') {
      var cameraStatus = await Permission.camera.status;

      if (!cameraStatus.isGranted) {
        await Permission.camera.request();
      }

      // Verifica si los permisos se otorgaron

      bool isCameraGranted = await Permission.camera.request().isGranted;
      if (!isCameraGranted) {
        isCameraGranted =
            await Permission.camera.request() == PermissionStatus.granted;
      }

      if (!isCameraGranted) {
        // No se tienen permisos para la cámara
      }
      final dir = await path_provider.getTemporaryDirectory();

      var targetFileName = "archivo";

      var imagePath = "${dir.path}/$targetFileName.jpeg";

      try {
        // Asegúrate de esperar la llamada a detectEdge.
        await EdgeDetection.detectEdge(
          imagePath,
          canUseGallery: true,
          androidScanTitle: 'Frente',
          androidCropTitle: 'Recortar',
          androidCropBlackWhiteTitle: 'Blanco y negro',
          androidCropReset: 'Reestablecer',
        );
      } catch (e) {
        // Maneja cualquier error
        // print(e);
      }

      Future<Uint8List> compressImage() async {
        final bytes = File(imagePath).readAsBytesSync();
        final compressedBytes = await FlutterImageCompress.compressWithList(
          bytes,
          quality: 25,
        );

        return compressedBytes;
      }

      final compressedImage = await compressImage();
      final base64String = base64Encode(compressedImage);

      await imagenpdf.devolverimagen(base64String, dir, texto);
    } else {
      final XFile? photo1 = await picker.pickImage(source: ImageSource.gallery);

      if (photo1 != null) {
        final isImage = _isImageFile(photo1.path);

        if (isImage) {
          final dir = await path_provider.getTemporaryDirectory();
          var bytes = File(photo1.path).readAsBytesSync();

          await imagenpdf.devolverimagen(base64Encode(bytes), dir, texto);
        } else {
          // Handle the case when a non-image file is selected.
          // print('El archivo seleccionado no es una imagen.');
        }
      }
    }
  }
}

bool _isImageFile(String filePath) {
  final imageExtensions = [
    'jpg',
    'jpeg',
    'png',
    'gif',
    'bmp'
  ]; // Agrega las extensiones de imagen que desees permitir.
  final extension = filePath.split('.').last.toLowerCase();
  return imageExtensions.contains(extension);
}

final botonobscuro = StateProvider<bool>((ref) {
  return true;
});

class Botonfile extends ConsumerStatefulWidget {
  final String texto;

  const Botonfile({
    Key? key,
    required this.texto,
  }) : super(key: key);

  @override
  BotonfileState createState() => BotonfileState();
}

class BotonfileState extends ConsumerState<Botonfile> {
  @override
  void initState() {
    super.initState();
    setState(() {
      setState(() {
        filterColor = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(filterColor ? 255 : 50, 5, 50, 91),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
        ),
      ),
      onPressed: () async {
        final customDialogManager = CustomDialogManagerBoton(context);

        await customDialogManager.showCustomDialog(
            color: Colors.black,
            icon: Icons.abc,
            message: 'Da clic para subir ${widget.texto}',
            title: 'Documento ${widget.texto}',
            texto: widget.texto);
      },
      child: Text(' ${widget.texto}'),
    );
  }
}

class Imagenpdf {
  final BuildContext context;

  Imagenpdf(this.context);
  Future<String> devolverimagen(
      String base64String, Directory dir, String texto) async {
    final now = DateTime.now();
    String formatter = DateFormat('d/MM/y').format(now);
    String htmlcotejado = texto == 'CURP' ? '' : formatText(formatter);
    var htmlcode2 = texto == 'INE'
        ? """<img src="data:image/png;base64,$base64String" alt=""  width="500" height="600"/><br/>"""
        : '';

    var htmlcode =
        """<img src="data:image/png;base64,$base64String" alt=""  width="500" height="600"/>$htmlcode2 $htmlcotejado""";

    var targetFileNames3 = "archivo_pdf_$texto";
    await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlcode, dir.path, targetFileNames3);
    final bytes = File('${dir.path}/$targetFileNames3.pdf').readAsBytesSync();
    String pdfbase642 = base64Encode(bytes);
    Clipboard.setData(ClipboardData(text: pdfbase642));
    SharedPreferencesHelper.setdatos(texto, pdfbase642);
    // ignore: use_build_context_synchronously
    Navigator.pop(context);

    if (kDebugMode) {
      print(pdfbase642);
    }
    return pdfbase642;
  }
}

class CustomDialogManagerBoton {
  final BuildContext context;

  CustomDialogManagerBoton(this.context);

  Future<void> showCustomDialog({
    required IconData icon,
    required String title,
    required String message,
    required Color color,
    required String texto,
  }) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomAlertDialogBoton(
          icon: icon,
          title: title,
          message: message,
          color: color,
          texto: texto,
        );
      },
    );
  }
}

class CustomAlertDialogBoton extends ConsumerStatefulWidget {
  final String message;
  final String title;
  final IconData icon;
  final Color color;
  final String texto;

  const CustomAlertDialogBoton({
    Key? key,
    required this.message,
    required this.title,
    required this.icon,
    required this.color,
    required this.texto,
  }) : super(key: key);

  @override
  CustomAlertDialogBotonState createState() => CustomAlertDialogBotonState();
}

class CustomAlertDialogBotonState
    extends ConsumerState<CustomAlertDialogBoton> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(129, 0, 0, 0),
      icon: Icon(
        widget.icon,
        size: 150,
        color: widget.color,
      ),
      title: Text(
        widget.title,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      // backgroundColor: Colors.amber,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            widget.message,
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
            border: Border.all(
              color: const Color.fromARGB(255, 0, 4, 125), // Color del borde
              width: 4.0, // Ancho del borde
            ),
          ),
          child: TextButton(
            onPressed: () {
              ref
                  .read(imageProvider.notifier)
                  .pickImage('camara', widget.texto, context);
              setState(() {
                filterColor = false;
              });
            },
            child: const Text(
              'Camara',
              style: TextStyle(
                color: Colors.white,
                // backgroundColor: Colors.amber,
                fontSize: 14,
              ),
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(
                12.0), // Ajusta el radio de borde según tus necesidades
            border: Border.all(
              color: const Color.fromARGB(255, 0, 4, 125), // Color del borde
              width: 4.0, // Ancho del borde
            ),
          ),
          child: TextButton(
            onPressed: () {
              ref
                  .read(imageProvider.notifier)
                  .pickImage('', widget.texto, context);
              setState(() {
                filterColor = false;
              });
            },
            child: const Text(
              'Galeria',
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

class Botonc extends ConsumerStatefulWidget {
  final String texto;
  final void Function()? onPressed;

  const Botonc({
    Key? key,
    required this.texto,
    required this.onPressed,
  }) : super(key: key);

  @override
  BotoncState createState() => BotoncState();
}

class BotoncState extends ConsumerState<Botonc> {
  @override
  void initState() {
    super.initState();
    setState(() {
      setState(() {
        filterColor = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color.fromARGB(filterColor ? 255 : 50, 5, 50, 91),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(displayWidth(context) * 0.02),
        ),
      ),
      onPressed: () {
        // Llamar al método onPressed cuando se presiona el botón
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
        // Cambiar el estado para actualizar el color
        setState(() {
          filterColor = true;
        });
      },
      child: Text(' ${widget.texto}'),
    );
  }
}
