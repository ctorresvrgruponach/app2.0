import '../../libs/lib.dart';
import '../../ui/botondatatable.dart';
import '../prestamos/documentos.dart';

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
              crossAxisAlignment: CrossAxisAlignment.start,
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
                            final rowsavales = (data['adelantos'] as List?)
                                    ?.cast<Map<String, dynamic>>() ??
                                [];

                            if (rows != null && rows.isNotEmpty) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Alinea la Columna a la izquierda
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 3,
                                    height: 80,
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
                                        label: Text('Monto'),
                                      ),
                                      DataColumn(
                                        label: Text('Solicitante'),
                                      ),

                                      DataColumn(
                                        label: Text('Estatus'),
                                      ),
                                      DataColumn(
                                        label: Text('Aprobar'),
                                      ),

                                      DataColumn(
                                        label: Text('Rechazar'),
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
                                            Text('${rowData['estatus']}'),
                                          ),
                                          DataCell(
                                            Botondocup(
                                              texto: 'APROBAR',
                                              indiceadelanto:
                                                  '${rowData['id_prestamo']}',
                                              notificacion:
                                                  0,
                                              someAvalesMap: rowsavales,
                                            ),
                                          ),

                                          DataCell(
                                            Botondocur(
                                              texto: 'Rechazar',
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
                              return GestureDetector(
                                onTap: () {
                                  ref.refresh(
                                      postMisNotificacionesdetalleProviders);
                                  ref.refresh(postMisAdelantosProviders);
                                },
                                child: Align(
                                  alignment: Alignment.centerRight,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        height: 80,
                                        child: const Text(
                                          "Notificaciones",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 1, 55, 98),
                                            fontSize: 40,
                                          ),
                                          textAlign: TextAlign
                                              .right, // Set the text alignment to the left
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        height: 80,
                                        child: const Text(
                                          "No tiene notificaciones nuevas. Toca para actualizar",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 1),
                                          ),
                                          textAlign: TextAlign
                                              .left, // Set the text alignment to the left
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }
                          } else {
                            // Manejar caso de éxito falso
                            return Align(
                              alignment: Alignment.centerRight,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        height: 80,
                                        child: const Text(
                                          "Notificaciones",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 36, 66),
                                            fontSize: 40,
                                          ),
                                          textAlign: TextAlign.right,
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      ref.refresh(
                                          postMisNotificacionesdetalleProviders);
                                    },
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            height: 100,
                                            child: const Text(
                                              "No tiene notificaciones nuevas. Toca para actualizar",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 1),
                                              ),
                                              textAlign: TextAlign
                                                  .left, // Set the text alignment to the left
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
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
                                    height: 80,
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
                                                texto: 'Editar',
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
                              return Align(
                                alignment: Alignment.centerLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1,
                                        height: 80,
                                        child: const Text(
                                          "Adelanto de nómina",
                                          style: TextStyle(
                                            color:
                                                Color.fromARGB(255, 0, 39, 71),
                                            fontSize: 40,
                                          ),
                                          textAlign: TextAlign
                                              .left, // Set the text alignment to the left
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomLeft,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                1,
                                            height: 100,
                                            child: const Text(
                                              "No se encontraron prestamos.",
                                              style: TextStyle(
                                                color: Color.fromARGB(
                                                    255, 0, 0, 1),
                                              ),
                                              textAlign: TextAlign
                                                  .left, // Set the text alignment to the left
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                          } else {
                            // Manejar caso de éxito falso
                            return Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height: 100,
                                    child: const Text(
                                      "Adelanto de nómina",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 36, 66),
                                        fontSize: 40,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 1,
                                    height: 100,
                                    child: const Text(
                                      "No cuenta con adelanto de nómina.",
                                      style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 1),
                                      ),
                                      textAlign: TextAlign
                                          .left, // Set the text alignment to the left
                                    ),
                                  ),
                                ],
                              ),
                            );
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

                            final rowsavales =
                                (data['adelantos']['resultados3'] as List?)
                                    ?.cast<Map<String, dynamic>>();
                            SharedPreferencesHelper.getdatos('idoperacionid');

                            //  print(avales.length);

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
                                          label: Text('ID'),
                                        ),
                                        DataColumn(
                                          label: Text('No Empleado'),
                                        ),
                                        DataColumn(
                                          label: Text('Nombre Completo'),
                                        ),
                                        DataColumn(
                                          label: Text('Operación'),
                                        ),
                                        DataColumn(
                                          label: Text('Monto Prestamo'),
                                        ),
                                        DataColumn(
                                          label: Text('Pago Interés'),
                                        ),
                                        DataColumn(
                                          label: Text('pago'),
                                        ),
                                        DataColumn(
                                          label: Text('Estatus'),
                                        ),
                                        DataColumn(
                                          label: Text('Acciones', textAlign: TextAlign.center),
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
                                              rowData['estatus_prestamo'] == 1 ? const Text('Activo'):(rowData['estatus_prestamo'] == 4) ? const Text('Rechazado') : const Text('Pendiente de aprobación')
                                              // Text('${rowData['estatus_prestamo']}'),
                                            ),
                                            // DataCell(
                                            //   rowData['estatus_prestamo'] == 1
                                            //       ? const Text(
                                            //           'Activo')
                                            //       :(rowsavales!.isEmpty ) || rowData['estatus_prestamo'] == 0 ?   Botondocup(
                                            //           texto: rowsavales!.isEmpty  ? 'Ver vales' : 'Agrega nuevo aval',
                                            //           indiceadelanto:
                                            //               '${rowData['id']}',
                                            //           idoperacion:
                                            //               '${rowData['id_operacion']}',
                                            //           notificacion:
                                            //               1,
                                            //           someAvalesMap: rowsavales,
                                            //         ) : const Text(
                                            //           'Pendiente de aprobacion') ,
                                            // ),
                                            // Agrega más DataCell según sea necesario
                                            // DataCell( rowData['estatus_prestamo'] == 1 ? Row(
                                            //   children: [
                                            //     const Text('Activo'),
                                            //     const SizedBox(width:12),
                                            //     ElevatedButton(onPressed: () {
                                            //       print('ME TOCASTE');
                                            //     }, child: const Text('Documentos'))
                                            //   ],
                                            // ) : rowData['estatus_prestamo'] == 0 ?   Botondocup(
                                            //           texto: rowsavales!.isEmpty  ? 'Ver avales' : 'Agrega nuevo aval',
                                            //           indiceadelanto:
                                            //               '${rowData['id']}',
                                            //           idoperacion:
                                            //               '${rowData['id_operacion']}',
                                            //           someAvalesMap: rowsavales,
                                            //           notificacion: 1,
                                            //         ) : rowData['estatus_prestamo'] == 4 ? const Text(
                                            //           'Rechazado'): const Text('Pendiente de aprobación'),
                                            //   ),
                                            DataCell(
                                              rowData['estatus_prestamo'] == 0 ? Botondocup(
                                                      texto: rowsavales!.isEmpty  ? 'Ver avales' : 'Agrega nuevo aval',
                                                      indiceadelanto:
                                                          '${rowData['id']}',
                                                      idoperacion:
                                                          '${rowData['id_operacion']}',
                                                      someAvalesMap: rowsavales,
                                                      notificacion: 1,
                                                    )  :(rowData['estatus_prestamo'] == 1) ? ElevatedButton(onPressed: (){
                                                      int idPrestamo =rowData['id'];
                                                      int idoperacion =rowData['id_operacion'];
                                                  
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => VerDocumentos( data: idPrestamo, idoperacion: idoperacion),
                                                        ),
                                                      );
                                                    },
                                                    style: ButtonStyle(
                                                    backgroundColor: MaterialStateProperty.all<Color>( const Color.fromARGB(255, 5, 50, 91)),
                                                    ),child: const Text('Documentos')) : const Text('')
                                            ),
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                3,
                                        height: 100,
                                        child: const Text(
                                          "No se encontraron datos.",
                                          style: TextStyle(
                                            color: Color.fromARGB(255, 0, 0, 3),
                                          ),
                                          textAlign: TextAlign
                                              .left, // Set the text alignment to the left
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          } else {
                            // Manejar caso de éxito falso
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width * 3,
                                  height: 100,
                                  child: const Text(
                                    "Prestamos",
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 0, 36, 66),
                                      fontSize: 40,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            );
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
