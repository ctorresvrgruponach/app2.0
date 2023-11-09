import '../libs/lib.dart';

final postEnviaAdelantoProviders =
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

  final dynamic dataEnviaAdelanto = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointSOperacion, postDatas);

  return dataEnviaAdelanto;
});

class EnviaAdelantoClass {
  Future<Map<String, dynamic>> enviaadelanto() async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
    final postDatas = {
      "idEmpleado": empleadoId,
      "idOperacion": "103",
      "montoSolicitar": "3367.23",
      "totalDescontar": "3875.01",
      "comision": "437.74",
      "correo": "MAURICIO_SANABRIAC@HOTMAIL.COM",
      "montoperfil": "21055.4",
      "perfil": "4",
      "folioConsulta": "19698610",
      "nombre_contrato": "",
      "nombre_consulta_buro": "",
      "nombre_perfil_transaccional": "",
      "nombre_INE": "",
      "nombre_CURP": "",
      "archivo1_nom": "INE",
      "archivo2_nom": "CURP",
      "archivo3_nom": "COMPROBANTE DOMICILIO",
      "archivo4_nom": "documento de identidad",
      "firma": "",
      "archivo1_64": "",
      "archivo2_64": "",
      "archivo3_64": "",
      "archivo4_64": "",
      "token": token,
    };

    final dynamic dataEnviaAdelanto = await fetchPostData(
        modo, completeUrldev, baseUrl, endpointSOperacion, postDatas);

    return dataEnviaAdelanto;
  }
}
