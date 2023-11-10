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
    final email = await SharedPreferencesHelper.getdatos('email');
    final idoperacionid =
        await SharedPreferencesHelper.getdatos('idoperacionid');
    final comision = await SharedPreferencesHelper.getdatos('comision');
    final montoapedir = await SharedPreferencesHelper.getdatos('montoapedir');
    final totaldescontar =
        await SharedPreferencesHelper.getdatos('totaldescontar');
    final ine = await SharedPreferencesHelper.getdatos('INE');
    final comprobante = await SharedPreferencesHelper.getdatos('Comprobante');
    final curp = await SharedPreferencesHelper.getdatos('CURP');
    final firma = await SharedPreferencesHelper.getdatos('imagen_emplaedo');
    final documentoi =
        await SharedPreferencesHelper.getdatos('documento de identidad');
    final postDatas = {
      "idEmpleado": empleadoId,
      "idOperacion": idoperacionid,
      "montoSolicitar": montoapedir,
      "totalDescontar": totaldescontar,
      "comision": comision,
      "correo": email,
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
      "firma": firma,
      "archivo1_64": ine,
      "archivo2_64": curp,
      "archivo3_64": comprobante,
      "archivo4_64": documentoi,
      "token": token,
    };

    final dynamic dataEnviaAdelanto = await fetchPostData(
        modo, completeUrldev, baseUrl, endpointSOperacion, postDatas);

    return dataEnviaAdelanto;
  }
}
