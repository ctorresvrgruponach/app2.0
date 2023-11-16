import '../libs/lib.dart';

String? montoinput;
String? plazos;

class IdOperacionNotifier extends StateNotifier<String> {
  IdOperacionNotifier() : super('');

  void updateIdOperacion(String newValue) {
    state = newValue;
  }
}

final calcularPrestamos =
    StateNotifierProvider<IdOperacionNotifier, String>((ref) {
  return IdOperacionNotifier();
});
final calcularPrestamo =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final idEmpleado = await SharedPreferencesHelper.getdatos('empleado');
  final idOperacionid = await SharedPreferencesHelper.getdatos('idoperacionid');
  final _montoinput = ref.watch(montoinputControllerProvider);
  final _plazos = ref.watch(plazosControllerProvider);

  final postDatas = {
    "idEmpleado": idEmpleado,
    "idOperacion": idOperacionid,
    "monto_solicitado": _montoinput,
    "plazos": _plazos,
    "token": token,
  };
// print(postDatas);
// print('HOLA');
  final dynamic calculo = await fetchPostData(
      modo, completeUrldev, baseUrl, calculaPrestamo, postDatas);
  //  print(calculo);
  print('sdfghjk $calculo');

  // if (calculo is Map<String, dynamic> && calculo["estatus"] == 200 ) {
  //   if (calculo["estatus"] == '') {
  //      print('ENTRA');
  //     print('TU RESPUESTA MY LOVE');
  //   } else {}
  // } else {
  //   if (kDebugMode) {
  //     print(
  //         'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
  //   }
  //   // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  // }
  if (calculo.statusCode == 200) {
    print('ENTRAAA');

    return calculo.body;
  } else {
    throw Exception('Error al cargar los datos');
  }

//   if (calculo is Map<String, dynamic> && calculo.containsKey("estatus")) {
//   if (calculo["estatus"] == 200) {
//     print('ENTRA');
//     // print('TU RESPUESTA MY LOVE');
//   } else {
//     // Manejar otros casos para diferentes valores de "estatus" si es necesario.
//   }
// } else {
//   if (kDebugMode) {
//     print(
//         'Error: "calculo" no es un mapa válido o el campo "estatus" no está presente.');
//   }
//   // Manejar el caso en el que "calculo" no es un mapa válido o cuando el campo "estatus" no está presente.
// }

  // return calculo;
});
final montoinputControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

final plazosControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
