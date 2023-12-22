// import 'package:com.gruponach.nach_empleado/lib/custom_dropdown.dart';
import 'package:intl/intl.dart';

import '../../api/calcula_prestamo.dart';
import '../../api/confirmar_prestamo.dart';
import '../../api/solicita_prestamo.dart';
import '../../libs/lib.dart';
import '../../ui/input.dart';

String? montoinput;
String? plazos;
bool? response;

class IdOperacionNotifier extends StateNotifier<String> {
  IdOperacionNotifier() : super('');
  void updateIdOperacion(String newValue) {
    state = newValue;
  }
}

final calcularPrestamos =
    StateNotifierProvider<IdOperacionNotifier, String>((ref) {
  return IdOperacionNotifier();
});

class SolicitaPrestamo extends ConsumerStatefulWidget {
  const SolicitaPrestamo({super.key});
  @override
  SolicitaPrestamoState createState() => SolicitaPrestamoState();
}

class SolicitaPrestamoState extends ConsumerState<SolicitaPrestamo> {
  void _sendData() {
    setState(() {
      button = true;
      _inputs = true;
      _ocultabtn = false;
    });
  }
  // void onPressed() {
  //   setState(() {
  //     btncalculaprestamo = true; // Deshabilita el botón
  //   });
  //   // Aquí podrías agregar lógica adicional si es necesario
  // }

  final TextEditingController montosolicitado = TextEditingController();
  final TextEditingController plazoseleccionado = TextEditingController();
  // final TextEditingController _comisionapertura = TextEditingController();
  // TextEditingController       _pagoPrestamo     = TextEditingController();
  // late TextEditingController  _pagoprestamo;
  // late TextEditingController  _tasaconiva;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // final List<TextEditingController> _montoaval        = [];
  int? selectedValue = 1; //
  String? idEmpleadoSeleccionado;
  bool button = false;
  bool _inputs = false;
  bool _ocultabtn = true;
  bool showForm = false;
  double cnatidadfinal = 0;
  int avalesn = 0;
  int comision = 0;
  int montomaximoaval = 0;
  Map<String, dynamic> datos = {};
  int x = 0;
  bool btncalculaprestamo = false;
  bool btnsolicitaPrestamo = false;
  String? nuevo; //
  bool mostrarCard = true;
  int catorcenal = 26;
  int quincenal  = 24;
  int semanal    = 56;
  bool btnDocumentos = false;
  bool btnCambiaMonto = true;
  bool verdocumentos = false;

//PARA LOS AVALES

  final token = SharedPreferencesHelper.getdatos('token');
  final idEmpleado = SharedPreferencesHelper.getdatos('empleado');
  final idOperacionid = SharedPreferencesHelper.getdatos('idoperacionid');

  Map<int, int> idavales = {};
  List<String> filteredValues = [];

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
    final montosolicitado = ref.read(montoinputControllerProvider);
    final plazoseleccionado = ref.read(plazosControllerProvider);

  void limpiarCampos() {
    setState(() {
      montosolicitado.clear();
      plazoseleccionado.clear();
    });
  }
    fetchData() async {
      final token = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
      final idOperacionid =
          await SharedPreferencesHelper.getdatos('idoperacionid');
      final montosolicitado = ref.watch(montoinputControllerProvider);
      final plazoseleccionado = ref.watch(plazosControllerProvider);
      montoinput = montosolicitado.text;
      plazos = plazoseleccionado.text;

      final postDatas = {
        "idEmpleado": idEmpleado,
        "idOperacion": idOperacionid,
        "monto_solicitado": montoinput,
        "plazos": plazos,
        "token": token,
      };

      final response = await fetchPostData(
          modo, completeUrldev, baseUrl, calculaPrestamo, postDatas);
      if (response['estatus'] == 200) {
        _sendData();
        return response;
      } else {
        throw Exception('Error al cargar los datos');
      }
    }

    // final calculoresponse = ref.watch(calcularPrestamos);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitar Prestamo'),
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            onPressed: () async {
              setState(() {
                someMap.clear();
              });
                limpiarCampos();
              await SharedPreferencesHelper.remove('Identificación (INE)');
              await SharedPreferencesHelper.remove('Comprobante (DOMICILIO)');
              // ignore: use_build_context_synchronously
              Navigator.pushNamed(context, 'home');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<Map<String, dynamic>>(
              future: ref.watch(solicitarPrestamo.future),
              builder: (context, snapshot) {
                // print('object');
                if (snapshot.hasData && snapshot.data!['empleado'] != null) {
                  if (kDebugMode) {}
                  // print(snapshot.data!['empleado']);
                  final avales = snapshot.data!['avales'];
                  final montoMaximo = snapshot.data!['monto_maximo'];
                  // print('El monto bb $montoMaximo');
                  // print(montoMaximo.runtimeType);

                  // final montoXAval      = snapshot.data!['monto_x_aval'];
                  final plazosRestantes = snapshot.data!['plazos_restantes'];
                  // final montoingresado  = montosolicitado.text;
                  String formatCurrency(dynamic amount) {
                    NumberFormat currencyFormat =
                        NumberFormat.currency(locale: 'es_MX', symbol: '\$');
                    return currencyFormat.format(amount);
                  }

                  String formattedMonoto = formatCurrency(montoMaximo);
                  // print('Res $formattedMonoto');

                  void validaMonto() {
                    final String amountText = montosolicitado.text;
                    if (amountText.isEmpty) {
                      return;
                    }
                    final double? amount = double.tryParse(amountText);
                    if (amount != null && amount > montoMaximo) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              message:
                                  'Tu Prestamo Debe Ser Menor o Igual a \$$montoMaximo',
                              title: 'Cantidad excedida',
                              icon: Icons.error_outline_outlined,
                              color: Colors.red);
                        },
                      );
                      montosolicitado.clear();
                    }
                  }

                  void validaPlazos() {
                    final String amountText = plazoseleccionado.text;
                    if (amountText.isEmpty) {
                      return;
                    }
                    final int? amount = int.tryParse(amountText);
                    if (kDebugMode) {
                      print(amount);
                    }
                    if (amount != null && amount > plazosRestantes) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              message:
                                  'Los plazos no pueden ser mayor a $plazosRestantes.',
                              title: 'Error...',
                              icon: Icons.error_outline_outlined,
                              color: Colors.amber);
                        },
                      );
                      plazoseleccionado.clear();
                    }
                  }

                  return Column(
                    children: [
                      mostrarCard ? card(formattedMonoto) : Container(),
                      Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Hero(
                                            tag: 'alert',
                                            child: TextFormField(
                                              controller: montosolicitado,
                                              keyboardType:
                                                  TextInputType.number,
                                              inputFormatters: <TextInputFormatter>[
                                                FilteringTextInputFormatter
                                                    .allow(RegExp(
                                                        r'[0-9]')), // Permite solo dígitos numéricos
                                              ],
                                              decoration: InputDecorationBuilder
                                                  .finalinput(
                                                      hintText: 'Cantidad',
                                                      labelText:
                                                          'Monto prestamo'),
                                              enabled: !_inputs,

                                              onChanged: (value) {
                                                validaMonto();
                                              },
                                              // validator: (value) {
                                              //   var valor =int.parse(value);
                                              //   if (value == null || value.isEmpty ){
                                              //     return 'Ingresa el monto';
                                              //   } else if( valor < 1000 ){
                                              //     return 'Monto minimo \$1000';
                                              //   }
                                              // },
                                              validator: (value) {
                                                if (value == null ||
                                                    value.isEmpty) {
                                                  return 'Por favor, ingresa el monto';
                                                }

                                                var valor = int.tryParse( value); // Intenta convertir a entero
                                                if (valor == null || valor < 5000) {
                                                  return 'Monto mínimo \$5,000.00';
                                                }
                                                return null;
                                              },
                                            )),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          keyboardType: TextInputType.number,
                                          inputFormatters: <TextInputFormatter>[
                                            FilteringTextInputFormatter.allow(
                                                RegExp(
                                                    r'[0-9]')), // Permite solo dígitos numéricos
                                          ],
                                          controller: plazoseleccionado,
                                          decoration:
                                              InputDecorationBuilder.finalinput(
                                                  hintText:
                                                      'Maximo $plazosRestantes plazos',
                                                  labelText: 'Plazos'),
                                          enabled: !_inputs,
                                          validator: (value) {
                                            if (value == null || value.isEmpty) {
                                              return 'Por favor, ingresa los plazos';
                                            }
                                            var valor = int.tryParse(value); // Intenta convertir a entero
                                            if(plazosRestantes == catorcenal || plazosRestantes == quincenal){
                                              if (valor == null || valor < 4) {
                                                return 'Minimo 4 plazos ';
                                              }
                                              return null;
                                              }else if(plazosRestantes == semanal){
                                                if (valor == null || valor < 8) {
                                                  return 'Minimo 8 plazos ';
                                                }
                                              return null;
                                              }

                                            // if (valor == null || valor < 6) {
                                            //   return 'Minimo 6 plazos ';
                                            // }
                                            // // Si no hay errores, retorna null
                                            return null;
                                          },
                                          onChanged: (_) {
                                            validaPlazos();
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (_ocultabtn)
                                  ElevatedButton(
                                      onPressed: btncalculaprestamo
                                          ? null
                                          : () {
                                              // if (!btncalculaprestamo) {
                                              if (_formKey.currentState!
                                                  .validate()) {
                                                setState(() {
                                                  btncalculaprestamo = true;
                                                });
                                                fetchData().then((response) {
                                                  final montoingresado =
                                                      montosolicitado.text;
                                                  final montofinal =
                                                      double.parse(
                                                          montoingresado);
                                                  final montoXAval = snapshot
                                                      .data!['monto_x_aval'];
                                                  double resultadoDivision =
                                                      double.parse(
                                                              montoingresado) /
                                                          montoXAval;
                                                  int resultadoRedondeado =
                                                      resultadoDivision.ceil();
                                                  // final montoIngresado =
                                                  //     montosolicitado.text;
                                                  final comisionapertura =
                                                      response['resumen']
                                                          ['comision'];
                                                  if (response['estatus'] ==
                                                      200) {
                                                    setState(() {
                                                      showForm = true;
                                                      datos = response;
                                                      avalesn =
                                                          resultadoRedondeado;
                                                      cnatidadfinal =
                                                          montofinal;
                                                      comision =
                                                          comisionapertura;
                                                      montomaximoaval =
                                                          montoXAval;
                                                      actualizarNavales();
                                                      mostrarCard =
                                                          !mostrarCard;
                                                    });
                                                  }
                                                }).catchError((error) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: const Text(
                                                            'HAY UN ERROR...'),
                                                        content: Text(
                                                            error.toString()),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child: const Text(
                                                                'Cerrar'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                });
                                              }
                                              // }
                                            },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty
                                            .all<Color>(btncalculaprestamo
                                                ? const Color.fromARGB(
                                                    255, 23, 23, 23)
                                                : const Color.fromARGB(
                                                    255,
                                                    5,
                                                    50,
                                                    91)), // Color de fondo azul
                                      ),
                                      child: Text(
                                        btncalculaprestamo
                                            ? 'Calculando....'
                                            : 'Calcular Prestamo',
                                        style: TextStyle(
                                          color: btncalculaprestamo
                                              ? Colors.white
                                              : Colors.white,
                                          // backgroundColor: Colors.amber,
                                        ),
                                      )),
                                const SizedBox(height: 20),
                                Visibility(
                                  visible: showForm,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                readOnly: true,
                                                // controller: _pagoPrestamo,
                                                initialValue:
                                                    datos['abono'].toString(),
                                                decoration: InputDecorationBuilder
                                                    .finalinput(
                                                        hintText:
                                                            'Monto a pagar',
                                                        labelText:
                                                            'Pago por periodo'),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: TextFormField(
                                                readOnly: true,
                                                initialValue:
                                                    comision.toString(),
                                                decoration: InputDecorationBuilder
                                                    .finalinput(
                                                        hintText:
                                                            'Comision por Apertura',
                                                        labelText:
                                                            'Comision por Apertura'),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const SizedBox(height: 20),
                                      // Text('observacion', style: TextStyle(fontSize: 20)),
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.9,
                                          child: ElevatedButton(onPressed:  verdocumentos
                                                  ? null
                                                  : (){
                                            SharedPreferencesHelper.setdatos('monto', '$montoinput'); //monto
                                            SharedPreferencesHelper.setdatos('plazos', '$plazos'); //plazos
                                            Navigator.pushNamed(context, 'documentos');
                                            setState(() {
                                              btnDocumentos = true;
                                              verdocumentos = true;
                                            });
                                          },
                                          style: ButtonStyle(
                                          backgroundColor: MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(255, 5, 50, 91)),
                                        ), child: const Text('Ver Documentos'),),
                                      ),
                                      const Text(
                                        'La identificacion debe ser vigente , el comprobante de domicilio no puede ser mayor a 3 meses de antiguedad.',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      const Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding: EdgeInsets.all(8.0),
                                              child: Botonfile(
                                                  texto:
                                                      'Identificación (INE)')),
                                          Padding(
                                            padding: EdgeInsets.all(5.0),
                                            child: Botonfile(
                                                texto:
                                                    'Comprobante (DOMICILIO)'),
                                          )
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: generaAvales(
                                            avales, avalesn, cnatidadfinal),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ))
                    ],
                  );
                } else if (snapshot.hasError) {
                  return const Center(
                      child: Text('Error intentalo mas tarde.'));
                  // return Text(snapshot.error.toString());
                } else if (snapshot.hasData &&
                    snapshot.data!['mensaje'] != null) {
                  return alerterror(
                      message: snapshot.data!['mensaje'],
                      title: 'Notificación',
                      icon: Icons.notification_add,
                      color: Colors.white);
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
    if (value > montomaximoaval) {
      // print('VALUEEEEEE $value');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
              message:
                  'El monto por Aval no puede ser mayor a $montomaximoaval',
              title: 'Error',
              icon: Icons.error_outline,
              color: Colors.amber);
        },
      );
    }
  }

  Widget card(formattedMonoto) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 74, 74, 75)
                .withOpacity(0.5), // Color del sombreado azul
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SizedBox(
        width: 380,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(15.0), // Radio de borde de la tarjeta
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                ListTile(
                  title: const Text('Nota'),
                  subtitle: Text(
                    'El máximo que se te puede prestar es de $formattedMonoto pesos mexicanos y el monto mínimo que puedes solicitar es de \$5,000.00 pesos mexicanos.',
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget generaAvales(avales, navales, cnatidadfinal) {
    // print('Numero de avales que se genera $navales');
    // print(montoinput);
    // print(montoinput.runtimeType);
    //   String?  x = montoinput ?? '0';
    //   print('VALOR DE X $x');

    //  setState(() {
    //             montoavales.add(200);
    //           });
    // int solicitud = int.parse(x.toString()) ;
    // print(solicitud);

    // montoavales.add(int.parse(montoinput.toString()));
    // print(montoinput);
    // // print(montoinput.runtimeType);
    //     int solicitud = int.parse(montoinput.toString());
    //     // print('NUEVO VALOR $numero');
    final enviarPrestamo = ConfirmarPrestamo();
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
    // bool validateAndHandleDialog(int i, dynamic value, List<Map<String, dynamic>> nuevoaval, Map<int, int> idavales) {
    //   if (value != null && value.toString().isNotEmpty) {
    //     int selectedId = avales
    //         .firstWhere((element) => element['nombre_completo'] == value)['id_empleado'];

    //     if (!idavales.values.contains(selectedId)) {
    //       // Validar que el ID no esté ya seleccionado
    //       idavales[i] = selectedId;
    //       setState(() {
    //         // selectedValue = value.toString();
    //       });
    //       return true; // Validación exitosa
    //     } else {
    //       setState(() {
    //         selectedValue = null;
    //       });

    //       showDialog(
    //         context: context,
    //         builder: (BuildContext context) {
    //           return const CustomAlertDialog(
    //             message: ' Este aval ya ha sido seleccionado. Por favor, elige otro.',
    //             title: 'Atención',
    //             icon: Icons.error_outline,
    //             color: Colors.amber,
    //           );
    //         },
    //       );

    //       idavales.remove(i);
    //       return false; // Validación fallida
    //     }
    //   } else {

    //     print('Selected value is empty or null');
    //     return false; // Validación fallida
    //   }
    // }

    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecciona a tus avales',
              style: TextStyle(fontWeight: FontWeight.w900),
            ),
            for (var i = 0; i < navales; i++)
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
                      // Check if the selected value is not empty or null
                      // ignore: unnecessary_null_comparison
                      if (value != null && value.toString().isNotEmpty) {
                        int selectedId = avales.firstWhere((element) =>
                            element['nombre_completo'] == value)['id_empleado'];

                        if (!idavales.containsValue(selectedId)) {
                          // Validar que el ID no esté ya seleccionado
                          idavales[i] = selectedId;
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
                  // // const SizedBox(height: 8),
                  // //   SearchRequestDropDown(),
                  // // const SizedBox(height: 500),
                  // // const Divider(height: 0),
                  // // const SizedBox(height: 24),
                  // // DropdownButton(
                  // //   value: idavales[i],
                  // //   items: avales.map<DropdownMenuItem<int>>((item) {
                  // //     return DropdownMenuItem<int>(
                  // //       value: item['id_empleado'],
                  // //       child: Text(item['nombre_completo']),
                  // //       onTap: () {
                  // //         // Implementar acciones al seleccionar un ítem si es necesario
                  // //       },
                  // //     );
                  // //   }).toList(),
                  // //   onChanged: (value) {
                  // //     setState(() {
                  // //       idavales[i] = value!;
                  // //     });
                  // //   },
                  // // ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(
                          RegExp(r'[0-9]')), // Permite solo dígitos numéricos
                    ],
                    decoration: InputDecorationBuilder.finalinput(
                        hintText: 'Cantidad', labelText: 'Monto aval'),
                    initialValue: navales == 1 ? montoinput : '',
                    readOnly: navales == 1 ? true : false,
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
            // Text('Total: $totalAmount'),
            // Text(totalAmount == cnatidadfinal ? 'Válido' : 'Total no valido '),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: btnCambiaMonto,
                  child: ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        montosolicitado.clear();
                        plazoseleccionado.clear();
                        someMap.clear();
                      });
                      await SharedPreferencesHelper.remove('Identificación (INE)');
                      await SharedPreferencesHelper.remove('Comprobante (DOMICILIO)');
                      // ignore: use_build_context_synchronously
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const SolicitaPrestamo();
                          },
                        ),
                      );
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          const Color.fromARGB(255, 5, 50, 91)),
                    ),
                    child: const Text('Cambiar monto'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Visibility(
                  visible: btnDocumentos,
                  child: ElevatedButton(
                    onPressed: btnsolicitaPrestamo
                        ? null
                        : () async {
                            final ine = await SharedPreferencesHelper.getdatos(
                                'Identificación (INE)');
                            final comprobante =
                                await SharedPreferencesHelper.getdatos(
                                    'Comprobante (DOMICILIO)');
                            // print('VALOR PARA INE $ine');
                            // print('VALOR PARA COMPROBANTE $comprobante');
                            if (kDebugMode) {
                              // print('ESTE ES EL VALOR $selectedValue');
                            }
                            if (selectedValue == 1 && (selectedValue == 0)) {
                              if (kDebugMode) {
                                print(selectedValue);
                              }
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomAlertDialog(
                                      message:
                                          'Por favor verifica que tus avales seleccionados no sean los mismos ',
                                      title: 'Atención',
                                      icon: Icons.error_outline,
                                      color: Colors.red);
                                },
                              );
                              return;
                            }
                            int monto = int.parse(montoinput.toString());
                            // print('NUMERO DE AVALES GENERADOS $navales');
                            // print('VALOR AVALA $selectedValue');
                            if ((navales == 1
                                    ? monto == cnatidadfinal
                                    : totalAmount == cnatidadfinal) &&
                                idavales.length == navales &&
                                ine != '' &&
                                comprobante != '') {
                              //AQUI VAMOS A RESOLVER ESTE PEDOO
                              // print(montoinput);
                              // print(cnatidadfinal);
                              // print('SE VALIDO TODOCORRECTO');
                              // print(idavales);
                              Map<int, Map<String, int>> avales = {};
                
                              if (navales == 1) {
                                Map<String, int> nuevoAval = {
                                  'idEmpleado': idavales[0]!,
                                  'monto_aval': monto
                                };
                                avales[0] = nuevoAval;
                              } else {
                                idavales.forEach((key, value) {
                                  if (montoavales.length > key) {
                                    avales[key] = {
                                      'idEmpleado': value,
                                      'monto_aval': montoavales[key],
                                    };
                                  }
                                });
                              }
                
                              // final idEmpleado    =  SharedPreferencesHelper.getdatos('empleado');
                              // final ine           =  SharedPreferencesHelper.getdatos('Identificación (INE)');
                              // final comprobante =
                              //     SharedPreferencesHelper.getdatos(
                              //         'Comprobante (DOMICILIO)');
                              final montosolicitado =
                                  ref.watch(montoinputControllerProvider);
                              final plazoseleccionado =
                                  ref.watch(plazosControllerProvider);
                              montoinput = montosolicitado.text;
                              plazos = plazoseleccionado.text;
                              SharedPreferencesHelper.setdatos(
                                  'monto', '$montoinput'); //monto
                              SharedPreferencesHelper.setdatos(
                                  'plazos', '$plazos'); //plazos
                              SharedPreferencesHelper.setdatos(
                                  'monto_pago', '${datos['abono']}'); //monto pago
                              SharedPreferencesHelper.setdatos(
                                  'comision', '$comision'); //comision
                              SharedPreferencesHelper.setdatos(
                                  'avales', '$avales'); //avales
                              setState(() {
                                btnsolicitaPrestamo = true;
                                btnCambiaMonto = false;
                              });
                              final respuesta =
                                  await enviarPrestamo.confirmaprestamo();
                              if (respuesta['estatus'] == 200) {
                                setState(() {
                                  someMap.clear();
                                  montosolicitado.clear();
                                  plazoseleccionado.clear();
                                });
                                await SharedPreferencesHelper.remove('Identificación (INE)');
                                await SharedPreferencesHelper.remove('Comprobante (DOMICILIO)');
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
                
                              const SizedBox(height: 20);
                            } else if ((navales == 1
                                    ? monto == cnatidadfinal
                                    : totalAmount < cnatidadfinal) ||
                                ine == '' ||
                                comprobante == '') {
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return CustomAlertDialog(
                                      message: ine == ''
                                          ? 'El INE no ha sido cargado.'
                                          : (comprobante == ''
                                              ? 'El comprobante no ha sido cargado.'
                                              : 'Por favor Llena todos los campos solicitados'),
                
                                      // message:'La identificacion o el comprobante no han  sido cargado.' ,
                
                                      title: 'Atención',
                                      icon: Icons.error_outline,
                                      color: Colors.amber);
                                },
                              );
                            } else if (selectedValue == 1 ||
                                idavales.length < navales) {
                              // ignore: use_build_context_synchronously
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
                            } else {
                              if (kDebugMode) {
                                print('Error');
                              }
                              // ignore: use_build_context_synchronously
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return const CustomAlertDialog(
                                      message:
                                          'No todos los campos son correctos. Por favor verifica que todos los campos esten llenos ',
                                      title: 'Error',
                                      icon: Icons.error_outline,
                                      color: Colors.red);
                                },
                              );
                            }
                          },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          btnsolicitaPrestamo
                              ? const Color.fromARGB(255, 23, 23, 23)
                              : const Color.fromARGB(
                                  255, 5, 50, 91)), // Color de fondo azul
                      // Color de fondo azul
                    ),
                    child: Text(
                      btnsolicitaPrestamo
                          ? 'Procesando...'
                          : 'Solicitar Prestamo',
                      style: TextStyle(
                          color:
                              btnsolicitaPrestamo ? Colors.white : Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}