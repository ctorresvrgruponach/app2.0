import '../libs/lib.dart';

final postPedirCajaProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final idoperacionid = await SharedPreferencesHelper.getdatos('idoperacionid');

  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
    "idOperacion": idoperacionid,
  };

  final dynamic dataPedirCaja = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointDatosCaja, postDatas);

  if (dataPedirCaja is Map<String, dynamic> &&
      dataPedirCaja["success"] != null) {
    if (dataPedirCaja["success"]) {
    } else {}
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return dataPedirCaja;
});
