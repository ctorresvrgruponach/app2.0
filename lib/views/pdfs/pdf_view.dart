import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../../libs/lib.dart';

final pdfUrlProvider = FutureProvider<String>((ref) async {
  final savedPdfUrl = await SharedPreferencesHelper.getdatos('urlPdfVisor');
  return savedPdfUrl;
});

class PdfViewerPage extends ConsumerStatefulWidget {
  const PdfViewerPage({super.key});
  @override
  PdfViewerPageState createState() => PdfViewerPageState();
}

class PdfViewerPageState extends ConsumerState<PdfViewerPage> {
  @override
  @override
  Widget build(BuildContext context) {
    final pdfUrlAsyncValue = ref.watch(pdfUrlProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
        title: const Text(
          "Flutter PDF Viewer",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: pdfUrlAsyncValue.when(
        data: (pdfUrl) {
          return FutureBuilder<File?>(
            future: loadNetwork(pdfUrl),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                final file = snapshot.data;
                if (file != null) {
                  return PDFView(
                    filePath: file.path,
                  );
                } else {
                  return const Text("Error loading PDF");
                }
              } else {
                return const Center(child: Cargando());
              }
            },
          );
        },
        loading: () {
          return const Center(child: CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return Text("Error: $error");
        },
      ),
    );
  }

  Future<File?> loadNetwork(String pdfUrl) async {
    try {
      final savedPdfUrl = await SharedPreferencesHelper.getdatos('urlPdfVisor');
      final response = await http.get(Uri.parse(savedPdfUrl));
      final bytes = response.bodyBytes;
      final filename = basename(pdfUrl);
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$filename');
      await file.writeAsBytes(bytes, flush: true);
      return file;
    } catch (e) {
      return null;
    }
  }
}
