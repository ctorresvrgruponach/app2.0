import '../../libs/lib.dart';
import '../../ui/botondatatable.dart';

class MisAdelantos extends ConsumerStatefulWidget {
  const MisAdelantos({super.key});
  @override
  MisAdelantosState createState() => MisAdelantosState();
}

class MisAdelantosState extends ConsumerState<MisAdelantos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 1.0, bottom: 1.0, left: 8.0, right: 8.0),
                    child: Consumer(builder: (context, watch, child) {
                      final postMisMisNotificacionesProvider =
                          ref.watch(postMisNotificacionesdetalleProviders);
                      return postMisMisNotificacionesProvider.when(
                        data: (data) {
                          if (data["success"] != null && data["success"]) {
                            // Procesar y mostrar datos en DataTable
                            final rows = (data['aval_prestamos'] as List?)
                                ?.cast<Map<String, dynamic>>();

                            if (rows != null && rows.isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Alinea la Columna a la izquierda
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 3,
                                    height: 100,
                                    child: const Text(
                                      "Notificaciones",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 36, 66),
                                        fontSize: 40,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  DataTable(
                                    columns: const [
                                      DataColumn(
                                        label: Text('Número de prestamo'),
                                      ),
                                      DataColumn(
                                        label: Text('monto'),
                                      ),
                                      DataColumn(
                                        label: Text('nombre_solicitante'),
                                      ),
                                      DataColumn(
                                        label: Text('estatus_prestamo'),
                                      ),
                                      DataColumn(
                                        label: Text('estatus'),
                                      ),
                                      DataColumn(
                                        label: Text('editar'),
                                      ),
                                      // Agrega más DataColumn según sea necesario
                                    ],
                                    rows: rows.map<DataRow>((rowData) {
                                      return DataRow(
                                        cells: [
                                          DataCell(
                                            Text('${rowData['id_prestamo']}'),
                                          ),
                                          DataCell(
                                            Text('${rowData['monto']}'),
                                          ),
                                          DataCell(
                                            Text(
                                                '${rowData['nombre_solicitante']}'),
                                          ),
                                          DataCell(
                                            Text(
                                                '${rowData['estatus_prestamo']}'),
                                          ),
                                          DataCell(
                                            Text('${rowData['estatus']}'),
                                          ),
                                          DataCell(
                                            Botondocu(
                                              texto: 'INE',
                                              indiceadelanto:
                                                  '${rowData['id_prestamo']}',
                                            ),
                                          ),
                                          // Agrega más DataCell según sea necesario
                                        ],
                                      );
                                    }).toList(),
                                  ),
                                ],
                              );
                            } else {
                              // Manejar caso en que rows es nulo o vacío
                              return Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 1,
                                      height: 100,
                                      child: const Text(
                                        "Notificaciones",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 1, 55, 98),
                                          fontSize: 40,
                                        ),
                                        textAlign: TextAlign
                                            .left, // Set the text alignment to the left
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            // Manejar caso de éxito falso
                            return Center(
                                child: SizedBox(
                              width: MediaQuery.of(context).size.width * 3,
                              height: 100,
                              child: const Text(
                                "Notificaciones",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 36, 66),
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ));
                          }
                        },
                        loading: () => Center(
                            child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: SizedBox(
                            width: displayWidth(context) * 0.8,
                            child: const Column(
                              children: [
                                Cargando(),
                              ],
                            ),
                          ),
                        )),
                        error: (error, stackTrace) {
                          // Manejar el error de la solicitud
                          return Center(child: Text('Error: $error'));
                        },
                      );
                    }),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 1.0, bottom: 1.0, left: 8.0, right: 8.0),
                    child: Consumer(builder: (context, watch, child) {
                      final postMisAdelantosProvider =
                          ref.watch(postMisAdelantosProviders);
                      return postMisAdelantosProvider.when(
                        data: (data) {
                          if (data["success"] != null && data["success"]) {
                            // Procesar y mostrar datos en DataTable
                            final rows =
                                (data['adelantos']['resultados1'] as List?)
                                    ?.cast<Map<String, dynamic>>();

                            if (rows != null && rows.isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 3,
                                    height: 100,
                                    child: const Text(
                                      "Adelanto de nómina",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 27, 49),
                                        fontSize: 40,
                                      ),
                                      textAlign: TextAlign
                                          .left, // Set the text alignment to the left
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 1.0,
                                        bottom: 1.0,
                                        left: 10.0,
                                        right: 10.0),
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('id'),
                                        ),
                                        DataColumn(
                                          label: Text('no_empleado'),
                                        ),
                                        DataColumn(
                                          label: Text('nombre_completo'),
                                        ),
                                        DataColumn(
                                          label: Text('operaciones'),
                                        ),
                                        DataColumn(
                                          label: Text('descuento'),
                                        ),
                                        DataColumn(
                                          label: Text('total_descuento'),
                                        ),
                                        DataColumn(
                                          label: Text('editar'),
                                        ),
                                        // Agrega más DataColumn según sea necesario
                                      ],
                                      rows: rows.map<DataRow>((rowData) {
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Text('${rowData['id']}'),
                                            ),
                                            DataCell(
                                              Text('${rowData['no_empleado']}'),
                                            ),
                                            DataCell(
                                              Text(
                                                  '${rowData['nombre_completo']}'),
                                            ),
                                            DataCell(
                                              Text('${rowData['operaciones']}'),
                                            ),
                                            DataCell(
                                              Text('${rowData['descuento']}'),
                                            ),
                                            DataCell(
                                              Text(
                                                  '${rowData['total_descuento']}'),
                                            ),
                                            DataCell(
                                              Botoneditar(
                                                texto: 'INE',
                                                indiceadelanto:
                                                    '${rowData['id']}',
                                              ),
                                            ),
                                            // Agrega más DataCell según sea necesario
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              // Manejar caso en que rows es nulo o vacío
                              return Center(
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 3,
                                      height: 100,
                                      child: const Text(
                                        "Adelanto de nómina",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 39, 71),
                                          fontSize: 40,
                                        ),
                                        textAlign: TextAlign
                                            .left, // Set the text alignment to the left
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                          MediaQuery.of(context).size.width * 3,
                                      height: 100,
                                      child: const Text(
                                        "No se encontraron datos.",
                                        style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 1),
                                        ),
                                        textAlign: TextAlign
                                            .left, // Set the text alignment to the left
                                      ),
                                    ),
                                    const Text('No se encontraron datos.'),
                                  ],
                                ),
                              );
                            }
                          } else {
                            // Manejar caso de éxito falso
                            return Center(
                                child: SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              height: 100,
                              child: const Text(
                                "Adelanto de nómina",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 36, 66),
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ));
                          }
                        },
                        loading: () => Center(
                            child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: SizedBox(
                            width: displayWidth(context) * 0.8,
                            child: const Column(
                              children: [
                                Cargando(),
                              ],
                            ),
                          ),
                        )),
                        error: (error, stackTrace) {
                          // Manejar el error de la solicitud
                          return Center(child: Text('Error: $error'));
                        },
                      );
                    }),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 1.0, bottom: 1.0, left: 8.0, right: 8.0),
                    child: Consumer(builder: (context, watch, child) {
                      final postMisAdelantosProvider =
                          ref.watch(postMisAdelantosProviders);
                      return postMisAdelantosProvider.when(
                        data: (data) {
                          if (data["success"] != null && data["success"]) {
                            // Procesar y mostrar datos en DataTable
                            final rows =
                                (data['adelantos']['resultados2'] as List?)
                                    ?.cast<Map<String, dynamic>>();

                            if (rows != null && rows.isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 3,
                                    height: 100,
                                    child: const Text(
                                      "Prestamos",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 36, 66),
                                        fontSize: 40,
                                      ),
                                      textAlign: TextAlign
                                          .left, // Set the text alignment to the left
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DataTable(
                                      columns: const [
                                        DataColumn(
                                          label: Text('id'),
                                        ),
                                        DataColumn(
                                          label: Text('no_empleado'),
                                        ),
                                        DataColumn(
                                          label: Text('nombre_completo'),
                                        ),
                                        DataColumn(
                                          label: Text('operaciones'),
                                        ),
                                        DataColumn(
                                          label: Text('monto_prestamo'),
                                        ),
                                        DataColumn(
                                          label: Text('pago_interes'),
                                        ),
                                        DataColumn(
                                          label: Text('pago'),
                                        ),
                                        DataColumn(
                                          label: Text('editar'),
                                        ),
                                        // Agrega más DataColumn según sea necesario
                                      ],
                                      rows: rows.map<DataRow>((rowData) {
                                        return DataRow(
                                          cells: [
                                            DataCell(
                                              Text('${rowData['id']}'),
                                            ),
                                            DataCell(
                                              Text('${rowData['no_empleado']}'),
                                            ),
                                            DataCell(
                                              Text(
                                                  '${rowData['nombre_completo']}'),
                                            ),
                                            DataCell(
                                              Text('${rowData['operaciones']}'),
                                            ),
                                            DataCell(
                                              Text(
                                                  '${rowData['monto_prestamo']}'),
                                            ),
                                            DataCell(
                                              Text(
                                                  '${rowData['pago_interes']}'),
                                            ),
                                            DataCell(
                                              Text('${rowData['pago']}'),
                                            ),
                                            DataCell(
                                              Botoneditar(
                                                texto: 'INE',
                                                indiceadelanto:
                                                    '${rowData['id']}',
                                              ),
                                            ),
                                            // Agrega más DataCell según sea necesario
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              );
                            } else {
                              // Manejar caso en que rows es nulo o vacío
                              return Column(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 3,
                                    height: 100,
                                    child: const Text(
                                      "Prestamos",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 1, 55, 98),
                                        fontSize: 40,
                                      ),
                                      textAlign: TextAlign
                                          .left, // Set the text alignment to the left
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 3,
                                    height: 100,
                                    child: const Text(
                                      "No se encontraron datos.",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 1),
                                      ),
                                      textAlign: TextAlign
                                          .left, // Set the text alignment to the left
                                    ),
                                  ),
                                ],
                              );
                            }
                          } else {
                            // Manejar caso de éxito falso
                            return Center(
                                child: SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              height: 100,
                              child: const Text(
                                "Prestamos",
                                style: TextStyle(
                                  color: Color.fromARGB(255, 0, 36, 66),
                                  fontSize: 40,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ));
                          }
                        },
                        loading: () => Center(
                            child: Padding(
                          padding: const EdgeInsets.all(40.0),
                          child: SizedBox(
                            width: displayWidth(context) * 0.8,
                            child: const Column(
                              children: [
                                Cargando(),
                              ],
                            ),
                          ),
                        )),
                        error: (error, stackTrace) {
                          // Manejar el error de la solicitud
                          return Center(child: Text('Error: $error'));
                        },
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const MyBottomNavigationBar(
        selectedIndex: 0,
      ),
    );
  }
}
