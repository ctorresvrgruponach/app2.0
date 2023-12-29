import 'dart:io';

import '../../libs/lib.dart';

class VerDocumentosAdelantos extends ConsumerStatefulWidget {
  const VerDocumentosAdelantos(
      {Key? key, required this.data, required this.idoperacion})
      : super(key: key);

  final int idoperacion;
  final dynamic data;

  @override
  VerDocumentosAdelantosState createState() => VerDocumentosAdelantosState();
}

class VerDocumentosAdelantosState
    extends ConsumerState<VerDocumentosAdelantos> {
  @override
  Widget build(BuildContext context) {
    int idPrestamo = widget.data;
    int idoperacion = widget.idoperacion;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<String>(
              future: _getPdfAsBytes(idPrestamo, idoperacion),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  String datos = snapshot.data!;
                  return SingleChildScrollView(
                    child: Center(
                      child: datos != ''
                          ? Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height *
                                          0.1),
                                  child: SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.9,
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    child: PDFView(
                                      filePath: datos,
                                    ),
                                  ),
                                ),
                                ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 5, 50, 91)),
                                    ),
                                    child: const Text('Aceptar')),
                              ],
                            )
                          : SizedBox(
                              // width: MediaQuery.of(context).size.width * 0.9 ,
                              height: MediaQuery.of(context).size.height * 0.6,
                              child: const Center(
                                  child: Text('Error, inténtalo más tarde.',
                                      style: TextStyle(fontSize: 25))),
                            ),
                    ),
                  );
                  // return datos;
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error, inténtalo más tarde.'));
                } else {
                  return const Center(child: Cargando());
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _getPdfAsBytes(idPrestamo, idoperacion) async {
    final prestamoId = idPrestamo;
    final operacionprestamo = idoperacion;
    final token = await SharedPreferencesHelper.getdatos('token');
    final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
    final monto = await SharedPreferencesHelper.getdatos('montoapedir');
    final idOperacionid =
        await SharedPreferencesHelper.getdatos('idoperacionid');

    Map<String, dynamic> data = {};

    if (prestamoId == 0) {
      final postDatas = {
        "token": token,
        "idEmpleado": idEmpleado,
        "idOperacion": idOperacionid == '' ? operacionprestamo : idOperacionid,
        "montoPrestamo": monto,
      };
      data = postDatas;
    }

    final dynamic documentos = await fetchPostData(
      modo,
      completeUrldev,
      baseUrl,
      muestraDocumentosAdelantos,
      data,
    );
    if (documentos is Map<String, dynamic> && documentos["success"] != null) {
      if (documentos["success"]) {
        // Handle success if needed
      } else {
        // Handle failure if needed
      }
    } else {
      if (kDebugMode) {
        print(
            'Error: documentos is not a valid map or "success" is not present.');
      }
      // Handle the case where documentos is not a valid map or when "success" is not present.
    }

    if (documentos['pdf'] == null) {
      const datos = '';
      return datos;
    } else {
      final List<int> doc = base64.decode(documentos['pdf']);
      final Directory dir = await getApplicationDocumentsDirectory();
      final File pdfFile = File('${dir.path}/Archivos.pdf');
      await pdfFile.writeAsBytes(doc, flush: true);

      return '${dir.path}/Archivos.pdf';
    }
  }
}
