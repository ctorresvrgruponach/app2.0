import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'api_helper.dart';

Future<Map<String, dynamic>> fetchPostData(String modo, String completeUrldev,
    String baseUrl, String endpointDatosEmpleado, postData) async {
  var apiii = modo == 'dev' ? completeUrldev : baseUrl;
  final api = ApiHelper("http://$apiii/$endpointDatosEmpleado");

  final response = await api.postRequest(postData);
  final decodedData = json.decode(response);
  if (kDebugMode) {
    print(decodedData);
  }
  return decodedData;
}
