import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../config/datos.dart';
import '../helpers/guardarvars.dart';
import 'peticion.dart';

bool ishiden = false;
String? cont;

bool obsecureText = true;
final List<String> listImages = [
  "assets/images/babytotem.png",
  "assets/images/babytotem.png",
];

final labelTextProvider = StateProvider<bool>((ref) {
  return true;
});

final postDataProviders =
    FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  final employeeNumberController = ref.watch(employeeNumberControllerProvider);
  final imssController = ref.watch(imssControllerProvider);

  final postDatas = {
    'no_empleado': employeeNumberController.text,
    'imss': imssController.text,
  };

  if (employeeNumberController.text != '' && imssController.text != '') {
    final data = await fetchPostData(
        modo, completeUrldev, baseUrl, endpointLogin, postDatas);
    if (!data["success"]) {
      if (kDebugMode) {
        print('logincorrecto');
      }
    }
    if (data['success'] == true) {
      final stateController = ref.read(labelTextProvider.notifier);
      SharedPreferencesHelper.setdatos('token', data['token']);
      SharedPreferencesHelper.setdatos(
          'empleadoId', employeeNumberController.text);
      SharedPreferencesHelper.setdatos('imss', imssController.text);

      stateController.state = false;
    } else {
      SharedPreferencesHelper.setdatos('token', '');
      SharedPreferencesHelper.setdatos('empleadoId', '');
      SharedPreferencesHelper.setdatos('imss', '');
    }
    return data;
  } else {
    return postDatas;
  }
});

final authenticatedWithBiometricsProvider =
    StateNotifierProvider<AuthenticationNotifier, bool>((ref) {
  return AuthenticationNotifier();
});

class AuthenticationNotifier extends StateNotifier<bool> {
  AuthenticationNotifier() : super(false);

  void setAuthenticated(bool value) {
    state = value;
  }
}

final employeeNumberControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});

final imssControllerProvider = Provider<TextEditingController>((ref) {
  final controller = TextEditingController();
  ref.onDispose(() {
    controller.dispose();
  });
  return controller;
});
