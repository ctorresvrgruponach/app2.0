    import '../libs/lib.dart';

    final solicitudesActivas =FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
      final token      = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');


        final postDatas  = {
          "idEmpleado": idEmpleado,
          "token": token,
        };

        

      final dynamic dataSolicitudes = await fetchPostData(
          modo, completeUrldev, baseUrl, solicitudes, postDatas);

      if (dataSolicitudes is Map<String, dynamic> &&
          dataSolicitudes["success"] != null) {
        if (dataSolicitudes["success"]) {
        } else {}
      } else {
        if (kDebugMode) {
          print('Error');
        }
        // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
      }

      return dataSolicitudes;
    });