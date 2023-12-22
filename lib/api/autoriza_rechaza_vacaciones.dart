// import '../libs/lib.dart';

// final rechazaConfirmaVacaciones =FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
//   final token = await SharedPreferencesHelper.getdatos('token');
//   final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
//   // final idOperacionid =await SharedPreferencesHelper.getdatos('idoperacionid');
//   // print(idOperacionid);
//   // final postDatas = {
//   //   "idEmpleado": idEmpleado,
//   //   "token": token,
//   //   "idOperacion": 2,
//   //   "idPrestamo": 2,
//   // };
//     final postDatas  = {
//       "idEmpleado": idEmpleado,
//       "token": token,
//       "id_solicitud": 'nvacaciones',
//       "estatus": '1 o 2'
//     };

//   final dynamic dataEditaPrestamo = await fetchPostData(
//       modo, completeUrldev, baseUrl, confirmaRechazaVacaciones, postDatas);

//   if (dataEditaPrestamo is Map<String, dynamic> &&
//       dataEditaPrestamo["success"] != null) {
//     if (dataEditaPrestamo["success"]) {
//     } else {}
//   } else {
//     if (kDebugMode) {
//       print('Error');
//     }
//     // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
//   }

//   return dataEditaPrestamo;
// });

import '../libs/lib.dart';

class ConfirmarRechazarVacaciones {
  Future<Map<String, dynamic>> rechazarconfirmardiasVacaciones() async {
    //variables que se mandaran

    final token = await SharedPreferencesHelper.getdatos('token');
    final idSolicitud = await SharedPreferencesHelper.getdatos('id_solicitud');
    final estatus = await SharedPreferencesHelper.getdatos('estatus');

    // final comprobante   = await SharedPreferencesHelper.getdatos('Comprobante (DOMICILIO)');

    final postDatas = {
      "token": token,
      "id_solicitud": idSolicitud,
      "estatus": estatus,
    };

    // print(postDatas);
    String jsonRepresentation = jsonEncode(postDatas);

    if (kDebugMode) {
      print(jsonRepresentation);
    }

    final dynamic resvacaciones = await fetchPostData(
        modo, completeUrldev, baseUrl, confirmaRechazaVacaciones, postDatas);
    // print(resvacaciones);
    return resvacaciones;
  }
}
