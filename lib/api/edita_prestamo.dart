import '../libs/lib.dart';

class ActualizaAvales {
  Future<Map<String, dynamic>> actualizaAvales() async {
    //variables que se mandaran
    final token         = await SharedPreferencesHelper.getdatos('token');
    final idPrestamo        = await SharedPreferencesHelper.getdatos('idPrestamo');
    final avales        = await SharedPreferencesHelper.getdatos('avales');

    String x = avales;
    x = x.replaceAllMapped(RegExp(r'\b(\w+)\b'), (Match match) {
      final replaced = '"${match.group(1)}"';
      return replaced;
    });
    x = x.replaceAll(RegExp(r'(:) (\d+)'), r'$1 "$2"');
    final firstColon = x.indexOf(':');
    x = '${x.substring(0, firstColon)}${x.substring(firstColon)}';

    var navales = jsonDecode(x);

    final postDatas = {
        "token": token,
        "idPrestamo": idPrestamo,
        "avales" : navales
      };
      String jsonRepresentation = jsonEncode(postDatas);

        if (kDebugMode) {
          print(jsonRepresentation);
        }

      final dynamic resPrestamo = await fetchPostData(modo, completeUrldev, baseUrl, confirmaPrestamo, postDatas);
      // print(resPrestamo);
      return resPrestamo;
  }
}
