import 'package:com.gruponach.nach_empleado/views/prestamos/solicita_prestamo.dart';

import '../../libs/lib.dart';
class IdOperacionNotifier extends StateNotifier<String> {
  IdOperacionNotifier() : super('');

  void updateIdOperacion(String newValue) {
    state = newValue;
  }
}

final prestamosNomina = StateNotifierProvider<IdOperacionNotifier, String>((ref) {
  return IdOperacionNotifier();
});
final operacionesPrestamo = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {

  final token      = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  // print(empleadoId);
  // print(token);
  final postDatas  = {
    "idEmpleado": empleadoId,
    "token": token,
  };

  final dynamic dataOperaciones = await fetchPostData(
      modo, completeUrldev, baseUrl, prestamo, postDatas);

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

class Prestamo extends ConsumerStatefulWidget {
  const Prestamo({super.key});
  @override
  PrestamoState createState() => PrestamoState();
}
class PrestamoState extends ConsumerState<Prestamo> {
  @override
  Widget build(BuildContext context) {
    // final navegador = NavegadorDeRuta(context);

    //TODOS LOS VALORES CAPTURADOS SE MANDN AL ENDPOIN
     Future<void> somelugar() async {

            Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return SolicitaPrestamo(); // Reemplaza con el widget de tu página de solicitud de préstamo
          },
         ),
       );
      // await navegador.algunlugar('actualizaempleado');

      // Navigator.pushNamedAndRemoveUntil(
      //     context, 'solicita_prestamo', (route) => false);
    }
    return Scaffold(
      appBar: AppBar(
          title: const Text("Prestamo de nómina"),
          centerTitle: true,
          backgroundColor: Colors.black),
          // backgroundColor: const Color.fromARGB(255, 2, 9, 72)),
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
                      future: ref.watch(operacionesPrestamo.future),
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
                                                            const Color.fromARGB(255, 5, 50, 91),
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.circular(displayWidth(context) * 0.02),
                                                        ), // This is what you need!
                                                      ),
                                                      onPressed: () async {
                                                        print('POR AQUI ESTA EL PEDOO..');
                                                        print(']Me tocaste');
                                                        SharedPreferencesHelper.setdatos(
                                                         'idoperacionid',
                                                         snapshot.data!['operaciones'][index]['idOperacion'].toString());
                                                        final notifier = ref.read(prestamosNomina.notifier);
                                                        notifier.updateIdOperacion( snapshot.data![ 'operaciones'][index]['idOperacion'].toString());
                                                         somelugar();
                                                      },
                                                      child: SizedBox(
                                                        width: displayWidth( context) * 0.7,
                                                        child: Center(
                                                          child: Text(operaciones[index]['operaciones'],
                                                            style: TextStyle(
                                                              fontSize:displayWidth(context) * 0.04,
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
                                              'Hubo un error en los datos',
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