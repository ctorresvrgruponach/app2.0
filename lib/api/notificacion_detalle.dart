    import '../libs/lib.dart';

    final notificacionDetalles = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
      final token        = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado   = await SharedPreferencesHelper.getdatos('empleado');
      final idSolucitud  = await SharedPreferencesHelper.getdatos('idSolucitud');
      // final idOperacionid =await SharedPreferencesHelper.getdatos('idoperacionid');
      // print(idOperacionid);
      // final postDatas = {
      //   "idEmpleado": idEmpleado,
      //   "token": token,
      //   "idOperacion": 2,
      //   "idPrestamo": 2,
      // };
        final postDatas  = {
          "idEmpleado": idEmpleado,
          "token": token,
          "id_solicitud": idSolucitud
        };

        

      final dynamic dataEditaPrestamo = await fetchPostData(
          modo, completeUrldev, baseUrl, detallsNotificacion, postDatas);

      if (dataEditaPrestamo is Map<String, dynamic> &&
          dataEditaPrestamo["success"] != null) {
        if (dataEditaPrestamo["success"]) {
        } else {}
      } else {
        if (kDebugMode) {
          print('Error');
        }
        // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
      }

      return dataEditaPrestamo;
    });