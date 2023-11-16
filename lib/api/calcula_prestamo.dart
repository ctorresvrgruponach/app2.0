import '../libs/lib.dart';

String? montoinput;
String? plazos;

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
final calcularPrestamo =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
  final idOperacionid = await SharedPreferencesHelper.getdatos('idoperacionid');
  final _montoinput = ref.watch(montoinputControllerProvider);
  final _plazos = ref.watch(plazosControllerProvider);

  final postDatas = {
    "idEmpleado": idEmpleado,
    "idOperacion": idOperacionid,
    "monto_solicitado": _montoinput,
    "plazos": _plazos,
    "token": token,
  };

  final dynamic calculo = await fetchPostData( modo, completeUrldev, baseUrl, calculaPrestamo, postDatas); // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
   if (calculo.statusCode == 200) {

      return calculo.body;
    } else {
      throw Exception('Error al cargar los datos');
    }
});
final montoinputControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

final plazosControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
