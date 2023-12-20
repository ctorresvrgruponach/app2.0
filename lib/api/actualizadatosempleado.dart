import '../libs/lib.dart';

class EnviaDatosEmpleadoClass {
  Future<Map<String, dynamic>> enviaDatos() async {
    final token = await SharedPreferencesHelper.getdatos('token');
    final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
    final nombrese = await SharedPreferencesHelper.getdatos('nombrese');
    final apellidoPaternoe =
        await SharedPreferencesHelper.getdatos('apellidoPaternoe');
    final apellidoMaternoe =
        await SharedPreferencesHelper.getdatos('apellidoMaternoe');
    final curpe = await SharedPreferencesHelper.getdatos('curpe');
    final direccionCp = await SharedPreferencesHelper.getdatos('direccionCp');
    final direccionCalle =
        await SharedPreferencesHelper.getdatos('direccionCalle');
    final direccionInt = await SharedPreferencesHelper.getdatos('direccionInt');
    final direccionExt = await SharedPreferencesHelper.getdatos('direccionExt');
    final direccionMunicipio =
        await SharedPreferencesHelper.getdatos('direccionMunicipio');
    final direccionColonia =
        await SharedPreferencesHelper.getdatos('direccionColonia');
    final claveEstado = await SharedPreferencesHelper.getdatos('claveEstado');
    final direccionEstado =
        await SharedPreferencesHelper.getdatos('direccionEstado');
    final telefono = await SharedPreferencesHelper.getdatos('telefono');
    final email = await SharedPreferencesHelper.getdatos('email');

    //print(telefono);
    final postDatas = {
      "idEmpleado": empleadoId,
      "token": token,
      "id": null,
    };

    if (nombrese.isNotEmpty) {
      postDatas["nombres"] = nombrese;
    } else {
      postDatas["nombres"] = null;
    }

    if (apellidoPaternoe.isNotEmpty) {
      postDatas["appellidoPaterno"] = apellidoPaternoe;
    } else {
      postDatas["appellidoPaterno"] = null;
    }

    if (apellidoMaternoe.isNotEmpty) {
      postDatas["appellidoMaterno"] = apellidoMaternoe;
    } else {
      postDatas["appellidoMaterno"] = null;
    }

    if (direccionCp.isNotEmpty) {
      postDatas["direccionCp"] = direccionCp;
    } else {
      postDatas["direccionCp"] = null;
    }

    if (direccionCalle.isNotEmpty) {
      postDatas["direccionCalle"] = direccionCalle;
    } else {
      postDatas["direccionCalle"] = null;
    }

    if (direccionInt.isNotEmpty) {
      postDatas["direccionInt"] = direccionInt;
    } else {
      postDatas["direccionInt"] = null;
    }

    if (direccionExt.isNotEmpty) {
      postDatas["direccionExt"] = direccionExt;
    } else {
      postDatas["direccionExt"] = null;
    }

    if (claveEstado.isNotEmpty) {
      postDatas["clave_estado"] = claveEstado;
    } else {
      postDatas["clave_estado"] = null;
    }

    if (direccionEstado.isNotEmpty) {
      postDatas["direccionEstado"] = direccionEstado;
    } else {
      postDatas["direccionEstado"] = null;
    }

    if (curpe.isNotEmpty) {
      postDatas["curp"] = curpe;
    } else {
      postDatas["curp"] = null;
    }

    if (telefono.isNotEmpty) {
      postDatas["telefono"] = telefono;
    } else {
      postDatas["telefono"] = null;
    }
    if (direccionMunicipio.isNotEmpty) {
      postDatas["direccionMunicipio"] = direccionMunicipio;
    } else {
      postDatas["direccionMunicipio"] = null;
    }
    if (direccionColonia.isNotEmpty) {
      postDatas["direccionColonia"] = direccionColonia;
    } else {
      postDatas["direccionColonia"] = null;
    }
    if (email.isNotEmpty) {
      postDatas["email"] = email;
    } else {
      postDatas["email"] = null;
    }
    if (email.isNotEmpty && telefono.isNotEmpty) {
      String jsonRepresentation = jsonEncode(postDatas);

      if (kDebugMode) {
        print(jsonRepresentation);
      }

      final dynamic dataEnviaFirma = await fetchPostData(
          modo, completeUrldev, baseUrl, endpointactualiza, postDatas);
      return dataEnviaFirma;
    } else if (email.isNotEmpty) {
      return {"success": false, "mensaje": 'Falta llenar email'};
    } else if (telefono.isNotEmpty) {
      return {"success": false, "mensaje": 'Falta llenar telefono'};
    } else {
      return {"success": false, "mensaje": 'Datos no actualizados'};
    }
  }
}
