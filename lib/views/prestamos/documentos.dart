import 'dart:io';

import 'package:com.gruponach.nach_empleado/libs/lib.dart';

class VerDocumentos extends ConsumerStatefulWidget {
  const VerDocumentos({Key? key, required this.data, required this.idoperacion})
      : super(key: key);

  final int idoperacion;
  final dynamic data;

  @override
  VerDocumentosState createState() => VerDocumentosState();
}

class VerDocumentosState extends ConsumerState<VerDocumentos> {
  @override
  Widget build(BuildContext context) {
    int idPrestamo = widget.data;
    int idoperacion = widget.idoperacion;
    // File? pdfFile;

    // final getDocumentos = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
    //   final token = await SharedPreferencesHelper.getdatos('token');
    //   final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
    //   final plazos = await SharedPreferencesHelper.getdatos('plazos');
    //   final monto = await SharedPreferencesHelper.getdatos('monto');
    //   final idOperacionid = await SharedPreferencesHelper.getdatos('idoperacionid');

    //   final postDatas = {
    //     "token": token,
    //     "idEmpleado": idEmpleado,
    //     "idOperacion": idoperacion == 0 ? idOperacionid : idoperacion,
    //     "montoPrestamo": monto,
    //     "plazos": plazos,
    //   };

    //   final dynamic documentos = await fetchPostData(
    //     modo,
    //     completeUrldev,
    //     baseUrl,
    //     muestraDocumentos,
    //     postDatas,
    //   );

    //   if (documentos is Map<String, dynamic> && documentos["success"] != null) {
    //     if (documentos["success"]) {
    //       // Handle success if needed
    //     } else {
    //       // Handle failure if needed
    //     }
    //   } else {
    //     if (kDebugMode) {
    //       print(
    //           'Error: documentos is not a valid map or "success" is not present.');
    //     }
    //     // Handle the case where documentos is not a valid map or when "success" is not present.
    //   }

    //   return documentos;
    // });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<String>(
              future: _getPdfAsBytes(idPrestamo,idoperacion),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  String datos = snapshot.data!;
                    return SingleChildScrollView(
                      child: Center(
                        child: datos != '' ?Column(
                          children: [
                            Padding(
                              padding:  EdgeInsets.only(top:  MediaQuery.of(context).size.height * 0.1),
                              child: SizedBox(
                                width:  MediaQuery.of(context).size.width * 0.9,
                                height:  MediaQuery.of(context).size.height * 0.6,
                                child: PDFView(
                                      filePath: datos,),
                              ),
                            ),
                            ElevatedButton(onPressed: (){
                                Navigator.pop(context);
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>( const Color.fromARGB(255, 5, 50, 91)),
                            ), child: const Text('Aceptar')),
                          ],
                        ) : SizedBox(
                          // width: MediaQuery.of(context).size.width * 0.9 ,
                          height: MediaQuery.of(context).size.height * 0.6 ,
                          child: const Center(child:  Text('Error, inténtalo más tarde.',style: TextStyle(fontSize: 25))
                          ),
                        ),
                      ),
                    );
                  // return datos;
                } else if (snapshot.hasError) {
                  return const Center(child: Text('Error, inténtalo más tarde.'));
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
  // Future<Widget> _buildPdfView(Map<String, dynamic> documentos) async {
  //   // if (documentos is Map<String, dynamic> && documentos["pdf"] != null) {
  //     final String base64String = documentos["pdf"];
  //     final List<int> doc = base64.decode(base64String);

  //     final Directory dir = await getApplicationDocumentsDirectory();
  //     final File pdfFile = File('${dir.path}/Archivos.pdf');

  //     await pdfFile.writeAsBytes(doc, flush: true);

  //     return PDFView(
  //       filePath: pdfFile.path,
  //     );

    // } else if (documentos is Map<String, dynamic> && documentos["mensaje"] != null) {
    //   return alerterror(
    //     message: documentos["mensaje"],
    //     title: 'Notificación',
    //     icon: Icons.error_outline_outlined,
    //     color: Colors.white,
    //   );
    // } else {
    //   throw Exception("Error fetching PDF data");
    // }
  Future<String> _getPdfAsBytes(idPrestamo,idoperacion) async {
      final prestamoId = idPrestamo;
      final operacionprestamo = idoperacion;
      final token = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
      final plazos = await SharedPreferencesHelper.getdatos('plazos');
      final monto = await SharedPreferencesHelper.getdatos('monto');
      final idOperacionid = await SharedPreferencesHelper.getdatos('idoperacionid');
      // print('Monto $monto');
      // print('plazos $plazos');
      // print('prestamo $prestamoId');

      //  Map data = {};
      Map<String, dynamic> data = {};

      if(prestamoId == 0){

        final postDatas = {
        "token": token,
        "idEmpleado": idEmpleado,
        "idOperacion":  idOperacionid == '' ?  operacionprestamo : idOperacionid,
        "montoPrestamo":   monto,
        "plazos": plazos,
      };
      data = postDatas;
      }else{
        final postDatas = {
          "token": token,
          "idEmpleado": idEmpleado,
          "idOperacion":  idOperacionid == '' ?  operacionprestamo : idOperacionid,
          "montoPrestamo":   0,
          "plazos": 0,
          "idPrestamo":  prestamoId
        };
      data = postDatas;

      }
      

      final dynamic documentos = await fetchPostData(
        modo,
        completeUrldev,
        baseUrl,
        muestraDocumentos,
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

      // print(object) documentos;
      // print('AQUI ESTA LA DATA ');
      // print(documentos['pdf']);
 
    //  final documentos['pdf'];
    if (documentos['pdf'] == null){
      const datos = '';
      return datos;
    }else{
    final List<int> doc = base64.decode(documentos['pdf']);
    final Directory dir = await getApplicationDocumentsDirectory();
    final File pdfFile = File('${dir.path}/Archivos.pdf');
    await pdfFile.writeAsBytes(doc, flush: true);
    // await Future.delayed(Duration(seconds: 10));
  //  return SingleChildScrollView(
  //    child: PDFView(
  //         filePath: pdfFile.path,),
  //  );
    return '${dir.path}/Archivos.pdf';
    }
  }
}