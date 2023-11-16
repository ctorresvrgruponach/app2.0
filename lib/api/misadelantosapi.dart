import '../libs/lib.dart';

class IdAdelantoNotifier extends StateNotifier<String> {
  IdAdelantoNotifier() : super('');

  void updateIdAdelanto(String newValue) {
    state = newValue;
  }
}

class Tamanolist extends StateNotifier<String> {
  Tamanolist() : super('1');

  void updatetamanolist(String newValue) {
    state = newValue;
  }
}

final idAdelantoProvider =
    StateNotifierProvider<IdAdelantoNotifier, String>((ref) {
  return IdAdelantoNotifier();
});

final tamanolistProvider = StateNotifierProvider<Tamanolist, String>((ref) {
  return Tamanolist();
});
final postMisAdelantosProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');
  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
  };

  final dynamic dataAdelantos = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointMisAadelantos, postDatas);

  //print(dataAdelantos["success"]);

  if (dataAdelantos["success"] == false) {}

  if (dataAdelantos is Map<String, dynamic> &&
      dataAdelantos["success"] != null) {
    if (dataAdelantos["success"]) {
      final notifier = ref.read(tamanolistProvider.notifier);
      notifier.updatetamanolist(5.toString());
    } else {
      final notifier = ref.read(tamanolistProvider.notifier);
      notifier.updatetamanolist(1.toString());
    }
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return dataAdelantos;
});

final postMisAdelantosdetalleProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');

  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
    "idAdelanto": ref.watch(idAdelantoProvider),
  };

  final dynamic dataAdelantosdetalle = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointMisAadelantosFiles, postDatas);

  if (dataAdelantosdetalle is Map<String, dynamic> &&
      dataAdelantosdetalle["success"] != null) {
    if (dataAdelantosdetalle["success"]) {
      // Hacer algo si "success" es true.
    } else {
      // Hacer algo si "success" es false.
    }
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return dataAdelantosdetalle;
});

final postMisPrestamosdetalleProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');

  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
    "idAdelanto": ref.watch(idAdelantoProvider),
  };

  final dynamic dataAdelantosdetalle = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointMisPrestamosFiles, postDatas);

  if (dataAdelantosdetalle is Map<String, dynamic> &&
      dataAdelantosdetalle["success"] != null) {
    if (dataAdelantosdetalle["success"]) {
      // Hacer algo si "success" es true.
    } else {
      // Hacer algo si "success" es false.
    }
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return dataAdelantosdetalle;
});

final postMisNotificacionesdetalleProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final token = await SharedPreferencesHelper.getdatos('token');
  final empleadoId = await SharedPreferencesHelper.getdatos('empleado');

  final postDatas = {
    "idEmpleado": empleadoId,
    "token": token,
  };

  final dynamic datanotificaciones = await fetchPostData(
      modo, completeUrldev, baseUrl, endpointMisNotificaciones, postDatas);

  if (datanotificaciones is Map<String, dynamic> &&
      datanotificaciones["success"] != null) {
    if (datanotificaciones["success"]) {
      // Hacer algo si "success" es true.
    } else {
      // Hacer algo si "success" es false.
    }
  } else {
    if (kDebugMode) {
      print(
          'Error: dataAdelantos no es un mapa válido o "success" no está presente.');
    }
    // Manejar el caso en el que dataAdelantos no es un mapa válido o cuando "success" no está presente.
  }

  return datanotificaciones;
});
