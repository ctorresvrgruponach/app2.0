import 'dart:io';
// Importa la biblioteca de permisos
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
      // Asegúrate de esperar la llamada a detectEdge.
      await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: true,
        androidScanTitle:
            'Frente', // Utiliza localizaciones personalizadas para Android
        androidCropTitle: 'Recortar',
        androidCropBlackWhiteTitle: 'Blanco y negro',
        androidCropReset: 'Restablecer',
      );
    } catch (e) {
      //print(e);
    }

    // Ajusta la calidad de la imagen antes de convertirla en base64
    final compressedImage = await FlutterImageCompress.compressAndGetFile(
      imagePath,
      imagePath, // Sobrescribe el archivo original
      quality: 70, // Ajusta la calidad (0 a 100)
    );
    if (kDebugMode) {
      print('imagePath2: $compressedImage');
    }
    if (compressedImage != null) {
      var bytes = await compressedImage.readAsBytes();
      img64 = base64Encode(bytes);
      if (kDebugMode) {
        print('imagePath3: $img64');
      }
    } else {
      // Error al comprimir la imagen
      if (kDebugMode) {
        print('Error al comprimir la imagen.');
      }
    }
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
