import '../libs/lib.dart';

final postMissolicitudesProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');

  final postDatas = {
    // "idEmpleado": empleadoId,
    "token": token,
  };

  final dynamic datasolicitudes = await fetchPostData(
      modo, completeUrldev, baseUrl, misSolicitudes, postDatas);

  //print(datasolicitudes["success"]);

  if (datasolicitudes["success"] == false) {}

  if (datasolicitudes is Map<String, dynamic> &&
      datasolicitudes["success"] != null) {
    if (datasolicitudes["success"]) {
      final notifier = ref.read(tamanolistProvider.notifier);
      notifier.updatetamanolist(5.toString());
    } else {
      final notifier = ref.read(tamanolistProvider.notifier);
      notifier.updatetamanolist(1.toString());
    }
  } else {
    if (kDebugMode) {
      print(
          'Error: datasolicitudes no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que datasolicitudes no es un mapa válido o cuando "success" no está presente.
  }

  return datasolicitudes;
});
