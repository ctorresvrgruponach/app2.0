import '../../libs/lib.dart';

class IdOperacionReciboNotifier extends StateNotifier<String> {
  IdOperacionReciboNotifier() : super('');

  void updateIdOperacion(String newValue) {
    state = newValue;
  }
}

final idOperacionReciboProvider =
    StateNotifierProvider<IdOperacionReciboNotifier, String>((ref) {
  return IdOperacionReciboNotifier();
});

final postOperacionesReciboProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
  };

  final dynamic dataOperaciones = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointOperaciones, postDatas);

  if (dataOperaciones is Map<String, dynamic> &&
      dataOperaciones["success"] != null) {
    if (dataOperaciones["success"]) {
    } else {}
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return dataOperaciones;
});

class RecibosScreen extends ConsumerStatefulWidget {
  const RecibosScreen({super.key});
  @override
  RecibosScreenState createState() => RecibosScreenState();
}

class RecibosScreenState extends ConsumerState<RecibosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Adelanto de nómina"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 2, 9, 72),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Column(
                children: [
                  FutureBuilder<Map<String, dynamic>>(
                    future: ref.watch(postOperacionesReciboProviders.future),
                    builder: (context, snapshot) {
                      if (snapshot.hasData &&
                          snapshot.data!['operaciones'] != null) {
                        final operaciones = snapshot.data!['operaciones'];

                        List<String> operacionValues =
                            (operaciones as List).map((item) {
                          return item['operaciones'].toString();
                        }).toList();

                        String? selectedValue;

                        return Column(
                          children: [
                            DropdownButton<String>(
                              value: selectedValue,
                              onChanged: (value) {
                                setState(() {
                                  selectedValue = value;
                                });
                              },
                              items: operacionValues.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                            ),
                          ],
                        );
                      } else if (snapshot.hasError) {
                        return const SizedBox(
                            // Maneja el error aquí
                            );
                      } else if (snapshot.hasData &&
                          snapshot.data!['mensaje'] != null) {
                        return const SizedBox(
                            // Maneja el caso de mensaje aquí
                            );
                      }

                      return const Cargando(); // Spinner de carga predeterminado
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: 1,
      ),
    );
  }
}
