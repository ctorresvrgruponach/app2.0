import 'dart:io';

import 'package:flutter_html_to_pdf/flutter_html_to_pdf.dart';
import 'package:path_provider/path_provider.dart';

import '../../libs/lib.dart';

class PdfGenerator {
  String htmlCode = "";
  String htmlFileName = "documento de identidad";
  BuildContext context;

  PdfGenerator(this.context);
  Future<bool> generatePdf() async {
    try {
      Datosgenerales datosGenerales = Datosgenerales();

      String firmabase =
          await SharedPreferencesHelper.getdatos('imagen_emplaedo');
      final email = await SharedPreferencesHelper.getdatos('email');
      final rfc = await SharedPreferencesHelper.getdatos('rfc');

      final nombre = await SharedPreferencesHelper.getdatos('nombrese');
      final apellidoPaterno =
          await SharedPreferencesHelper.getdatos('apellidoPaternoe');
      final apellidoMaterno =
          await SharedPreferencesHelper.getdatos('apellidoMaternoe');
      final curp = await SharedPreferencesHelper.getdatos('curpe');
      final direccionCp = await SharedPreferencesHelper.getdatos('direccionCp');
      final direccionCalle =
          await SharedPreferencesHelper.getdatos('direccionCalle');
      final direccionInt =
          await SharedPreferencesHelper.getdatos('direccionInt');
      final direccionExt =
          await SharedPreferencesHelper.getdatos('direccionExt');
      final direccionMunicipio =
          await SharedPreferencesHelper.getdatos('direccionMunicipio');
      final direccionColonia =
          await SharedPreferencesHelper.getdatos('direccionColonia');

      final direccionEstado =
          await SharedPreferencesHelper.getdatos('direccionEstado');
      final telefono = await SharedPreferencesHelper.getdatos('telefono');
      final pais = datosGenerales.funcioncurppais(curp);
      final genero = datosGenerales.funcioncurpgen(curp);
      final lugardenac = datosGenerales.funcioncurpln(curp);
      final fechadenac = datosGenerales.funcioncurpfn(curp);
      final nacionalidad = datosGenerales.funcioncurpna(curp);

      String firmaempleado =
          """<img src="data:image/png;base64,$firmabase" alt=""  width="50" height="60"/>""";

      htmlCode = """
      <p>&nbsp;</p>
<p><strong>ANEXO 1</strong></p>

<p>&nbsp;</p>
<p>Documento de identidad</p>
<p>&nbsp;</p>
<p>&nbsp;</p>
<table>
<tbody>
<tr>
<td width="589">
<p><strong>Nombre comercial del Producto:&nbsp;</strong>BABYT&Oacute;TEM (ANTICIPO DE N&Oacute;MINA)</p>
</td>
</tr>
<tr>
<td width="589">
<p><strong>Tipo de Cr&eacute;dito:&nbsp;</strong>Cr&eacute;dito Simple&nbsp; &nbsp; &nbsp;</p>
<p><strong>&nbsp;</strong></p>
</td>
</tr>
<tr>
<td width="589">
<p>Nombre : $nombre $apellidoPaterno $apellidoMaterno</p>
</td>
</tr>
<tr>
<td width="589">
<p>Fecha de nacimiento : $fechadenac</p>
</td>
</tr>
<tr>
<td width="589">
<p>Nacionalidad:$nacionalidad</p>
</td>
</tr>
<tr>
<td width="589">
<p>Ocupaci&oacute;n: Empleado</p>
</td>
</tr>
<tr>
<td width="589">
<p>Domicilio: $direccionCalle $direccionExt $direccionInt $direccionColonia $direccionMunicipio $direccionEstado</p>
</td>
</tr>
<tr>
<td width="589">
<p>C&oacute;digo postal &bull; $direccionCp</p>
</td>
</tr>
<tr>
<td width="589">
<p>CURP:$curp</p>
</td>
</tr>
<tr>
<td width="589">
<p>G&eacute;nero:$genero</p>
</td>
</tr>
<tr>
<td width="589">
<p>Entidad federativa de nacimiento:$lugardenac</p>
</td>
</tr>
<tr>
<td width="589">
<p>Pa&iacute;s de nacimiento:$pais</p>
</td>
</tr>
<tr>
<td width="589">
<p>N&uacute;mero(s) de tel&eacute;fono:$telefono</p>
</td>
</tr>
<tr>
<td width="589">
<p>Correo electr&oacute;nico:$email</p>
</td>
</tr>
<tr>
<td width="589">
<p>RFC:$rfc</p>
</td>
</tr>
</tbody>
</table>
<p>&nbsp;</p>
<p>&nbsp;</p>
<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;LA PARTE ACREDITADA</strong></p>
<p><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;$firmaempleado&nbsp;</strong></p>
<p>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ____________________________________</p>
<p><strong>T&Oacute;TEM PR&Eacute;STAMOS, S.A. DE C.V.&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; </strong><strong>&nbsp; $nombre $apellidoPaterno $apellidoMaterno</strong></p>
<p><strong>SOCIEDAD FINANCIERA DE OBJETO M&Uacute;LTIPLE NO REGULADA</strong></p>
<p><strong>REPRESENTADA POR El&nbsp;LIC. ABELARDO SEBASTI&Aacute;N ROMERO RUANO</strong></p>
<p>&nbsp;</p>
    """;

      if (kDebugMode) {
        print(htmlCode);
      }

      // ignore: use_build_context_synchronously
      await _convertToPdf(context);
      return true; // PDF generation successful
    } catch (e) {
      if (kDebugMode) {
        print("Error generating PDF: $e");
      }
      return false; // PDF generation failed
    }
  }

  Future<void> _convertToPdf(BuildContext context) async {
    final dir = await getApplicationDocumentsDirectory();
    var targetFileName = "$htmlFileName archivo";

    await FlutterHtmlToPdf.convertFromHtmlContent(
        '', dir.path, '$htmlFileName g');
    await FlutterHtmlToPdf.convertFromHtmlContent(
        htmlCode, dir.path, targetFileName);

    final bytes = File('${dir.path}/$targetFileName.pdf').readAsBytesSync();
    String base64Image = base64Encode(bytes);

    SharedPreferencesHelper.setdatos(htmlFileName, base64Image);
  }
}
