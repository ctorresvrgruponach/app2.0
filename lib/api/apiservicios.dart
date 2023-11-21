import '../libs/lib.dart';

final postMisserviciosProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
  };

  final dynamic dataservicios = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointMisservicios, postDatas);

  //print(dataservicios["success"]);

  if (dataservicios["success"] == false) {}

  if (dataservicios is Map<String, dynamic> &&
      dataservicios["success"] != null) {
    if (dataservicios["success"]) {
      final notifier = ref.read(tamanolistProvider.notifier);
      notifier.updatetamanolist(5.toString());
    } else {
      final notifier = ref.read(tamanolistProvider.notifier);
      notifier.updatetamanolist(1.toString());
    }
  } else {
    if (kDebugMode) {
      print(
          'Error: dataservicios no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataservicios no es un mapa válido o cuando "success" no está presente.
  }

  return dataservicios;
});
