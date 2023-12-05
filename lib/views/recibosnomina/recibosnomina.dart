import '../../libs/lib.dart';

class ReciboNominaScreen extends ConsumerStatefulWidget {
  const ReciboNominaScreen({super.key});
  @override
  ReciboNominaScreenState createState() => ReciboNominaScreenState();
}

fetchData(operacion, periodo, tipo) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');

  final postDatas = {
    "idEmpleado": idEmpleado,
    "idOperacion": operacion,
    "periodo": periodo,
    "token": token,
    "tipo_archivo": tipo,
  };

  final response = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointRecibosBase64, postDatas);
  if (response['success']) {
    return response;
  } else {
    throw Exception('Error Al obtener el archivo');
  }
}

class ReciboNominaScreenState extends ConsumerState<ReciboNominaScreen> {
  String? operacionValueSelected;
  String? operacionTransitoriasValueSelected;

  final operacionesProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
    final postDatas = {
      "idEmpleado": empleadoId,
      "token": token,
    };
    final dynamic dataOperaciones = await fetchPostData(
        modo, completeUrldev, baseUrl, endpointOperacionesRecibos, postDatas);
    return dataOperaciones;
  });

  final periodosProvider = FutureProvider.family<Map<String, dynamic>, String>(
      ((ref, idOperacion) async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
    final postDatas = {
      "idEmpleado": empleadoId,
      "idOperacion": idOperacion,
      "token": token,
    };
    final dynamic dataPeriodos = await fetchPostData(
        modo, completeUrldev, baseUrl, endpointPeriodosRecibos, postDatas);
    return dataPeriodos;
  }));
  
  final periodosTransitoriosProvider = FutureProvider.family<Map<String, dynamic>, String>(
      ((ref, idOperacion) async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
    final postDatas = {
      "idEmpleado": empleadoId,
      "idOperacionTransitorio": idOperacion,
      "token": token,
    };
    final dynamic dataPeriodosTrancitorios = await fetchPostData(
        modo, completeUrldev, baseUrl, endpointPeriodosRecibosTransitorios, postDatas);
    return dataPeriodosTrancitorios;
  }));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recibos de Nómina'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 2, 9, 72),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              width: displayWidth(context) * 1,
              child: FutureBuilder<Map<String, dynamic>>(
                future: ref.watch(operacionesProvider.future),
                builder: (context, operacionesSnapshot) {
                  if (operacionesSnapshot.hasData &&
                      operacionesSnapshot.data?['operaciones'] != null) {
                    List<dynamic> operaciones =
                        operacionesSnapshot.data!['operaciones'];

                    List<dynamic> operacionesSinDuplicados = [];
                    Set<String> nombresVistos = <String>{};

                    for (var operacion in operaciones) {
                      String nombreOperacion = operacion['nombre_operacion'];
                      if (!nombresVistos.contains(nombreOperacion)) {
                        nombresVistos.add(nombreOperacion);
                        operacionesSinDuplicados.add(operacion);
                      }
                    }
                    final contadorOperaciones = operacionesSinDuplicados.length;
                    if (contadorOperaciones == 1) {
                      operacionValueSelected =
                          operaciones[0]['id_operacion'].toString();
                    }

                    int contadorOperacionesTransitorias = 0;
                    List<dynamic> operacionesTransitoriasList = [];
                    final operacionesTransitorias = operacionesSnapshot.data!['operacionesTransitorias'];
                    if(operacionesTransitorias != null){
                      operacionesTransitoriasList = operacionesSnapshot.data!['operacionesTransitorias'];
                      contadorOperacionesTransitorias = operacionesTransitoriasList.length;
                      if (contadorOperacionesTransitorias == 1) {
                        operacionTransitoriasValueSelected = operacionesTransitorias[0]['id_operacion'].toString();
                      }
                    }

                    return operacionesTransitorias == null ? Column(
                      children: [
                        Visibility(
                          visible: contadorOperaciones == 1,
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Text(
                              operaciones[0]['nombre_operacion'].toString(),
                              style: TextStyle(
                                fontSize: displayWidth(context) * 0.05,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 2, 9, 72),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: contadorOperaciones > 1,
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    'Selecciona una operación',
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(255, 2, 9, 72),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: displayWidth(context) *
                                      0.8, // Establece el ancho deseado
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: DropdownButton<String>(
                                    value: operacionValueSelected,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: displayWidth(context) * 0.04,
                                    ),
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                          left: displayWidth(context) * 0.09),
                                      child: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: Color.fromARGB(255, 2, 9, 72),
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: null,
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth:
                                                  displayWidth(context) * 0.6),
                                          child: const Text(
                                              'Selecciona una opción'),
                                        ),
                                      ),
                                      ...operacionesSinDuplicados
                                          .map<DropdownMenuItem<String>>(
                                        (elemento) {
                                          return DropdownMenuItem<String>(
                                            value: elemento["id_operacion"]
                                                .toString(),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      displayWidth(context) *
                                                          0.6),
                                              child: Text(
                                                elemento["nombre_operacion"],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: Tween<double>(
                                                    begin:
                                                        displayWidth(context) *
                                                            0.03,
                                                    end: displayWidth(context) *
                                                        0.04,
                                                    // ignore: invalid_use_of_protected_member
                                                  ).lerp(0.5),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ],
                                    onChanged: (value) {
                                      if (kDebugMode) {
                                        print(value);
                                      }
                                      setState(() {
                                        operacionValueSelected = value;
                                      });
                                      if (operacionValueSelected != null) {
                                        ref.read(periodosProvider(
                                            operacionValueSelected!));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (operacionValueSelected != null)
                          Visibility(
                            visible: operacionValueSelected != null,
                            child: // ...
                                FutureBuilder(
                              future: operacionValueSelected != null
                                  ? ref.read(
                                      periodosProvider(operacionValueSelected!)
                                          .future)
                                  : null,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Si la petición está en curso, muestra un indicador de carga.
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasData &&
                                    snapshot.data?['success']) {
                                  // Si la petición ha tenido éxito, muestra la DataTable.
                                  final periodos = snapshot.data!['periodos'];
                                  List<Map<String, dynamic>> periodosData =
                                      (periodos as List<dynamic>)
                                          .map((item) =>
                                              item as Map<String, dynamic>)
                                          .toList();
                                  return DataTable(
                                    columns: const [
                                      DataColumn(label: Text('Período')),
                                      DataColumn(label: Text('    PDF')),
                                      DataColumn(label: Text('    XML')),
                                    ],
                                    rows: periodosData.map((periodo) {
                                      return DataRow(
                                        cells: [
                                          DataCell(Text(
                                              periodo['periodo'].toString())),
                                          DataCell(
                                            ElevatedButton(
                                              onPressed: () {
                                                String url =
                                                    "http://nachservice.com.mx/${periodo['archivo_timbrado_pdf']}";
                                                SharedPreferencesHelper
                                                    .setdatos(
                                                        "urlPdfVisor", url);
                                                Navigator.pushNamed(
                                                    context, 'pdf');
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              child: const Text('PDF'),
                                            ),
                                          ),
                                          DataCell(
                                            ElevatedButton(
                                              onPressed: () {
                                                fetchData(
                                                        operacionValueSelected,
                                                        periodo['periodo'],
                                                        2)
                                                    .then((response) {
                                                  String nombreArchivo =
                                                      obtenerNombreArchivoXRuta(
                                                          periodo[
                                                              'archivo_timbrado_xml']);
                                                  String decodedString =
                                                      utf8.decode(base64.decode(
                                                          response['archivo']));
                                                  _saveTextToFile(decodedString,
                                                      nombreArchivo);
                                                }).catchError((error) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return const CircularProgressIndicator();
                                                    },
                                                  );
                                                });
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.green,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              child: const Text('XML'),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                                return const Text(
                                  'No hay datos a mostrar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 2, 9, 72),
                                  ),
                                );
                              },
                            ),
                          )
                        else if (operacionValueSelected == null)
                          Visibility(
                            visible: operacionValueSelected == null,
                            child: const Center(
                                child: Text(
                              'Selecciona una operación',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 2, 9, 72),
                              ),
                            )),
                          )
                      ],
                    ):Column(
                      children: [
                        Visibility(
                          visible: contadorOperacionesTransitorias == 1,
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Text(
                              operacionesTransitoriasList[0]['nombre_operacion'].toString(),
                              style: TextStyle(
                                fontSize: displayWidth(context) * 0.05,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 2, 9, 72),
                              ),
                            ),
                          ),
                        ),
                        Visibility(
                          visible: contadorOperacionesTransitorias > 1,
                          child: Padding(
                            padding: const EdgeInsets.all(22.0),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 20.0),
                                  child: Text(
                                    'Selecciona una operación',
                                    style: TextStyle(
                                      fontSize: displayWidth(context) * 0.05,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          const Color.fromARGB(255, 2, 9, 72),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: displayWidth(context) *
                                      0.8, // Establece el ancho deseado
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12.0),
                                  child: DropdownButton<String>(
                                    value: operacionTransitoriasValueSelected,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: displayWidth(context) * 0.04,
                                    ),
                                    icon: Padding(
                                      padding: EdgeInsets.only(
                                          left: displayWidth(context) * 0.09),
                                      child: const Icon(
                                        Icons.keyboard_arrow_down_sharp,
                                        color: Color.fromARGB(255, 2, 9, 72),
                                      ),
                                    ),
                                    items: [
                                      DropdownMenuItem<String>(
                                        value: null,
                                        child: Container(
                                          constraints: BoxConstraints(
                                              maxWidth:
                                                  displayWidth(context) * 0.6),
                                          child: const Text(
                                              'Selecciona una opción'),
                                        ),
                                      ),
                                      ...operacionesTransitoriasList
                                          .map<DropdownMenuItem<String>>(
                                        (elemento) {
                                          return DropdownMenuItem<String>(
                                            value: elemento["id_operacion"]
                                                .toString(),
                                            child: Container(
                                              constraints: BoxConstraints(
                                                  maxWidth:
                                                      displayWidth(context) *
                                                          0.6),
                                              child: Text(
                                                elemento["nombre_operacion"],
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                  fontSize: Tween<double>(
                                                    begin:
                                                        displayWidth(context) *
                                                            0.03,
                                                    end: displayWidth(context) *
                                                        0.04,
                                                    // ignore: invalid_use_of_protected_member
                                                  ).lerp(0.5),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ).toList(),
                                    ],
                                    onChanged: (value) {
                                      if (kDebugMode) {
                                        print(value);
                                      }
                                      setState(() {
                                        operacionTransitoriasValueSelected = value;
                                      });
                                      if (operacionTransitoriasValueSelected != null) {
                                        ref.read(periodosTransitoriosProvider(
                                            operacionTransitoriasValueSelected!));
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (operacionTransitoriasValueSelected != null)
                          Visibility(
                            visible: operacionTransitoriasValueSelected != null,
                            child: // ...
                                FutureBuilder(
                              future: operacionTransitoriasValueSelected != null
                                  ? ref.read(periodosTransitoriosProvider(operacionTransitoriasValueSelected!).future)
                                  : null,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  // Si la petición está en curso, muestra un indicador de carga.
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else if (snapshot.hasData &&
                                    snapshot.data?['success']) {
                                  // Si la petición ha tenido éxito, muestra la DataTable.
                                  final periodos = snapshot.data!['periodos'];
                                  List<Map<String, dynamic>> periodosData =
                                      (periodos as List<dynamic>)
                                          .map((item) =>item as Map<String, dynamic>)
                                          .toList();
                                  return DataTable(
                                    columns: const [
                                      DataColumn(label: Text('Período')),
                                      DataColumn(label: Text('     ')),
                                      DataColumn(label: Text('    PDF')),
                                    ],
                                    rows: periodosData.map((periodo) {
                                      return DataRow(
                                        cells: [
                                          DataCell(Text(periodo['periodo'].toString())),
                                          const DataCell(Text('')),
                                          DataCell(
                                            ElevatedButton(
                                              onPressed: () {
                                                String url = "";
                                                if(modo == 'dev'){
                                                  url =
                                                    "http://138.197.222.29/miportal/download_recibo_total_app?id_empleado_trans=${periodo['id_empleado_transitorio']}&periodo=${periodo['periodo']}&id_operacion=$operacionTransitoriasValueSelected";
                                                }else{
                                                  url = 
                                                  "http://nachservice.com.mx/miportal/download_recibo_total_app?id_empleado_trans=${periodo['id_empleado_transitorio']}&periodo=${periodo['periodo']}&id_operacion=$operacionTransitoriasValueSelected";
                                                }
                                                SharedPreferencesHelper
                                                    .setdatos(
                                                        "urlPdfVisor", url);
                                                Navigator.pushNamed(
                                                    context, 'pdf');
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: Colors.red,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          8.0),
                                                ),
                                              ),
                                              child: const Text('PDF'),
                                            ),
                                          ),
                                        ],
                                      );
                                    }).toList(),
                                  );
                                } else if (snapshot.hasError) {
                                  return Center(
                                      child: Text('Error: ${snapshot.error}'));
                                }
                                return const Text(
                                  'No hay datos a mostrar',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 2, 9, 72),
                                  ),
                                );
                              },
                            ),
                          )
                        else if (operacionValueSelected == null)
                          Visibility(
                            visible: operacionValueSelected == null,
                            child: const Center(
                                child: Text(
                              'Selecciona una operación',
                              style: TextStyle(
                                fontSize: 20,
                                color: Color.fromARGB(255, 2, 9, 72),
                              ),
                            )),
                          )
                      ],
                    );
                  } else if (operacionesSnapshot.hasError) {
                    return const Text('Error al cargar las operaciones');
                  } else if (operacionesSnapshot.hasData &&
                      operacionesSnapshot.data!['mensaje'] != null) {
                    return Text(
                        'Mensaje: ${operacionesSnapshot.data!['mensaje']}');
                  }
                  return const Cargando();
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  Future<void> _saveTextToFile(String textToSave, String nameDocument) async {
    try {
      Uint8List bytes = Uint8List.fromList(utf8.encode(textToSave));
      List<String> parts = nameDocument.split('.');
      await FileSaver.instance.saveAs(
          name: parts.first,
          ext: 'xml',
          mimeType: MimeType.other,
          bytes: bytes);
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Archivo guardado con éxito $nameDocument'),
        ),
      );
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error al guardar el archivo'),
        ),
      );
    }
  }

  String obtenerNombreArchivoXRuta(String ruta) {
    List<String> partes = ruta.split('/');
    String nombreArchivo = partes.last;
    return nombreArchivo;
  }
}
