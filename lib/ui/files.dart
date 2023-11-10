import 'dart:io';

// Importa la biblioteca de permisos
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

import '../../libs/lib.dart';

final imageProvider = StateNotifierProvider<ImageNotifier, File?>((ref) {
  return ImageNotifier();
});

class ImageNotifier extends StateNotifier<File?> {
  ImageNotifier() : super(null);

  final picker = ImagePicker();

  Future<void> pickImage(ImageSource source) async {
    // Verifica y solicita los permisos de cámara y galería
    var cameraStatus = await Permission.camera.status;
    var photosStatus = await Permission.photos.status;

    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }

    if (!photosStatus.isGranted) {
      await Permission.photos.request();
    }

    // Verifica si los permisos se otorgaron

    final ImagePicker picker = ImagePicker();

    final now = DateTime.now();
    String formatter = DateFormat('d/MM/y').format(now);

    String img64 = '';

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
    if (kDebugMode) {
      print('imagePath1: $imagePath');
    }

    try {
      //Make sure to await the call to detectEdge.
      await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle: 'Frente', // use custom localizations for android
        androidCropTitle: 'Recortar',
        androidCropBlackWhiteTitle: 'Blanco y negro',
        androidCropReset: 'Reestablecer',
      );
    } catch (e) {
      //print(e);
    }

    // var bytes = File(imagePath).readAsBytesSync();
    // final compressedBytes = FlutterImageCompress.compressWithList(
    //   bytes,
    //   quality: 70, // Ajusta la calidad (0 a 100)
    // );
    // img64 = base64Encode(compressedBytes);
    Future<Uint8List> compressImage() async {
      final bytes = File(imagePath).readAsBytesSync();
      final compressedBytes = await FlutterImageCompress.compressWithList(
        bytes,
        quality: 25, // Ajusta la calidad (0 a 100)
      );

      if (compressedBytes != null) {
        return compressedBytes;
      } else {
        throw Exception('Error al comprimir la imagen');
      }
    }

    final compressedImage = await compressImage();
    final base64String = base64Encode(compressedImage);
    print("object");
    print(base64String);
    Clipboard.setData(ClipboardData(text: base64String));
  }
}

class ImagePickerApp extends ConsumerWidget {
  const ImagePickerApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final image = ref.watch(imageProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (image != null)
              Image.file(
                image,
                width: 200,
                height: 200,
              ),
            ElevatedButton(
              onPressed: () {
                ref.read(imageProvider.notifier).pickImage(ImageSource.gallery);
              },
              child: const Text('Select Image from Gallery'),
            ),
            ElevatedButton(
              onPressed: () {
                ref.read(imageProvider.notifier).pickImage(ImageSource.camera);
              },
              child: const Text('Take a Photo'),
            ),
          ],
        ),
      ),
    );
  }
}