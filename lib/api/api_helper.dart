import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class ApiHelper {
  final String baseUrl;

  ApiHelper(this.baseUrl);

  Future<dynamic> postRequest(Map<String, dynamic> data) async {
    try {
      if (kDebugMode) {
        print(data);
        print(baseUrl);
      }

      final response = await http.post(
        Uri.parse(baseUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        if (json.decode(response.body)['success'] == false &&
            baseUrl.contains('login')) {
          return ('{"success": false,"mensaje":"Login incorrecto"}');
        } else {
          return (response.body);
        }
      } else if (response.statusCode == 401) {
        // Manejar el código de estado 401 (Unauthorized)
        return ('{"success": false,"mensaje":"Unauthorized"}');
      } else if (response.statusCode == 101) {
        // Manejar el código de estado 401 (Unauthorized)
        return ('{"success": false,"mensaje":"Unauthorized"}');
      } else {
        return ('{"success": false,"mensaje":"Unauthorized"}');
        // Manejar otros códigos de estado
        // throw Exception(
        //     'Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Manejar errores de conexión

      return ('{"success": false,"mensaje":"Error de conexión"}');
    }
  }
}
