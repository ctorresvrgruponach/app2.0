import '../libs/lib.dart';

class ConfirmarVacaciones {
  Future<Map<String, dynamic>> confirmanrvacaciones() async {
    //variables que se mandaran

    final token = await SharedPreferencesHelper.getdatos('token');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
    final idOperacionid =
        await SharedPreferencesHelper.getdatos('idoperacionid');

    final idLider = await SharedPreferencesHelper.getdatos('idLider');
    final diasVacaciones =
        await SharedPreferencesHelper.getdatos('diasVacaciones');
    final diasNoLaborados =
        await SharedPreferencesHelper.getdatos('diasNoLaborados');
    final diasSolicitados =
        await SharedPreferencesHelper.getdatos('diasSolicitados');
    final diaPresentarse =
        await SharedPreferencesHelper.getdatos('diaPresentarse');

    final postDatas = {
      "token": token,
      "idEmpleado": empleadoId,
      "idOperacion": idOperacionid,
      "id_lider": idLider,
      "numero_vacaciones": diasVacaciones,
      "dias_tomados": diasNoLaborados,
      "fechas": diasSolicitados,
      "fecha_presenta": diaPresentarse,
    };

    // print(postDatas);
    String jsonRepresentation = jsonEncode(postDatas);

    if (kDebugMode) {
      print(jsonRepresentation);
    }

    final dynamic resvacaciones = await fetchPostData(
        modo, completeUrldev, baseUrl, confirmaVacaciones, postDatas);
    // print(resvacaciones);
    return resvacaciones;
  }
}
