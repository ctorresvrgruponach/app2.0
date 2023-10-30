import '../libs/lib.dart';

final postPedirAdelantoProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final idoperacionid = await SharedPreferencesHelper.getdatos('idoperacionid');
  final nombres = await SharedPreferencesHelper.getdatos('nombres');
  final apellidoPaterno =
      await SharedPreferencesHelper.getdatos('apellidoPaterno');
  final apellidoMaterno =
      await SharedPreferencesHelper.getdatos('apellidoMaterno');
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
    "idOperacion": idoperacionid,
    "buildNumber": packageInfo.buildNumber,
  };

  final dynamic dataPedirAdelanto = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointDatosEmpleado, postDatas);

  if (dataPedirAdelanto is Map<String, dynamic> &&
      dataPedirAdelanto["success"] != null) {
    if (dataPedirAdelanto["success"]) {
      dataPedirAdelanto['nombres'] = nombres;
      dataPedirAdelanto['apellidoPaterno'] = apellidoPaterno;
      dataPedirAdelanto['apellidoMaterno'] = apellidoMaterno;
    } else {}
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return dataPedirAdelanto;
});
