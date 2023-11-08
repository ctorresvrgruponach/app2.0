import 'package:http/http.dart' as http;

import '../libs/lib.dart';

class ApiHelper {
  final String baseUrl;

  ApiHelper(this.baseUrl);

  Future<dynamic> postRequest(Map<String, dynamic> data) async {
    if (kDebugMode) {
      print(data);
    }
    if (kDebugMode) {
      print(baseUrl);
    }
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data),
    );
    // print(response.statusCode);
    if (response.statusCode == 200) {
      return (response.body);
    } else if (response.statusCode == 401) {
      return ('{"success": false,"mensaje":"Unauthorized"}');
    } else {
      throw Exception('Failed to load data');
    }
  }
}
