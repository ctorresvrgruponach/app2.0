import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart' as xml;

class XmlDownloadPage extends StatefulWidget {
  const XmlDownloadPage({Key? key}) : super(key: key);

  @override
  XmlDownloadPageState createState() => XmlDownloadPageState();
}

class XmlDownloadPageState extends State<XmlDownloadPage> {
  String xmlContent = '';
  final String xmlUrl =
      'http://nachservice.com.mx/file/facturas/facturas_internas/CAM1903206V9_A3920_03-10-2023-19_18_25.xml';

  late String xmlFileName;

  @override
  void initState() {
    super.initState();
    fetchXmlContent();
    xmlFileName = xmlUrl.substring(xmlUrl.lastIndexOf('/') + 1);
  }

  Future<void> fetchXmlContent() async {
    final response = await http.get(Uri.parse(xmlUrl));

    if (response.statusCode == 200) {
      final parsedXml = xml.XmlDocument.parse(response.body);
      setState(() {
        xmlContent = parsedXml.toXmlString(pretty: true);
      });
    }
  }

  Future<void> downloadAndSaveXmlFile() async {
    try {
      final response = await http.get(Uri.parse(xmlUrl));

      if (response.statusCode == 200) {
        final appDocDir = await getApplicationDocumentsDirectory();
        final xmlFilePath = '${appDocDir.path}/$xmlFileName';

        final xmlFile = File(xmlFilePath);
        await xmlFile.writeAsBytes(response.bodyBytes);

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('XML file downloaded and saved to $xmlFilePath'),
        ));
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Failed to download XML file. Status code: ${response.statusCode}'),
        ));
      }
    } catch (e) {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(xmlContent),
        ),
      ),
    );
  }
}
