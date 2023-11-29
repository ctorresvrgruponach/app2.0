import '../../libs/lib.dart';

bool colorenv = false;

class IdOperacionNotifiercaja extends StateNotifier<String> {
  IdOperacionNotifiercaja() : super('');

  void updateIdOperacion(String newValue) {
    state = newValue;
  }
}

final idOperacionProvider =
    StateNotifierProvider<IdOperacionNotifiercaja, String>((ref) {
  return IdOperacionNotifiercaja();
});

final postOperacionesProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
  };

  final dynamic dataOperaciones = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointcajaahorro, postDatas);

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

class CajaDeAhorroScreen extends ConsumerStatefulWidget {
  const CajaDeAhorroScreen({super.key});
  @override
  CajaDeAhorroScreenState createState() => CajaDeAhorroScreenState();
}

class CajaDeAhorroScreenState extends ConsumerState<CajaDeAhorroScreen> {
  @override
  Widget build(BuildContext context) {
    List<dynamic> argumentos = [''];
    final navegador = NavegadorDeRuta(context, argumentos);

    Future<void> somelugar() async {
      await navegador.algunlugar('cajavalores');
    }

    return Scaffold(
      appBar: AppBar(
          title: const Text("Caja de Ahorro"),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 2, 9, 72)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            SizedBox(
              child: Column(
                children: [
                  SizedBox(
                    //color: Color.fromARGB(255, 5, 50, 91),
                    width: displayWidth(context) * 1,

                    child: FutureBuilder<Map<String, dynamic>>(
                      future: ref.watch(postOperacionesProviders.future),
                      builder: (context, snapshot) {
                        if (snapshot.hasData &&
                            snapshot.data!['operaciones'] != null) {
                          //  print(snapshot.data!);

                          final operaciones = snapshot.data!['operaciones'];
                          return Padding(
                            padding: EdgeInsets.only(
                                top: displayHeight(context) * 0.02,
                                left: displayHeight(context) * 0.04,
                                right: displayHeight(context) * 0.04),
                            child: Column(
                              children: [
                                HtmlWidget(snapshot.data!['polititcas']),
                                Padding(
                                  padding: EdgeInsets.all(
                                      displayHeight(context) * 0.05),
                                  child: SizedBox(
                                    width: displayWidth(context) * 1,
                                    height: displayHeight(context) *
                                        0.1 *
                                        operaciones.length,
                                    child: Column(
                                      children: [
                                        Expanded(
                                          child: ListView.builder(
                                              itemCount: operaciones.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: SizedBox(
                                                    child: ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Color.fromARGB(
                                                                colorenv
                                                                    ? 50
                                                                    : 255,
                                                                5,
                                                                50,
                                                                91),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(
                                                                  displayWidth(
                                                                          context) *
                                                                      0.02),
                                                        ), // This is what you need!
                                                      ),
                                                      onPressed: () async {
                                                        if (kDebugMode) {
                                                          print(
                                                              'MANDA NUEVA VISTA');
                                                        }
                                                        setState(() {
                                                          colorenv = true;
                                                        });
                                                        SharedPreferencesHelper.setdatos(
                                                            'idoperacionid',
                                                            snapshot.data![
                                                                    'operaciones']
                                                                    [index][
                                                                    'idOperacion']
                                                                .toString());
                                                        final notifier = ref.read(
                                                            idOperacionProvider
                                                                .notifier);
                                                        notifier.updateIdOperacion(
                                                            snapshot.data![
                                                                    'operaciones']
                                                                    [index][
                                                                    'idOperacion']
                                                                .toString());
                                                        somelugar();
                                                        setState(() {
                                                          colorenv = false;
                                                        });
                                                      },
                                                      child: SizedBox(
                                                        width: displayWidth(
                                                                context) *
                                                            0.7,
                                                        child: Center(
                                                          child: Text(
                                                            operaciones[index]
                                                                ['operaciones'],
                                                            style: TextStyle(
                                                              fontSize:
                                                                  displayWidth(
                                                                          context) *
                                                                      0.04,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return SizedBox(
                            child: Padding(
                              padding: EdgeInsets.all(
                                displayWidth(context) * 0.1,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Column(
                                  children: [
                                    const Spacer(),
                                    Expanded(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        shadowColor:
                                            const Color.fromARGB(246, 0, 0, 0),
                                        elevation: 20,
                                        child: SizedBox(
                                          width: 300,
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              'Hubo un error en la carga de datos',
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.05),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          );
                          // return Text(snapshot.error.toString());
                        } else if (snapshot.hasData &&
                            snapshot.data!['mensaje'] != null) {
                          return SizedBox(
                            child: Padding(
                              padding: EdgeInsets.all(
                                displayWidth(context) * 0.1,
                              ),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40.0),
                                ),
                                child: Column(
                                  children: [
                                    const Spacer(),
                                    Expanded(
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            color: Theme.of(context)
                                                .colorScheme
                                                .outline,
                                          ),
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(12)),
                                        ),
                                        shadowColor:
                                            const Color.fromARGB(246, 0, 0, 0),
                                        elevation: 20,
                                        child: SizedBox(
                                          width: 300,
                                          height: 100,
                                          child: Center(
                                            child: Text(
                                              snapshot.data!['mensaje'],
                                              textAlign: TextAlign.justify,
                                              style: TextStyle(
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0),
                                                  fontSize:
                                                      displayWidth(context) *
                                                          0.05),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ),
                          );
                          // return Text(snapshot.error.toString());
                        }
                        // By default show a loading spinner.
                        return const Cargando();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
