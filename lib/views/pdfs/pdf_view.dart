import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;

import '../../libs/lib.dart';

class PdfViewerPage extends StatefulWidget {
  const PdfViewerPage({Key? key}) : super(key: key);

  @override
  PdfViewerPageState createState() => PdfViewerPageState();
}

class PdfViewerPageState extends State<PdfViewerPage> {
  String? pdfUrl;
  File? pdfFile; // Usar late para indicar que será inicializada antes de su uso

  @override
  void initState() {
    super.initState();
    loadPdfFile();
  }

  Future<void> loadPdfFile() async {
    final savedPdfUrl = await SharedPreferencesHelper.getdatos('urlPdfVisor');
    if (kDebugMode) {
      print(savedPdfUrl);
    }

    setState(() {
      pdfUrl = savedPdfUrl;
    });

    try {
      final response = await http.get(Uri.parse(savedPdfUrl));
      final bytes = response.bodyBytes;
      final filename = p.basename(savedPdfUrl);
      final dir = await getApplicationDocumentsDirectory();
      pdfFile = File('${dir.path}/$filename');
      await pdfFile?.writeAsBytes(bytes, flush: true);
      setState(() {});
    } catch (e) {
      // Manejar errores
    }
  }

  Future<Uint8List?> readPdfBytes(String filename) async {
    try {
      final dir =
          await getApplicationDocumentsDirectory(); // Cambiar según tus necesidades
      final file = File('${dir.path}/$filename');
      final bytes = await file.readAsBytes();
      return Uint8List.fromList(bytes);
    } catch (error) {
      if (kDebugMode) {
        print('Error al leer el archivo PDF: $error');
      }
      return null;
    }
  }

  Future<void> savePdfToFile(BuildContext context) async {
    if (pdfFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('El PDF no se ha cargado correctamente.'),
          duration: Duration(seconds: 3),
        ),
      );
      return;
    }

    final filename = p.basename(pdfUrl!);
    if (kDebugMode) {
      print(filename);
    }

    Uint8List? bytes = await readPdfBytes(filename);
    List<String> parts = filename.split('.');

    await FileSaver.instance.saveAs(
        name: parts.first, ext: 'pdf', mimeType: MimeType.other, bytes: bytes);

    // ignore: use_build_context_synchronously
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('PDF guardado en $filename'),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 2, 9, 72),
        title: const Text(
          "Vista Previa",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              savePdfToFile(context);
            },
          ),
        ],
      ),
      body: pdfFile != null
          ? PDFView(
              filePath: pdfFile?.path,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
