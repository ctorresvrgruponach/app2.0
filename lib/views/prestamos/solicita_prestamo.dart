// import 'package:com.gruponach.nach_empleado/lib/custom_dropdown.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:com.gruponach.nach_empleado/api/confirmar_prestamo.dart';
import 'package:com.gruponach.nach_empleado/libs/lib.dart';
import 'package:com.gruponach.nach_empleado/ui/botonfiles.dart';
import 'package:com.gruponach.nach_empleado/ui/input.dart';
import 'package:flutter/services.dart';

import '../../api/calcula_prestamo.dart';
import '../../api/solicita_prestamo.dart';

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
  @override
  void _sendData() {
    setState(() {
      _button = true;
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

  TextEditingController _montoinput = TextEditingController();
  TextEditingController _plazos = TextEditingController();
  TextEditingController _comisionapertura = TextEditingController();
  // TextEditingController       _pagoPrestamo     = TextEditingController();
  // late TextEditingController  _pagoprestamo;
  late TextEditingController _tasaconiva;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<TextEditingController> _montoaval = [];
  String? selectedValue; //
  String? idEmpleadoSeleccionado;
  bool _button = false;
  bool _inputs = false;
  bool _ocultabtn = true;
  bool showForm = false;
  double cnatidadfinal = 0;
  int avalesn = 0;
  int comision = 0;
  Map<String, dynamic> DATA = {};
  int x = 0;
  bool btncalculaprestamo = false;
  bool btnsolicitaPrestamo = false;

//PARA LOS AVALES

  final token = SharedPreferencesHelper.getdatos('token');
  final idEmpleado = SharedPreferencesHelper.getdatos('empleado');
  final idOperacionid = SharedPreferencesHelper.getdatos('idoperacionid');

  Map<int, int> idavales = {};
  List<String> filteredValues = [];

  List<int> montoavales = [];
  int get totalAmount => montoavales.fold(0, (prev, amount) => prev + amount);
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
    final _montoinput = ref.read(montoinputControllerProvider);
    final _plazos = ref.read(plazosControllerProvider);

    fetchData() async {
      final token = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
      final idOperacionid =
          await SharedPreferencesHelper.getdatos('idoperacionid');
      final _montoinput = ref.watch(montoinputControllerProvider);
      final _plazos = ref.watch(plazosControllerProvider);
      montoinput = _montoinput.text;
      plazos = _plazos.text;

      final postDatas = {
        "idEmpleado": idEmpleado,
        "idOperacion": idOperacionid,
        "monto_solicitado": montoinput,
        "plazos": plazos,
        "token": token,
      };

      final data = await fetchPostData(
        modo,
        completeUrldev,
        baseUrl,
        calculaPrestamo,
        postDatas,
      );
      final response = await fetchPostData(
          modo, completeUrldev, baseUrl, calculaPrestamo, postDatas);
      if (response['estatus'] == 200) {
        _sendData();
        return response;
      } else {
        throw Exception('Error al cargar los datos');
      }
    }

    final calculoresponse = ref.watch(calcularPrestamos);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text('Solicitar Prestamo'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            FutureBuilder<Map<String, dynamic>>(
              future: ref.watch(solicita_prestamo.future),
              builder: (context, snapshot) {
                // print('object');
                if (snapshot.hasData && snapshot.data!['empleado'] != null) {
                  if (kDebugMode) {
                    //  print(snapshot.data!);
                  }
                  // VALIDACIONES PARA MONTO Y PLAZOS
                  final empleado = snapshot.data!['empleado'];
                  final avales = snapshot.data!['avales'];
                  final monto_maximo = snapshot.data!['monto_maximo'];
                  final monto_x_aval = snapshot.data!['monto_x_aval'];
                  final plazos_restantes = snapshot.data!['plazos_restantes'];
                  final tipo_nomina = snapshot.data!['plazos_restantes'];
                  final idempleado = snapshot.data!['empleado']['id_empleado'];
                  final valor = true;
                  print(avales.runtimeType);
                  print('MONTO MAXIMO POR AVAL  $monto_x_aval');
                  print('MONTO INGRESADO $_montoinput');
                  print('AVALES $avales');
                  final montoingresado = _montoinput.text;

                  void ValidaMontoMaximo() {
                    final String amountText = _montoinput.text;
                    if (amountText.isEmpty) {
                      return;
                    }
                    final double? amount = double.tryParse(amountText);
                    if (amount != null && amount > monto_maximo) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              message:
                                  'Tu Prestamo Debe Ser Menor o Igual a \$$monto_maximo',
                              title: 'Cantidad excedida',
                              icon: Icons.error_outline_outlined,
                              color: Colors.red);
                        },
                      );
                      _montoinput.clear();
                    }
                  }

                  void ValidaPlazos() {
                    final String amountText = _plazos.text;
                    if (amountText.isEmpty) {
                      return;
                    }
                    final double? amount = double.tryParse(amountText);
                    if (amount != null && amount > plazos_restantes) {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomAlertDialog(
                              message:
                                  'Los plazos no pueden ser mayor a $plazos_restantes.',
                              title: 'Error...',
                              icon: Icons.error_outline_outlined,
                              color: Colors.amber);
                        },
                      );
                      _plazos.clear();
                    }
                  }

                  return Column(
                    children: [
                      Form(
                          key: _formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                SizedBox(
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
                                              controller: _montoinput,
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
                                                ValidaMontoMaximo();
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
                                                  return 'Ingresa el monto';
                                                }

                                                var valor = int.tryParse(
                                                    value); // Intenta convertir a entero
                                                if (valor == null ||
                                                    valor < 1000) {
                                                  return 'Monto mínimo \$1000';
                                                }
                                                // Si no hay errores, retorna null
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
                                          controller: _plazos,
                                          decoration:
                                              InputDecorationBuilder.finalinput(
                                                  hintText:
                                                      'Maximo $plazos_restantes plazos',
                                                  labelText: 'Plazos'),
                                          enabled: !_inputs,
                                          validator: (value) {
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Por favor, ingresa el plazo';
                                            }
                                            return null;
                                          },
                                          onChanged: (_) {
                                            ValidaPlazos();
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
                                                  print(
                                                      'AQUI PINTAMOS EVALES Y TODO EL ROLLO');
                                                  final montoingresado =
                                                      _montoinput.text;
                                                  final montofinal =
                                                      double.parse(
                                                          montoingresado);
                                                  final monto_x_aval = snapshot
                                                      .data!['monto_x_aval'];
                                                  double resultadoDivision =
                                                      double.parse(
                                                              montoingresado) /
                                                          monto_x_aval;
                                                  int resultadoRedondeado =
                                                      resultadoDivision.ceil();
                                                  final montoIngresado =
                                                      _montoinput.text;
                                                  final Comision =
                                                      response['resumen']
                                                          ['comision'];
                                                  if (response['estatus'] ==
                                                      200) {
                                                    setState(() {
                                                      showForm = true;
                                                      DATA = response;
                                                      avalesn =
                                                          resultadoRedondeado;
                                                      cnatidadfinal =
                                                          montofinal;
                                                      comision = Comision;
                                                      actualizarNavales();
                                                    });
                                                  }
                                                }).catchError((error) {
                                                  showDialog(
                                                    context: context,
                                                    builder:
                                                        (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Error...'),
                                                        content: Text(
                                                            error.toString()),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            },
                                                            child:
                                                                Text('Cerrar'),
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
                                                ? Color.fromARGB(
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
                                SizedBox(height: 20),
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
                                                    DATA['abono'].toString(),
                                                decoration: InputDecorationBuilder
                                                    .finalinput(
                                                        hintText:
                                                            'Monto a pagar',
                                                        labelText:
                                                            'Pago del prestamo'),
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
                                      SizedBox(height: 20),
                                      // Text('observacion', style: TextStyle(fontSize: 20)),
                                      const Text(
                                        'La identificacion debe ser vigente , el comprobante de domicilio no puede ser mayor a 3 meses de antiguedad.',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 18),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 20),
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
                                        child: Avales(
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
                  return Container(
                      child: Center(
                          child: const Text('Error intentalo mas tarde.')));
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
    int monto_x_aval = 8000;
    if (value > monto_x_aval) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomAlertDialog(
              message: 'El monto por Aval no puede ser mayor a $monto_x_aval',
              title: 'Error',
              icon: Icons.error_outline,
              color: Colors.amber);
        },
      );
    }
  }

  //PETICION PARA GUARDAR LA SOLICITUD DE PRESTAMO
  fetchData() async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
    final idOperacionid =
        await SharedPreferencesHelper.getdatos('idoperacionid');
    final _montoinput = ref.watch(montoinputControllerProvider);
    final _plazos = ref.watch(plazosControllerProvider);
    montoinput = _montoinput.text;
    plazos = _plazos.text;

    final postDatas = {
      'idEmpleado': idEmpleado,
      'idOperacion': idOperacionid,
      'monto': cnatidadfinal,
      'montoPago': DATA['abono'],
      'plazos': _plazos,
      'comision': comision,
      'ine': "",
      'comprobante': ""
    };
    print('LA DATA BB $postDatas');

    // final data = await fetchPostData(
    //   modo,
    //   completeUrldev,
    //   baseUrl,
    //   calculaPrestamo,
    //   postDatas,
    // );
    // final response = await fetchPostData( modo, completeUrldev, baseUrl, calculaPrestamo, postDatas);
    //   if (response['estatus'] == 200) {
    //   _sendData();
    //           return response;
    //   } else {
    //     throw Exception('Error al cargar los datos');
    //   }
  }

  Widget Avales(avales, navales, cnatidadfinal) {
    final EnviarPrestamo = ConfirmarPrestamo();
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
      child: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
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
                      // //   debugPrint('changing value to: $value');
                      // //    idavales[i] = avales
                      // // .firstWhere((element) => element['nombre_completo'] == value)['id_empleado'];
                      //   setState(() {
                      //     selectedValue = value.toString();
                      //     print(selectedValue);
                      //   });
                      // },
                      onChanged: (value) {
                        int selectedId = avales.firstWhere((element) =>
                            element['nombre_completo'] == value)['id_empleado'];
                        if (!idavales.values.contains(selectedId)) {
                          // Validar que el ID no esté ya seleccionado
                          idavales[i] = selectedId;
                          setState(() {
                            selectedValue = value.toString();
                            // print(selectedValue);
                          });
                        } else {
                          setState(() {
                            selectedValue = null;
                            // print(selectedValue);
                          });
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomAlertDialog(
                                  message:
                                      ' Este aval ya a sido seleccionado por favor elige otro',
                                  title: 'Atencion',
                                  icon: Icons.error_outline,
                                  color: Colors.amber);
                            },
                          );
                          idavales.remove(i);
                          print('Elemento eliminado: $selectedId');
                        }
                        // }
                      },
                    ),
                    SizedBox(
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
                      decoration: InputDecorationBuilder.finalinput(
                          hintText: 'Cantidad', labelText: 'Monto aval'),
                      onChanged: (value) {
                        var valor = int.parse(value);
                        validaavales(valor);
                        print('aqui esta el PEDOOO');
                        int enteredValue = value.isEmpty ? 0 : int.parse(value);
                        setState(() {
                          montoavales[i] = enteredValue;
                        });
                      },
                    ),
                  ],
                ),
              Text('Total: $totalAmount'),
              Text(
                  totalAmount == cnatidadfinal ? 'Válido' : 'Total no valido '),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: btnsolicitaPrestamo
                    ? null
                    : () async {
                        if (selectedValue == null) {
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
                          print('ESTAS MAL BROW');
                        } else if (totalAmount == cnatidadfinal) {
                          Map<int, Map<String, int>> avales = {};
                          idavales.forEach((key, value) {
                            if (montoavales.length > key) {
                              avales[key] = {
                                'idEmpleado': value,
                                'monto_aval': montoavales[key],
                              };
                            }
                          });
                          final idEmpleado =
                              SharedPreferencesHelper.getdatos('empleado');
                          final ine = SharedPreferencesHelper.getdatos(
                              'Identificación (INE)');
                          final comprobante = SharedPreferencesHelper.getdatos(
                              'Comprobante (DOMICILIO)');
                          final _montoinput =
                              ref.watch(montoinputControllerProvider);
                          final _plazos = ref.watch(plazosControllerProvider);
                          montoinput = _montoinput.text;
                          plazos = _plazos.text;
                          SharedPreferencesHelper.setdatos(
                              'monto', '$montoinput'); //monto
                          SharedPreferencesHelper.setdatos(
                              'plazos', '$plazos'); //plazos
                          SharedPreferencesHelper.setdatos(
                              'monto_pago', '${DATA['abono']}'); //monto pago
                          SharedPreferencesHelper.setdatos(
                              'comision', '$comision'); //comision
                          SharedPreferencesHelper.setdatos(
                              'avales', '$avales'); //avales
                          setState(() {
                            btnsolicitaPrestamo = true;
                          });
                          final respuesta =
                              await EnviarPrestamo.confirmaprestamo();
                          if (respuesta['estatus'] == 200) {
                            //ignore: use_build_context_synchronously
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return alersuccess(
                                    message: respuesta['mensaje'],
                                    title: 'Exito',
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
                          SizedBox(height: 20);
                        } else {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const CustomAlertDialog(
                                  message:
                                      ' Verifica el monto ingresado por aval',
                                  title: 'Ups...',
                                  icon: Icons.error_outline,
                                  color: Colors.amber);
                            },
                          );
                        }
                      },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                      btnsolicitaPrestamo
                          ? Color.fromARGB(255, 23, 23, 23)
                          : const Color.fromARGB(
                              255, 5, 50, 91)), // Color de fondo azul
                  // Color de fondo azul
                ),
                child: Text(
                  btnsolicitaPrestamo ? 'Procesando...' : 'Solicitar Prestamo',
                  style: TextStyle(
                      color: btnsolicitaPrestamo ? Colors.white : Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
