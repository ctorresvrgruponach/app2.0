
import 'package:flutter/services.dart';

import '../libs/lib.dart';

class ConfirmarPrestamo {
  Future<Map<String, dynamic>> confirmaprestamo() async {
    //variables que se mandaran

    final token         = await SharedPreferencesHelper.getdatos('token');
    final empleadoId    = await SharedPreferencesHelper.getdatos('empleado');
    final idOperacionid = await SharedPreferencesHelper.getdatos('idoperacionid');
    final plazos        = await SharedPreferencesHelper.getdatos('plazos');
    final monto         = await SharedPreferencesHelper.getdatos('monto');
    final montoPago     = await SharedPreferencesHelper.getdatos('monto_pago');
    final comision      = await SharedPreferencesHelper.getdatos('comision');
    final avales        = await SharedPreferencesHelper.getdatos('avales');
    final ine           = await SharedPreferencesHelper.getdatos('Identificación (INE)');
    final comprobante   = await SharedPreferencesHelper.getdatos('Comprobante (DOMICILIO)');

 // Corrigiendo la cadena para que tenga el formato de JSON válido;
 String x = avales;

  // Reemplazar los caracteres y convertirlos a JSON
  x = x.replaceAllMapped(RegExp(r'\b(\w+)\b'), (Match match) {
    final replaced = '"${match.group(1)}"';
    return replaced;
  });

  x = x.replaceAll(RegExp(r'(:) (\d+)'), r'$1 "$2"');
  // Agregar comillas a la clave exterior
  final firstColon = x.indexOf(':');
  x = x.substring(0, firstColon) + '' + x.substring(firstColon) + '';

  print('AQUI TU PINCHE JSON $x');

  // Convertir a JSON
  var navales = jsonDecode(x);
  // String jsonString = jsonEncode(json);
  // print(jsonString);

    final postDatas = {
      "token": token,
      'solicitante': {
        "idEmpleado"  : empleadoId,
        "idOperacion" : idOperacionid,
        "monto"       : monto,
        "montoPago"   : montoPago,
        "plazos"      : plazos,
        "comision"    : comision,
        "ine"         : ine,
        "comprobante" : comprobante
    },
    "avales" : navales
    };
    String jsonRepresentation = jsonEncode(postDatas);

      if (kDebugMode) {
        print(jsonRepresentation);
      }
     Clipboard.setData(ClipboardData(text: '$jsonRepresentation'));
     print(postDatas);

    final dynamic resPrestamo = await fetchPostData(modo, completeUrldev, baseUrl, confirmaPrestamo, postDatas);
    // print(resPrestamo);
    return resPrestamo;
  }
}
