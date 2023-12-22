import 'package:com.gruponach.nach_empleado/api/edita_prestamo.dart';
import 'package:intl/intl.dart';

import '../../libs/lib.dart';
import '../../ui/input.dart';

class IdOperacionNotifier extends StateNotifier<String> {
  IdOperacionNotifier() : super('');
  void updateIdOperacion(String newValue) {
    state = newValue;
  }
}

class EditaPrestamo extends ConsumerStatefulWidget {
  const EditaPrestamo(
      {super.key, required this.data, required this.idoperacion});
  // ignore: prefer_typing_uninitialized_variables
  final idoperacion;
  // ignore: prefer_typing_uninitialized_variables
  final data;

  @override
  EditaPrestamoState createState() => EditaPrestamoState();
}

class EditaPrestamoState extends ConsumerState<EditaPrestamo> {
  Map<int, int> idavales = {};
  List<String> filteredValues = [];
  int? selectedValue = 1; //
  int x = 0;
  int diferencia = 0;
  int montoMaximoAval = 8000;
  int avalesn = 0;
  bool btnGuardar = false;
  bool showForm = false;
  int idPrestamoSolicitado = 0;
  bool ocultaBtn = true;

  List<int> montoavales = [];
  int get totalAmount => montoavales.fold(0, (prev, amount) => prev + amount);
  @override
  void initState() {
    super.initState();
    inicializarEnteredAmounts();
  }

  void inicializarEnteredAmounts() {
    // Inicializa montoavales basado en el valor inicial de navales
    montoavales = List.filled(x, 0);
  }

  void actualizarNavales() {
    // Aquí podrías tener una lógica para cambiar el valor de avalesn
    setState(() {
      x = avalesn; // Cambio de avalesn a otro valor
      // Actualiza montoavales con el nuevo valor de avalesn
      montoavales = List.filled(x, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
//PETIION EDICION SE  PRESTAMOS
    int idPrestamo = widget.data;
    int idoperacion = widget.idoperacion;
    // print('ID DEL PRESTAMO $idPrestamo');
    final editaPrestamo =
        FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
      final token = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
      // final idOperacionid =await SharedPreferencesHelper.getdatos('idoperacionid');
      // print(idOperacionid);
      final postDatas = {
        "idEmpleado": idEmpleado,
        "token": token,
        "idOperacion": idoperacion,
        "idPrestamo": idPrestamo,
      };

      final dynamic dataEditaPrestamo = await fetchPostData(
          modo, completeUrldev, baseUrl, solicitaPrestamoEdit, postDatas);

      if (dataEditaPrestamo is Map<String, dynamic> &&
          dataEditaPrestamo["success"] != null) {
        if (dataEditaPrestamo["success"]) {
        } else {}
      } else {
        if (kDebugMode) {
          print(
              'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
        }
        // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
      }

      return dataEditaPrestamo;
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
        title: const Text('Editar avales '),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 25),
            FutureBuilder<Map<String, dynamic>>(
              future: ref.watch(editaPrestamo.future),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data!['prestamo'] != null) {
                  final avalesConfirmados =
                      snapshot.data!['avales_confirmados'];
                  final avales = snapshot.data!['avales'];
                  final montoSolicitado =
                      snapshot.data!['prestamo']['monto_prestamo'];
                  // final saldoPendiente    = snapshot.data!['prestamo']['saldo_pendiente'];
                  final idPrestamo = snapshot.data!['prestamo']['id'];
                  SharedPreferencesHelper.setdatos('avales', '$idPrestamo');

                  double prestamoSolicitado = double.parse(montoSolicitado);
                  int prestamo = prestamoSolicitado.toInt();

                  // double pendienteSaldo = double.parse(saldoPendiente);
                  // int saldo = pendienteSaldo.toInt();
                  List<Map<String, dynamic>> confirmados =
                      (avalesConfirmados as List<dynamic>)
                          .map((item) => item as Map<String, dynamic>)
                          .toList();
                  double sumaTotalAvalesCondirmados =
                      obtenerSumaIdEmpleado(confirmados);
                  // print('La suma de id_empleado es: $sumaTotalAvalesCondirmados');
                  int avalesConfirmadosSumoTotal =
                      sumaTotalAvalesCondirmados.toInt();
                  // print(avalesConfirmadosSumoTotal);
                  // print(avalesConfirmadosSumoTotal.runtimeType);
                  if (prestamo <= montoMaximoAval) {
                    diferencia = 1;
                  } else {
                    var faltante = prestamo - avalesConfirmadosSumoTotal;
                    int navales = (faltante / montoMaximoAval).ceil();
                    diferencia = navales;
                  }
                  String formatCurrency(dynamic amount) {
                    NumberFormat currencyFormat =
                        NumberFormat.currency(locale: 'es_MX', symbol: '\$');
                    return currencyFormat.format(amount);
                  }

                  String formattedMonoto = formatCurrency(prestamo);
                  // actualizarEstado();
                  return Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        avalesConfirmados.isNotEmpty
                            ? 'Mis avales'
                            : 'Selecciona nuevamente a tu aval',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      Visibility(
                        visible: avalesConfirmados.isNotEmpty ? true : false,
                        child: DataTable(
                          columns: const [
                            DataColumn(label: Text('Nombre')),
                            DataColumn(label: Text('Monto')),
                            DataColumn(label: Text('Estatus')),
                          ],
                          rows: confirmados.map((mapa) {
                            return DataRow(cells: [
                              DataCell(Text(
                                mapa['nombre_completo'].toString(),
                                style: const TextStyle(fontSize: 12),
                              )),
                              // DataCell(Text(mapa['monto'].toString())),
                              DataCell(Text('\$${mapa['monto']}')),

                              DataCell(Text(
                                  mapa['estatus'] == 0
                                      ? 'Notificado'
                                      : 'Aceptado',
                                  style: const TextStyle(fontSize: 12))),
                              // DataCell(Text(mapa['no_empleado'].toString())),
                            ]);
                          }).toList(), // <-- Importante: Usa toList() aquí
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text('Prestamo solicitado $formattedMonoto'),
                      if (ocultaBtn)
                        Visibility(
                          visible: (avalesConfirmados.isNotEmpty)
                              ? true
                              : (diferencia >= 1)
                                  ? true
                                  : false,
                          child: Visibility(
                            visible: diferencia >= 1,
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    showForm = true;
                                    idPrestamoSolicitado = idPrestamo;
                                    ocultaBtn = false;
                                    actualizarEstado();
                                  });
                                },
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            const Color.fromARGB(255, 5, 50,
                                                91))), // Color de fondo azul
                                child: const Text('Continuar')),
                          ),
                        ),
                      Visibility(
                        visible: showForm,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: generaAvales(
                              avales,
                              diferencia,
                              montoSolicitado,
                              sumaTotalAvalesCondirmados,
                              avalesConfirmados),
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error de conexion');
                  // return Text(snapshot.error.toString());
                } else if (snapshot.hasData &&
                    snapshot.data!['mensaje'] != null) {
                  return alerterror(
                      message: snapshot.data!['mensaje'],
                      title: 'Notificación',
                      icon: Icons.notification_add,
                      color: Colors.white);

                  //  return Text(snapshot.error.toString());
                }
                // By default show a loading spinner.
                return const Cargando();
              },
            ),
          ],
        ),
      ),
    );
  }

  void validaavales(int value) {
    if (value > 8000) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return const CustomAlertDialog(
              message: 'El monto por Aval no puede ser mayor a \$8,000.00',
              title: 'Atención',
              icon: Icons.error_outline,
              color: Colors.amber);
        },
      );
    }
  }

  void actualizarEstado() {
    setState(() {
      avalesn = diferencia;
      actualizarNavales();
    });
  }

  double obtenerSumaIdEmpleado(List<Map<String, dynamic>> confirmados) {
    return confirmados.fold(0, (suma, mapa) => suma + (mapa['monto'] ?? 0));
  }

  Widget generaAvales(avales, diferencia, montoSolicitado,
      sumaTotalAvalesCondirmados, avalesConfirmados) {
    double montoFaltanteAval = double.parse(montoSolicitado);
    double montoRestante = montoFaltanteAval - sumaTotalAvalesCondirmados;
    final enviaNuevosAvales = ActualizaAvales();
    Future<List<Object>> getFakeRequestData(String query) async {
      await Future.delayed(const Duration(seconds: 1));
      final busqueda = query.toLowerCase();

      final matchingOptions = avales
          .where((opcion) {
            if (opcion is Map<String, dynamic> &&
                opcion.containsKey('no_empleado') &&
                opcion.containsKey('id_empleado') &&
                opcion.containsKey('nombre_completo')) {
              return opcion['no_empleado'].toString().toLowerCase() ==
                      busqueda ||
                  opcion['nombre_completo'].toString().toLowerCase() ==
                      busqueda;
            }
            return false;
          })
          .map((opcion) {
            if (opcion is Map<String, dynamic> &&
                opcion.containsKey('nombre_completo')) {
              return opcion['nombre_completo'].toString();
            }
            return null;
          })
          .whereType<String>()
          .toList();

      if (matchingOptions.isNotEmpty) {
        return matchingOptions;
      } else {
        return [];
      }
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              visible: diferencia > 1 ,
              child: const Text('Selecciona a tus avales',
                style: TextStyle(fontWeight: FontWeight.w900),
              ),
            ),
            // Text('Monto del prestamo solicitado $montoSolicitado'),
            // Text('Monto faltante ($montoSolicitado - $sumaTotalAvalesCondirmados)'),
            for (var i = 0; i < diferencia; i++)
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CustomDropdown.searchRequest(
                    futureRequest: getFakeRequestData,
                    hintText: 'Selecciona a tu aval',
                    searchHintText: 'Número de empleado',
                    excludeSelected: false,
                    items:
                        filteredValues, // Usar filteredValues en lugar de avales
                    // onChanged: (value) {
                    //   List<Map<String, dynamic>> nuevoaval = avales.cast<Map<String, dynamic>>();
                    //   validateAndHandleDialog(i, value, nuevoaval, idavales);
                    // },
                    onChanged: (value) {
                      // print(value);
                      // Check if the selected value is not empty or null
                      // ignore: unnecessary_null_comparison
                      if (value != null && value.toString().isNotEmpty) {
                        int selectedId = avales.firstWhere((element) =>
                            element['nombre_completo'] == value)['id_empleado'];

                        if (!idavales.containsValue(selectedId)) {
                          // Validar que el ID no esté ya seleccionado
                          idavales[i] = selectedId;
                          // print( idavales[i]);
                          setState(() {
                            selectedValue = selectedId;
                          });
                        } else {
                          setState(() {
                            selectedValue = 0;
                          });

                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomAlertDialog(
                                message:
                                    'Este aval ya ha sido seleccionado. Por favor, elige otro.',
                                title: 'Atención',
                                icon: Icons.error_outline,
                                color: Colors.amber,
                              );
                            },
                          );

                          idavales.remove(i);
                          if (kDebugMode) {
                            print(
                                'Elemento eliminado en la posición $i: $selectedId');
                          }
                        }
                      } else {
                        // Handle the case when the selected value is empty or null
                        // You can show an error message or perform any other desired action.
                        if (kDebugMode) {
                          print('Selected value is empty or null');
                        }
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')), // Permite solo dígitos numéricos
                    ],
                    decoration: InputDecorationBuilder.finalinput(
                        hintText: 'Cantidad', labelText: 'Monto aval'),
                    // initialValue: navales == 1 ? montoinput : '',
                    // readOnly: navales == 1 ? true : false,
                    onChanged: (value) {
                      setState(() {
                        // ignore: unnecessary_null_comparison
                        if (value != null && value.isNotEmpty) {
                          validaavales(int.parse(value));
                          montoavales[i] = int.parse(value);
                          // print('Valor ${montoavales[i]}');
                        } else {
                          montoavales[i] = 0;
                          // print('Valor $montoavales[i]');
                        }
                      });
                    },
                  ),
                ],
              ),
            //     Text('$totalAmount'),
            // Text('Total: $montoavales'),

            // Text('FALTANTE $diferencia'),
            // Text(totalAmount == montoRestante ? 'Valido ': 'No valido'),
            Visibility(
              // visible:( avalesConfirmados.isNotEmpty) ? true :  (diferencia  >= 1 ) ? true : false,
              visible: diferencia == 0 ? false : true,
              child: ElevatedButton(
                  onPressed: btnGuardar
                      ? null
                      : () async {
                          if (montoRestante == totalAmount &&
                              idavales.length == diferencia) {
                            Map<int, Map<String, int>>
                                nuevosAvalesSeleccionados = {};
                            idavales.forEach((key, value) {
                              if (montoavales.length > key) {
                                nuevosAvalesSeleccionados[key] = {
                                  'idEmpleado': value,
                                  'monto_aval': montoavales[key],
                                };
                              }
                            });
                            SharedPreferencesHelper.setdatos(
                                'avales', '$nuevosAvalesSeleccionados');
                            SharedPreferencesHelper.setdatos(
                                'idPrestamo', '$idPrestamoSolicitado');
                            setState(() {
                              btnGuardar = true;
                            });
                            final respuesta =
                                await enviaNuevosAvales.actualizaAvales();
                            if (respuesta['estatus'] == 200) {
                              ref.refresh(postMisNotificacionesdetalleProviders);
                              ref.refresh(postMisAdelantosProviders);
                              //ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return alersuccess(
                                      message: respuesta['mensaje'],
                                      title: 'Éxito',
                                      icon: Icons.check,
                                      color: Colors.green);
                                },
                              );
                            } else if (respuesta['estatus'] == 201) {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                      message: respuesta['mensaje'],
                                      title: 'Error',
                                      icon: Icons.error_outline,
                                      color: Colors.red);
                                },
                              );
                            }
                          } else if (idavales.length < diferencia) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomAlertDialog(
                                    message: 'Selecciona a tus avales.',
                                    title: 'Atención',
                                    icon: Icons.error_outline,
                                    color: Colors.amber);
                              },
                            );
                          } else if (totalAmount < montoRestante ||
                              totalAmount > montoRestante) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return const CustomAlertDialog(
                                    message:
                                        'Por favor verifica tus montos ingresados por aval.',
                                    title: 'Atención',
                                    icon: Icons.error_outline,
                                    color: Colors.amber);
                              },
                            );
                          }
                        },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      btnGuardar
                            ? const Color.fromARGB(255, 23, 23, 23)
                            : const Color.fromARGB(
                                255, 5, 50, 91)),  // Color de fondo azul
                    // Color de fondo azul
                  ),
                  child: btnGuardar
                  ? const Text('Procesando')
                  : const Text(
                      'Guardar',
                      style: TextStyle(
                        color:  Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),

                  ),
            )
          ],
        ),
      ),
    );
  }

  algo() {}
}
