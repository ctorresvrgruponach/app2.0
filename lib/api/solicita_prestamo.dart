import '../libs/lib.dart';


final solicita_prestamo = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {

  final token         = await SharedPreferencesHelper.getdatos('token');
  final idEmpleado    = await SharedPreferencesHelper.getdatos('empleado');
  final idOperacionid = await SharedPreferencesHelper.getdatos('idoperacionid');
  
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  final postDatas = {
    "idEmpleado"  : idEmpleado,
    "token"       : token,
    "idOperacion" : idOperacionid,
    "buildNumber" : packageInfo.buildNumber,
  };

  final dynamic datasolicitaPrestamo = await fetchPostData(
      modo, completeUrldev, baseUrl, solicitaPrestamo, postDatas);

  if (datasolicitaPrestamo is Map<String, dynamic> &&
      datasolicitaPrestamo["success"] != null) {
    if (datasolicitaPrestamo["success"]) {
      print(datasolicitaPrestamo);
      // print('DATOS $datasolicitaPrestamo');
      print('AQUI ESTA LA RESPUESTA MY LOVEEE');
    } else {}
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return datasolicitaPrestamo;
});
