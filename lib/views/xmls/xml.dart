import 'dart:io';

import 'package:http/http.dart' as http;

import '../../libs/lib.dart';

class XmlDownloadPage extends StatefulWidget {
  const XmlDownloadPage({super.key});

  @override
  XmlDownloadPageState createState() => XmlDownloadPageState();
}

class XmlDownloadPageState extends State<XmlDownloadPage> {
  final String xmlUrl =
      'http://nachservice.com.mx/file/facturas/facturas_internas/CAM1903206V9_A3920_03-10-2023-19_18_25.xml'; // Replace with your XML file URL

  Future<void> downloadAndSaveXmlFile() async {
    try {
      // Send an HTTP GET request to download the XML file
      final response = await http.get(Uri.parse(xmlUrl));

      if (response.statusCode == 200) {
        // Get the app's documents directory
        final appDocDir = await getApplicationDocumentsDirectory();

        // Define the file path where the XML file will be saved
        final xmlFilePath = '${appDocDir.path}/your-xml-file.xml';

        // Create a File instance and write the XML content to it
        final xmlFile = File(xmlFilePath);
        await xmlFile.writeAsBytes(response.bodyBytes);

        // Display a success message
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('XML file downloaded and saved to $xmlFilePath'),
        ));
      } else {
        // Handle the case where the HTTP request was not successful
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Failed to download XML file. Status code: ${response.statusCode}'),
        ));
      }
    } catch (e) {
      // Handle any exceptions that may occur during the process
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
        title: const Text(
          'XML Download Example',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: downloadAndSaveXmlFile,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: downloadAndSaveXmlFile,
              child: const Text('Download and Save XML'),
            ),
          ],
        ),
      ),
    );
  }
}
