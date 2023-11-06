import '../libs/lib.dart';

final postEnviaFirmaProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final imagenEmplaedo =
      await SharedPreferencesHelper.getdatos('imagen_emplaedo');
  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
    "imagen": imagenEmplaedo,
  };

  final dynamic dataEnviaFirma = await fetchPostData(
      modo, completeUrldev, baseUrl, enviarfirma, postDatas);

  return dataEnviaFirma;
});

class EnviaFirmaClass {
  Future<Map<String, dynamic>> enviaFirma(dynamic imagenEmplaedo) async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
    final postDatas = {
      "idEmpleado": empleadoId,
      "token": token,
      "imagen": imagenEmplaedo,
    };

    final dynamic dataEnviaFirma = await fetchPostData(
        modo, completeUrldev, baseUrl, enviarfirma, postDatas);

    return dataEnviaFirma;
  }
}
