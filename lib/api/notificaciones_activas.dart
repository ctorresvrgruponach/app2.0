import '../libs/lib.dart';
  final notificacionesEmpleado =FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
    final token        = await SharedPreferencesHelper.getdatos('token');
      final idEmpleado   = await SharedPreferencesHelper.getdatos('empleado');
      // final idSolucitud  = await SharedPreferencesHelper.getdatos('idSolucitud');

        final postDatas  = {
          "token":token,
          "idEmpleado":idEmpleado
        };
      final dynamic notificaciones = await fetchPostData(modo, completeUrldev, baseUrl, notificacionesActivas, postDatas);
  
      if (notificaciones is Map<String, dynamic> &&
          notificaciones["success"] != null) {
        if (notificaciones["success"]) {
        } else {}
      } else {
        if (kDebugMode) {
          print('Error');
        }
      }
      return notificaciones;
    });

