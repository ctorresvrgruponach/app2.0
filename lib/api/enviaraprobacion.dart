import '../libs/lib.dart';

final postEnviaAprobacionProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final comprobante = await SharedPreferencesHelper.getdatos('Comprobante');
  final ine = await SharedPreferencesHelper.getdatos('INE');
  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
    "ine": ine,
    "comprobante": comprobante,
  };

  final dynamic dataEnviaAprobacion = await fetchPostData(
      modo, completeUrldev, baseUrl, enviarAprobacion, postDatas);

  return dataEnviaAprobacion;
});

class EnviaAprobacionClass {
  Future<Map<String, dynamic>> enviaAprobacion(int aprobar ) async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
    final comprobante = await SharedPreferencesHelper.getdatos('Comprobante');
    final ine = await SharedPreferencesHelper.getdatos('INE');
    final idprestamo = await SharedPreferencesHelper.getdatos('id_solicitud_aval');


    final postDatas = {
      "idEmpleado": empleadoId,
      "token": token,
      "idPrestamo": idprestamo,
      "estatus": aprobar,
      "ine": aprobar == 1 ? ine : '',
      "comprobante": aprobar == 1 ? comprobante : '',
    };

    final  dataEnviaAprobacion = await fetchPostData(
        modo, completeUrldev, baseUrl, enviarAprobacion, postDatas);

    return dataEnviaAprobacion;
  }
}
