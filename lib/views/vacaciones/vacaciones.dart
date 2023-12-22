import 'package:com.gruponach.nach_empleado/api/vacaciones.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../api/solicitar_vacaciones.dart';
import '../../libs/lib.dart';

class IdOperacionNotifier extends StateNotifier<String> {
  IdOperacionNotifier() : super('');

  void updateIdOperacion(String newValue) {
    state = newValue;
  }
}

final operacionesid = StateNotifierProvider<IdOperacionNotifier, String>((ref) {
  return IdOperacionNotifier();
});

class Vacaciones extends ConsumerStatefulWidget {
  const Vacaciones({super.key});

  @override
  VacacionesState createState() => VacacionesState();
}

class VacacionesState extends ConsumerState<Vacaciones> {
  Map<String, dynamic> datos = {};
  int diasVacaciones = 0;
  List<dynamic> lideres = [];
  List<dynamic> fechas = [];
  List<String> filteredValues = [];
  int idLider = 0;
  DateTime fechaactual = DateTime.now();
  DateTime? dia;
  Object? diasnolavorados;
  // DateTime? _date;
  int x = 1;
  bool ocultabtn = true;
  bool muestrabtn = false;
  int diasTomados = 0;
  // var _date;
  String fecharegreso = '';
  bool ocultabtnoperacion = true;
  TextEditingController dateinput = TextEditingController();
  bool solicita = false;

  @override
  Widget build(BuildContext context) {
    final enviaSolicitudVacaciones = ConfirmarVacaciones();
    //todo inicia aqui

    fetchData() async {
      final token = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
      final idOperacionid =
          await SharedPreferencesHelper.getdatos('idoperacionid');

      final postDatas = {
        "token": token,
        "idEmpleado": idEmpleado,
        "idOperacion": idOperacionid
      };

      final response = await fetchPostData(
          modo, completeUrldev, baseUrl, solicitaVacaciones, postDatas);
      if (response['success'] == true) {
        // print(response);
        return response;
      } else {
        throw Exception(response['mensaje']);
      }
    }

    @override
    void initState() {
      dateinput.text = "";
      super.initState();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 5, 50, 91),
        title: const Text('Vacaciones'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            const SizedBox(
              width: 600,
              height: 20,
            ),
            SizedBox(
              width: displayWidth(context) * 0.9,
              // height: displayWidth( context) * 0.,
              child: FutureBuilder<Map<String, dynamic>>(
                future: ref.watch(operacionEmpleado.future),
                builder: (context, snapshot) {
                  if (snapshot.hasData &&
                      snapshot.data!['operaciones'] != null) {
                    final operaciones = snapshot.data!['operaciones'];
                    return Column(
                      children: <Widget>[
                        ocultabtn
                            ? const Text(
                                'A continuación selecciona la operación',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              )
                            : const Text(''),
                        const SizedBox(
                          height: 20,
                        ),
                        Visibility(
                          visible: ocultabtn,
                          child: SizedBox(
                            width: displayWidth(context) * 0.9,
                            height: displayWidth(context) * 0.2,
                            child: ListView.builder(
                              itemCount: operaciones.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        ocultabtnoperacion = false;
                                      });
                                      SharedPreferencesHelper.setdatos(
                                          'idoperacionid',
                                          snapshot.data!['operaciones'][index]
                                                  ['idOperacion']
                                              .toString());
                                      final notifier =
                                          ref.read(operacionesid.notifier);
                                      notifier.updateIdOperacion(snapshot
                                          .data!['operaciones'][index]
                                              ['idOperacion']
                                          .toString());
                                      fetchData().then((response) {
                                        final dias =
                                            response['dias_disponibles'];
                                        final lider = response['lideres'];
                                        // print(lideres.runtimeType);
                                        // print(dias);
                                        if (response['success'] == true) {
                                          // print('LA DATA ESTA AQUI ');
                                          setState(() {
                                            datos = response;
                                            lideres = lider;
                                            diasVacaciones = dias;
                                            ocultabtn = false;
                                            muestrabtn = true;
                                          });
                                        }
                                      }).catchError((error) {
                                        // print(error);
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,
                                          builder: (BuildContext context) {
                                            return AlertDialog(
                                              title:
                                                  const Text('Lo sentimos :('),
                                              content: Text(error.toString()),
                                              actions: <Widget>[
                                                TextButton(
                                                  onPressed: () {
                                                    Navigator.pushNamed(
                                                        context, 'home');
                                                  },
                                                  child: const Text('Aceptar'),
                                                ),
                                              ],
                                            );
                                          },
                                        );

                                        // ignore: invalid_return_type_for_catch_error
                                        //   return alerterror(
                                        // message: error.toString(),
                                        // title: 'Notificación',
                                        // icon: Icons.notification_add,
                                        // color: Colors.white);
                                      });
                                    },
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              const Color.fromARGB(
                                                  255, 5, 50, 91)),
                                    ),
                                    child: Text(ocultabtnoperacion
                                        ? operaciones[index]['operaciones']
                                        : 'Cargando...'), // Assuming operaciones is a list of strings
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        muestrabtn
                            ? Text('Días disponibles $diasVacaciones',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  // fontWeight: FontWeight.bold
                                ),
                                textAlign: TextAlign.justify)
                            : const Text(''),
                        // const SizedBox(height: 20),
                        Visibility(
                          visible: muestrabtn,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buscaLideres(lideres, diasVacaciones),
                          ),
                        ),
                        muestrabtn
                            ? const Text(
                                'Seleccionar los días a disfrutar',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              )
                            : const Text(''),
                        const SizedBox(height: 20),
                        Center(
                          child: Visibility(
                            visible: muestrabtn,
                            child: SfDateRangePicker(
                              headerHeight: 20,
                              //  showActionButtons: true,
                              selectionColor:
                                  const Color.fromARGB(255, 255, 64, 64),
                              startRangeSelectionColor:
                                  const Color.fromARGB(255, 67, 159, 234),
                              endRangeSelectionColor: Colors.blue,
                              rangeSelectionColor:
                                  const Color.fromARGB(255, 168, 206, 236),
                              selectionMode:
                                  DateRangePickerSelectionMode.multiple,
                              view: DateRangePickerView.month,

                              // onSubmit: (dateRange){
                              //   setState(() {
                              //     diasnolavorados = dateRange;
                              //   });
                              //   print(dateRange);

                              // },
                              // ignore: non_constant_identifier_names
                              onSelectionChanged:
                                  (DateRangePickerSelectionMode) {
                                // print(DateRangePickerSelectionMode.value);
                                // print(DateRangePickerSelectionMode.runtimeType);
                                setState(() {
                                  diasnolavorados =
                                      DateRangePickerSelectionMode.value;
                                  // print('los dias $diasnolavorados');
                                });
                                if (diasnolavorados is List) {
                                  int cantidadElementos =
                                      (diasnolavorados as List).length;
                                  if (cantidadElementos > diasVacaciones) {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                            message:
                                                'El maximo de dias son  $diasVacaciones.',
                                            title: 'Alerta',
                                            icon: Icons.error_outline_outlined,
                                            color: Colors.amber);
                                      },
                                    );
                                  }
                                  setState(() {
                                    diasTomados = cantidadElementos;
                                  });
                                  // print('Cantidad de elementos en diasnolaborados: $cantidadElementos');
                                } else {
                                  // print('diasnolaborados no es una lista');
                                }
                              },
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        // Text('dias seleccionados $diasTomados'),
                        Visibility(
                          visible: muestrabtn,
                          child: Column(
                            children: [
                              TextField(
                                controller:
                                    dateinput, //editing controller of this TextField
                                // decoration: InputDecorationBuilder.finalinput(hintText: 'aaaa/mm/dd', labelText: 'Dia que se presenta a laborar'),
                                decoration: InputDecoration(
                                  icon: const Icon(Icons
                                      .calendar_today), //icon of text field
                                  labelText: 'Dia que se presenta a laborar',
                                  hintText: 'aaaa/mm/dd',
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                      color: Colors.blue,
                                      width: 2.0,
                                    ),
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  border: const OutlineInputBorder(
                                      borderSide: BorderSide(
                                    color: Colors.red,
                                  )),
                                  //label text of field
                                ),
                                readOnly:
                                    true, //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(
                                          2000), //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2101));

                                  if (pickedDate != null) {
                                    // print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
                                    var formattedDate = DateFormat('yyyy-MM-dd')
                                        .format(pickedDate);
                                    // print(formattedDate); //formatted date output using intl package =>  2021-03-16
                                    //you can implement different kind of Date Format here according to your requirement

                                    setState(() {
                                      dateinput.text = formattedDate;
                                      // print( dateinput.text);
                                      fecharegreso = dateinput
                                          .text; //set output date to TextField value.
                                    });
                                  } else {
                                    // print("Date is not selected");
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                        //id 840
                        const SizedBox(height: 20),
                        muestrabtn
                            ? const Text(
                                'NOTA: Al realizar esta solicitud no da por hecho que estén las vacaciones autorizadas.',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 14),
                                textAlign: TextAlign.center)
                            : const Text(''),
                        Visibility(
                          visible: muestrabtn,
                          child: ElevatedButton(
                              onPressed: () async {
                                //   print('ID DEL LIDER $idLider');
                                // print('DIAS VACACIONES  $diasVacaciones');
                                // print('dias solicitados $diasnolavorados');
                                // print('dias de regreso a laborar $_date');
                                // print('dias de retorno $fechaactual');
                                // print('DIAS TOMADOS $diasTomados');
                                // print('VALOR DE X  $x');
                                if (idLider > 0 &&
                                    diasTomados <= diasVacaciones &&
                                    fecharegreso != '') {
                                  setState(() {
                                    solicita = true;
                                  });
                                  SharedPreferencesHelper.setdatos(
                                      'idLider', '$idLider');
                                  SharedPreferencesHelper.setdatos(
                                      'diasVacaciones', '$diasVacaciones');
                                  SharedPreferencesHelper.setdatos(
                                      'diasNoLaborados', '$diasTomados');
                                  SharedPreferencesHelper.setdatos(
                                      'diasSolicitados', '$diasnolavorados');
                                  SharedPreferencesHelper.setdatos('diaPresentarse',  '$fecharegreso');
                                  final respuesta =
                                      await enviaSolicitudVacaciones
                                          .confirmanrvacaciones();
                                  // print(respuesta);
                                  if (respuesta['estatus'] == 200) {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) {
                                        return alersuccess(
                                            message: respuesta['mensaje'],
                                            title: 'Éxito',
                                            icon: Icons.check,
                                            color: Colors.green);
                                      },
                                    );
                                  } else {
                                    // ignore: use_build_context_synchronously
                                    // showDialog(
                                    //     context: context,
                                    //     // barrierDismissible: false,
                                    //     builder: (BuildContext context) {
                                    //       return alerterror(
                                    //           message: respuesta['mensaje'],
                                    //           title: 'Error.',
                                    //           icon: Icons.error_sharp,
                                    //           color: Colors.red);
                                    //     },
                                    //   );
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (context) {
                                        return CustomAlertDialog(
                                            message: respuesta['mensaje'],
                                            title: 'Error...!',
                                            icon: Icons.error_sharp,
                                            color: Colors.red);
                                      },
                                    );
                                    setState(() {
                                    solicita = false;
                                  });
                                  }
                                } else if (idLider == 0) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return const CustomAlertDialog(
                                          message:
                                              'Por favor selecciona a tu lider.',
                                          title: 'Atencion!',
                                          icon: Icons.error_outline_outlined,
                                          color: Colors.amber);
                                    },
                                  );
                                } else if (diasTomados == 0) {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return const CustomAlertDialog(
                                          message:
                                              'Selecciona los dias que tomaras de vacaciones',
                                          title: 'Atencion!',
                                          icon: Icons.error_outline_outlined,
                                          color: Colors.amber);
                                    },
                                  );
                                } else if (fecharegreso == '') {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: false,
                                    builder: (context) {
                                      return const CustomAlertDialog(
                                          message:
                                              'Selecciona la fecha en la que te presentaras',
                                          title: 'Atencion!',
                                          icon: Icons.error_outline_outlined,
                                          color: Colors.amber);
                                    },
                                  );
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        const Color.fromARGB(255, 5, 50, 91)),
                              ),
                              child: Text(solicita
                                  ? 'Validando'
                                  : 'Solicitar vacaciones')),
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
            ),
          ],
        ),
      ),
    );
  }

  List<DateTime> getDisabledDates() {
    List<DateTime> disabledDates = [];

    // Obtén las fechas deshabilitadas, por ejemplo, los sábados y domingos
    for (int i = 0; i < 365; i++) {
      DateTime currentDate = DateTime.now().add(Duration(days: i));
      if (currentDate.weekday == DateTime.saturday ||
          currentDate.weekday == DateTime.sunday) {
        disabledDates.add(currentDate);
      }
    }

    return disabledDates;
  }

  Widget buscaLideres(lider, dias) {
    Future<List<Object>> getFakeRequestData(String query) async {
      await Future.delayed(const Duration(seconds: 1));
      final busqueda = query.toLowerCase();

      final matchingOptions = lider
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
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Selecciona a tu lider',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              children: [
                CustomDropdown.searchRequest(
                  futureRequest: getFakeRequestData,
                  hintText: 'Numero de empleado',
                  searchHintText: 'Número de empleado',
                  excludeSelected: false,
                  onChanged: (value) {
                    // Check if the selected value is not empty or null
                    // ignore: unnecessary_null_comparison
                    if (value != null && value.toString().isNotEmpty) {
                      int selectedId = lider.firstWhere((element) =>
                          element['nombre_completo'] == value)['id_empleado'];
                      setState(() {
                        idLider = selectedId;
                      });
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
