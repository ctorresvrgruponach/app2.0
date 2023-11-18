import 'dart:math';

import 'package:intl/intl.dart';

import '../../libs/lib.dart';

String? apellidoPaterno;
String? rfcEmpleado;
String? montoPrestamo;
String? montoPrestamoletra;
String? comisionSinIva;
String? comision;
String? periodo;
double? iva;
String? salario;
String? totalPago;
String? nombre;
String? apellidoMaterno;
String? fechaactualdocumentos;
String? fechalimitedocumentos;
String? fechaVencimiento;
String? direccionCalle;
String? direccionInt;
String? direccionExt;
String? direccionColonia;
String? direccionCp;
String? direccionMunicipio;
String? estado;
String? email;
String? telefono;
String? noEmpleado;
String? formatter;
String? dia;
String? mes;
String? ano;
String? montotransacciones;
String? transacciones;
String? folioburo;

String? nombreBurofile;
String? nombrePerfilfile;
String? nombreContratofile;
double? catTotal = 0;
String? cat;

class HTMLtoWidget extends StatefulWidget {
  const HTMLtoWidget({
    super.key,
  });

  @override
  State<HTMLtoWidget> createState() => _HTMLtoWidgetState();
}

class _HTMLtoWidgetState extends State<HTMLtoWidget> {
  @override
  void initState() {
    final now = DateTime.now();
    formatter = DateFormat('d/MM/y').format(now);
    dia = DateFormat('d').format(now);
    mes = DateFormat('MM').format(now);
    ano = DateFormat('y').format(now);

    super.initState();
    SharedPreferencesHelper.getdatos('montoapedir').then((montoapedir) {
      SharedPreferencesHelper.getdatos('periodosPagos').then((periodosPago) {
        SharedPreferencesHelper.getdatos('totaldescontar').then((totalPago) {
          if (kDebugMode) {
            print('montoapedir');
          }
          if (kDebugMode) {
            print(double.parse(montoapedir));
          }
          if (kDebugMode) {
            print('totalPago');
          }
          if (kDebugMode) {
            print(double.parse(totalPago));
          }
          if (kDebugMode) {
            print('periodosPagos');
          }
          if (kDebugMode) {
            print(double.parse(periodosPago));
          }
          var catt = pow((double.parse(totalPago) / double.parse(montoapedir)),
                  double.parse(periodosPago)) -
              1;
          // //print(catt);
          catTotal = (catt * 100);
          cat = catTotal.toString();
        });
      });
    });

    SharedPreferencesHelper.getdatos('nombreBurofile').then((value) {
      setState(() {
        nombreBurofile = value;
      });
    });

    SharedPreferencesHelper.getdatos('nombrePerfilfile').then((value) {
      setState(() {
        nombrePerfilfile = value;
      });
    });
    SharedPreferencesHelper.getdatos('nombreContratofile').then((value) {
      setState(() {
        nombreContratofile = value;
      });
    });
    SharedPreferencesHelper.getdatos('apellidoPaterno').then((value) {
      setState(() {
        apellidoPaterno = value;
      });
    });
    SharedPreferencesHelper.getdatos('apellidoMaterno').then((value) {
      setState(() {
        apellidoMaterno = value;
      });
    });
    SharedPreferencesHelper.getdatos('usuario').then((value) {
      setState(() {
        noEmpleado = value;
      });
    });
    SharedPreferencesHelper.getdatos('rfc').then((value) {
      setState(() {
        rfcEmpleado = value;
        // //print(value);
      });
    });
    SharedPreferencesHelper.getdatos('nombres').then((value) {
      setState(() {
        nombre = value;
        // print(value);
      });
    });

    SharedPreferencesHelper.getdatos('salarioMensual').then((value) {
      //  //print(value);
      setState(() {
        salario = value;
      });
    });

    SharedPreferencesHelper.getdatos('direccionCalle').then((value) {
      //print(value);
      setState(() {
        direccionCalle = value;
      });
    });
    SharedPreferencesHelper.getdatos('direccionColonia').then((value) {
      //  //print(value);
      setState(() {
        direccionColonia = value;
      });
    });

    SharedPreferencesHelper.getdatos('direccionCp').then((value) {
      //  //print(value);
      setState(() {
        direccionCp = value;
      });
    });

    SharedPreferencesHelper.getdatos('direccionEstado').then((value) {
      //  //print(value);
      setState(() {
        estado = value;
      });
    });

    SharedPreferencesHelper.getdatos('direccionExt').then((value) {
      //  //print(value);
      setState(() {
        direccionExt = value;
      });
    });
    SharedPreferencesHelper.getdatos('comision').then((value) {
      //  //print(value);
      setState(() {
        comision = value;
        iva = (double.parse(value) * 0.16);
      });
    });

    SharedPreferencesHelper.getdatos('totaldescontar').then((value) {
      //  //print(value);
      setState(() {
        totalPago = value;
      });
    });

    SharedPreferencesHelper.getdatos('direccionInt').then((value) {
      //  //print(value);
      setState(() {
        direccionInt = value;
      });
    });

    SharedPreferencesHelper.getdatos('direccionMunicipio').then((value) {
      //  //print(value);
      setState(() {
        direccionMunicipio = value;
      });
    });

    SharedPreferencesHelper.getdatos('email').then((value) {
      //  //print(value);
      setState(() {
        email = value;
      });
    });

    SharedPreferencesHelper.getdatos('telefono').then((value) {
      //  //print(value);
      setState(() {
        telefono = value;
      });
    });

    SharedPreferencesHelper.getdatos('montoapedir').then((value) {
      //  //print(value);
      setState(() {
        montoPrestamo = value;
      });
    });
    SharedPreferencesHelper.getdatos('perfilTransaccional').then((value) {
      //  //print(value);
      setState(() {
        montotransacciones = value;
      });
    });
    SharedPreferencesHelper.getdatos('depositos').then((value) {
      //  //print(value);
      setState(() {
        transacciones = value;
      });
    });

    SharedPreferencesHelper.getdatos('folioConsulta').then((value) {
      //  //print(value);
      setState(() {
        folioburo = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Documentos'),
        backgroundColor: const Color.fromARGB(255, 2, 9, 72),
      ),
      body: Documentos(
        montoPrestamo: montoPrestamo.toString(),
        totalPago: totalPago.toString(),
        nombre: nombre.toString(),
        apellidoPaterno: apellidoPaterno.toString(),
        apellidoMaterno: apellidoMaterno.toString(),
        fechaactualdocumentos: formatter.toString(),
        fechalimitedocumentos: formatter.toString(),
        fechaVencimiento: formatter.toString(),
        direccionCalle: direccionCalle.toString(),
        direccionInt: direccionInt.toString(),
        direccionExt: direccionExt.toString(),
        direccionColonia: direccionColonia.toString(),
        direccionCp: direccionCp.toString(),
        direccionMunicipio: direccionMunicipio.toString(),
        estado: estado.toString(),
        rfcEmpleado: rfcEmpleado.toString(),
        email: email.toString(),
        telefono: telefono.toString(),
        noEmpleado: noEmpleado.toString(),
        montoLetra: '',
        montoPrestamoletra: '',
        comisionSinIva: double.parse(comision!).toStringAsFixed(2).toString(),
        iva: double.parse((iva!).toStringAsFixed(2)).toString(),
        salario: salario.toString(),
        periodo: '1',
        comision: double.parse(comision!).toStringAsFixed(2).toString(),
        montotransacciones: montotransacciones.toString(),
        transacciones: transacciones.toString(),
        folioburo: folioburo.toString(),
        catTotal1: double.parse(cat!).toStringAsFixed(1).toString(),
      ),
    );
  }
}

class Documentos extends StatefulWidget {
  const Documentos({
    super.key,
    required this.montoPrestamo,
    required this.montoPrestamoletra,
    required this.comisionSinIva,
    required this.comision,
    required this.periodo,
    required this.iva,
    required this.salario,
    required this.totalPago,
    required this.nombre,
    required this.apellidoPaterno,
    required this.apellidoMaterno,
    required this.fechaactualdocumentos,
    required this.fechalimitedocumentos,
    required this.fechaVencimiento,
    required this.direccionCalle,
    required this.direccionInt,
    required this.direccionExt,
    required this.direccionColonia,
    required this.direccionCp,
    required this.direccionMunicipio,
    required this.estado,
    required this.rfcEmpleado,
    required this.email,
    required this.telefono,
    required this.noEmpleado,
    required this.montoLetra,
    required this.transacciones,
    required this.montotransacciones,
    required this.folioburo,
    required this.catTotal1,
  });
  final String montoPrestamo;
  final String montoPrestamoletra;
  final String comisionSinIva;
  final String comision;
  final String periodo;
  final String iva;
  final String salario;
  final String totalPago;
  final String nombre;
  final String apellidoPaterno;
  final String apellidoMaterno;
  final String fechaactualdocumentos;
  final String fechalimitedocumentos;
  final String fechaVencimiento;
  final String direccionCalle;
  final String direccionInt;
  final String direccionExt;
  final String direccionColonia;
  final String direccionCp;
  final String direccionMunicipio;
  final String estado;
  final String rfcEmpleado;
  final String email;
  final String telefono;
  final String noEmpleado;
  final String montoLetra;
  final String transacciones;
  final String montotransacciones;
  final String folioburo;
  final String catTotal1;

  @override
  State<Documentos> createState() => _DocumentosState();
}

class _DocumentosState extends State<Documentos> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: html(nombreBurofile, nombrePerfilfile, nombreContratofile),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: //someMap[widget.texto] != widget.texto
                  () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 5, 49, 91),
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(displayWidth(context) * 0.02),
                ), // This is what you need!
              ),
              child: SizedBox(
                width: displayWidth(context) * 0.6,
                child: Center(
                  child: Text(
                      "Acepto que mi firma digital se usará para contrato y anexos",
                      style: TextStyle(
                        fontSize: displayWidth(context) * 0.04,
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  HtmlWidget html(nombreBurofile, nombrePerfilfile, nombreContratofile) {
    iniciaload();
    String anexo1 = """
<table style="width:106.333px">
	<tbody>
		<tr>
			<td style="width:96px"><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="width:531.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:521px"><strong><span style="font-size:10px">ANEXO 1&nbsp;</span></strong></td>
		</tr>
		<tr>
			<td style="text-align:right; width:521px"><strong><span style="font-size:10px">RECA: 2850-439-038474/01-01140-0523</span></strong></td>
		</tr>
		<tr>
			<td style="text-align:center; width:521px"><span style="font-size:11px"><strong>CAR&Aacute;TULA DE CR&Eacute;DITO</strong></span></td>
		</tr>
	</tbody>
</table>

<table border="1" style="width:530.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:520px"><span style="font-size:10px"><strong>Nombre comercial del Producto:</strong> T&Oacute;TEM PERSONAL<br />
			<strong>Tipo de Cr&eacute;dito: </strong>Cr&eacute;dito Personal</span></td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:158px; width:529.333px">
	<tbody>
		<tr>
			<td style="width:106px">
			<p style="text-align:center"><span style="font-size:10px"><strong>CAT (Costo Anual Total)</strong></span></p>

			<p style="text-align:center"><span style="font-size:10px">__${widget.catTotal1}___<br />
			Sin IVA<br />
			Para fines informativos y de comparaci&oacute;n</span></p>
			</td>
			<td style="vertical-align:top; width:95px">
			<p style="text-align:center"><strong><span style="font-size:10px">TASA DE INT&Eacute;RES ANUAL FIJA </span></strong></p>

			<p><span style="font-size:10px">ORDINARIA: __0%___<br />
			MORATORIA: __0%___</span></p>
			</td>
			<td style="vertical-align:top; width:131px">
			<p style="text-align:center"><span style="font-size:10px"><strong>MONTO O LINEA DE CR&Eacute;DITO</strong> </span></p>

			<p style="text-align:center"><span style="font-size:10px">___${widget.montoPrestamo}__</span></p>
			</td>
			<td style="vertical-align:top; width:177px">
			<p style="text-align:center"><span style="font-size:10px">MONTO TOTAL A PAGAR </span></p>

			<p style="text-align:center"><span style="font-size:10px">&nbsp;&nbsp;</span><br />
			&nbsp; __${widget.totalPago}____</p>

			<p style="text-align:center"><span style="font-size:10px">SALDO INSOLUTO M&Aacute;S ACCESORIOS</span></p>
			</td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:24px; width:529.333px">
	<tbody>
		<tr>
			<td style="width:158px">
			<p><span style="font-size:10px">PLAZO DEL CREDITO: 1</span></p>
			</td>
			<td style="vertical-align:top; width:355px">
			<p><span style="font-size:10px">FECHA L&Iacute;MITE DE PAGO: _${widget.fechalimitedocumentos}___ </span></p>

			<p><span style="font-size:10px">FECHA DE CORTE: _${widget.fechalimitedocumentos}__</span></p>
			</td>
		</tr>
	</tbody>
</table>

<table border="1" style="width:531.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:521px"><strong><span style="font-size:11px">COMISIONES RELEVANTES</span></strong></td>
		</tr>
	</tbody>
</table>

<table border="1" style="width:532.333px">
	<tbody>
		<tr>
			<td style="width:522px"><strong><span style="font-size:10px">Apertura: 13% M&Aacute;S IVA</span></strong></td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:60px; width:532.333px">
	<tbody>
		<tr>
			<td style="width:522px"><span style="font-size:10px"><strong>ADVERTENCIAS:</strong><br />
			▪ El incumplimiento de sus obligaciones puede generar comisiones e intereses moratorios.<br />
			▪ Contratar cr&eacute;ditos arriba de su capacidad de pago puede afectar su historial crediticio.</span></td>
		</tr>
	</tbody>
</table>

<table border="1" style="width:531.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:521px"><strong><span style="font-size:10px">SEGUROS</span></strong></td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:6px; width:532.333px">
	<tbody>
		<tr>
			<td style="width:178px"><span style="font-size:10px">Seguro:<br />
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;NA</span></td>
			<td style="width:178px"><span style="font-size:10px">Aseguradora:<br />
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;NA</span></td>
			<td style="width:152px"><span style="font-size:10px">Cl&aacute;usula:<br />
			&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;N/A</span></td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:14px; width:534.333px">
	<tbody>
		<tr>
			<td style="width:524px">
			<p><span style="font-size:10px"><strong>ESTADO DE CUENTA:</strong> </span></p>

			<p><span style="font-size:10px">Enviar a Domicilio__________ Consulta V&iacute;a Internet ____________ Enviar por correo electr&oacute;nico___________</span></p>
			</td>
		</tr>
	</tbody>
</table>

<table border="1" style="width:533.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:523px"><span style="font-size:10px"><strong>ACLARACIONES Y RECLAMACIONES:</strong></span><br />
			<span style="font-size:10px">&ldquo;T&Oacute;TEM PR&Eacute;STAMOS, S.A. DE C. V. SOFOM, E. N. R.&rdquo;. Pone a disposici&oacute;n del CLIENTE su Unidad Especializada de Atenci&oacute;n a Usuarios para cualquier consulta y/o reclamaci&oacute;n que desee realizar, en horario de 9:00 a 16:00 horas de lunes a viernes en nuestra oficina ubicada en: Av. Adolfo Ru&iacute;z Cortines Edif. Torre 2, PB, Mz. 1, Lt. 26, Oficina 118, Lomas de Atizap&aacute;n 2da Secc. Atizap&aacute;n de Zaragoza, Estado de M&eacute;xico, C.P. 52977. Tel&eacute;fono: 5515 42 37 99. Correo electr&oacute;nico:<span style="color:#3498db"><u> </u></span><span style="color:#0000ff"><u>administracion@totemprestamos.mx</u></span></span></td>
		</tr>
	</tbody>
</table>

<table border="1" style="width:536.333px">
	<tbody>
		<tr>
			<td style="width:526px"><span style="font-size:10px"><strong>REGISTRO DE CONTRATOS DE ADHESI&Oacute;N N&Uacute;M: 2850-439-038474/01-01140-0523</strong></span><br />
			<span style="font-size:10px">Comisi&oacute;n Nacional para la Protecci&oacute;n y Defensa de los Usuarios de Servicios Financieros (CONDUSEF):<br />
			Tel&eacute;fono: 01 800 999 8080 y 53400999. P&aacute;gina de Internet. www.condusef.gob.mx</span></td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:32px; width:536.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:272px"><strong><span style="font-size:10px">EL ACREDITANTE</span></strong></td>
			<td style="text-align:center; width:247px"><strong><span style="font-size:10px">EL ACREDITADO</span></strong></td>
		</tr>
	</tbody>
</table>

<table align="left" dir="ltr" style="height:104px; width:490.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:360.938px">________________________________________&nbsp;<br />
			<span style="font-size:9px"><strong>T&Oacute;TEM PR&Eacute;STAMOS&rdquo;, S.A. DE C.V. SOCIEDAD FINANCIERA DE OBJETO M&Uacute;LTIPLE NO REGULADA&nbsp;<br />
			REPRESENTADA POR EL<br />
			LIC. ABELARDO SEBASTIAN ROMERO RUANO</strong></span></td>
			<td style="text-align:center; vertical-align:top; width:212px">________________________________________ <span style="font-size:9px">&nbsp;<strong>NOMBRE COMPLETO</strong></span></td>
		</tr>
	</tbody>
</table>

""";
    String anexo2 = """ 



















<table style="width:101.333px">
	<tbody>
		<tr>
			<td style="width:91px"><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:528px"><strong><span style="font-size:10px">ANEXO 2</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:539.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:529px"><strong><span style="font-size:10px">RECA: 2850-439-038474/01-01140-0523</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:528px"><strong><span style="font-size:11px">PAGAR&Eacute; NO NEGOCIABLE</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="width:528px">
			<p><strong><span style="font-size:10px">FECHA DE SUSCRIPCI&Oacute;N: ____${widget.fechaactualdocumentos}___</span></strong></p>
			</td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="width:528px">
			<p style="text-align:right"><span style="font-size:10px"><strong>BUENO POR: __${widget.totalPago}___</strong></span></p>

			<p style="text-align:right"><span style="font-size:10px"><strong>(________________________ /100 M. N.)</strong></span></p>
			</td>
		</tr>
	</tbody>
</table>

<table style="width:539.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:529px"><span style="font-size:10px"><strong>FECHA DE VENCIMIENTO: ___${widget.fechaVencimiento}____</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="width:540.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:530px"><span style="font-size:10px"><strong>LUGAR DE SUSCRIPCI&Oacute;N: Atizap&aacute;n de Zaragoza, Estado de M&eacute;xico.</strong><br />
			Por este <strong>PAGAR&Eacute;</strong> prometo y me obligo a pagar incondicionalmente, a la orden de <strong>&ldquo;T&Oacute;TEM PR&Eacute;STAMOS SOCIEDAD ANONIMA DE CAPITAL VARIABLE, SOCIEDAD FINANCIERA DE OBJETO MULTIPLE, E.N.R.&rdquo;</strong>, en sus oficinas ubicadas en TORRE ESMERALDA Av. Adolfo Ruiz Cortines #26 Planta Baja, Oficina 118, Col, Lomas de Atizap&aacute;n, 52977 Cd L&oacute;pez Mateos, M&eacute;x, la cantidad de <strong>________________________ (________________________ PESOS 00/100</strong> M. N.). El importe del presente PAGAR&Eacute; no causar&aacute; intereses ordinarios, solo se distribuye la comisi&oacute;n por apertura a raz&oacute;n del 13% en el siguiente calendario de pagos de <strong>(comisi&oacute;n)</strong></span></td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:44px; width:540.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:99.3906px"><span style="font-size:10px">FECHA DE PAGO MENSUAL</span></td>
			<td style="text-align:center; width:99.3906px"><span style="font-size:10px">PAGO A CAPITAL</span></td>
			<td style="text-align:center; width:99.3906px"><span style="font-size:10px">COMISI&Oacute;N</span></td>
			<td style="text-align:center; width:99.3906px"><span style="font-size:10px">IVA COMISI&Oacute;N</span></td>
			<td style="text-align:center; width:105px"><span style="font-size:10px">CANTIDAD A PAGAR</span></td>
		</tr>
		<tr>
			<td style="text-align:center; font-size:9px; vertical-align:top; width:99.3906px">__${widget.fechaVencimiento}__</td>
			<td style="text-align:center; font-size:9px; vertical-align:top; width:99.3906px">____${widget.montoPrestamo}___</td>
			<td style="text-align:center; font-size:9px; vertical-align:top; width:99.3906px">_${widget.comisionSinIva}_</td>
			<td style="text-align:center; font-size:9px; vertical-align:top; width:99.3906px">__${widget.iva}__ %</td>
			<td style="text-align:center; font-size:9px; vertical-align:top; width:105px">__${widget.totalPago}__<br />
			&nbsp;</td>
		</tr>
	</tbody>
</table>

<table style="width:540.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:530px"><span style="font-size:10px">En caso de mora en el pago de uno o m&aacute;s exhibiciones o la cantidad equivalente, se tendr&aacute; por vencido anticipadamente el presente instrumento, un d&iacute;a h&aacute;bil despu&eacute;s del mes de calendario en que se incumple el pago, para que en lo sucesivo exista la posibilidad de cobro de los gastos de cobranza que se generen.</span></td>
		</tr>
	</tbody>
</table>

<table style="height:32px; width:541.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:267px"><strong><span style="font-size:10px">EL ACREDITANTE</span></strong></td>
			<td style="text-align:center; width:258px"><strong><span style="font-size:10px">EL ACREDITADO</span></strong></td>
		</tr>
	</tbody>
</table>

<table align="left" dir="ltr" style="height:104px; width:540.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:273px">
			<p>____________________________&nbsp;<br />
			<span style="font-size:9px"><strong>T&Oacute;TEM PR&Eacute;STAMOS&rdquo;, S.A. DE C.V. SOCIEDAD FINANCIERA DE OBJETO M&Uacute;LTIPLE NO REGULADA&nbsp;<br />
			REPRESENTADA POR EL<br />
			LIC. ABELARDO SEBASTIAN ROMERO RUANO</strong></span></p>
			</td>
			<td style="text-align:center; vertical-align:top; width:258px">
			<p>__________________________</p>

			<p>&nbsp;<span style="font-size:9px">&nbsp;</span><span style="font-size:9px"><strong>${widget.nombre} ${widget.apellidoPaterno} ${widget.apellidoMaterno}</strong></span></p>
			</td>
		</tr>
	</tbody>
</table>






""";

    String anexo3 = nombreContratofile == ''
        ? """ <table style="height:69px; width:134px">
	<tbody>
		<tr>
			<td style="width:122px"><img class="note-float-left" src="data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAOgAAADoCAYAAADlqah4AAAACXBIWXMAAAsSAAALEgHS3X78AAAQJ0lEQVR4nO3dT24byRXH8XIwABMggDRAgKwCKScweYKhT2DOikvTQPamt9kMfQLTJzC15GrkE5g6QUsnGBFBFoMEGBNIkCEQREEJr+1yqUmxu191P6m/H4CwLdHNYnf/6l8X2U9ubm4cAJt+w3EB7CKggGEEFDCMgAKGEVDAMAIKGEZAAcMIKGAYAQUMI6CAYQQUMIyAAoYRUMAwAgoYRkABwwgoYBgBBQwjoIBhBBQwjIAChhFQwDACChhGQAHDCChgGAEFDCOggGEEFDCMgAKGEVDAMAIKGEZAAcMIKGAYAQUMI6CAYQQUMIyAAoYRUMAwAgoY9k3VovUG46FzbsjBVXPsnPtkqDy/dc79aqAcj8Vimy2vy76XygGVcP7w6Hdrd62dcydd3wmKVs650gGliwsYVqcFbduVdAn947JGWXxP4DvF93IhtWVZf3HO/Vcqzf9JF/OPiuW6z1p+n7/+P3y3rMJ2Jsot71mVlieQD8NOH2KP4KEEND/p/eNymy3Vxmq9wXimHNDVNlvOKpTjvuHCL865fznn/lS9aLf+45z7p3Pu9865b4OfxyfvdcX3MVQOgh+7VanwCvUGYx/UvgTXP54qllWd5YD6Gn0uB8jS5Elbvg0C5UP2b+fcH0qU5W8S7t8phPzBkoka/zh3XwLrW/2pc+7I2vuyGFDfdZ1ts+W5gbJY9Tt5eD/f0xXOf9/ZUO4jgfU9hVlvMJ7I3810hS1NEm2ccy+32bJPOEvJw7mJ/tPP8meT49gHbZstF9L9fWPlfVgJ6Ac/iJcdhGqOZGz5qzwIZgV+OCVj7z9Lb65VFgLqW80R40wVf3fO/dWfZ4/gvbTKd319b05mkVvTZkB9l2xAq6nG1/bDbbZ8K7OTcZcXFWyzpR+Xvmxr37UV0I2cTHWuX+KLPJy3vRDZr0MLXbTHQBqRVkLaRkAJp66vwpmT/TuhJdXRVkjbCOiIcKopDGcuaEkJqQIJ6esmX7PpgL7UXBXScRup7PZOrgUtKRRss+W8yYmjJgN6xoSQqtGhH1+S68pmru09AtOmxvdNBfRK3hR0vCnbE5Frexfs//qk1zJqYujQVEAnXOdUc1VlEbto5KTqAum9JG90mgjoGyaFVFUeT0olyXhUiQzZPqR8jdQBXdeo7XFX7cpOxqN0dfVMU/ZKUgeU2lpP/vE7DRwXJdLV1Toud6QM6AWXVFTNtMbxclK1usb0kZkH30ihKmVA6drqWSe4RDVjwkiHVJxJzvdUAaX11KV+8KUV5XO3SqQCVW9FUwWU1lNPitYzx3HSpT4WTRHQK1pPVckmIBiLqltoDxtSBDTZCdVBm4pffVkGyy+VyFhUddigHdAN621VnadegSW9HT43qke1gdIOKOHU1VRvhOOmRBaSqFV4BNSudYNLJDluutQqVs2ANnlCdUFjY3npRiddU9oxauNQzYAyOaSr6WuUXBNVolnhaQaUSyt6rqrcS7ImAqpLZX9qBZTura7Gw0I3V52pgFL76mprf3IclUiFV/tjfQTUnjZ7IwxTdNXORZ27m13nNQRL+1TktW1r+9KPe3uD8Znc7JYhS32r4LhWWnBSOaCyYojrZ0q22XLYyAvdQ251AJ19eRnc4bsSS7cfBBAhoIBhBBQwjIAChhFQwDACChhGQAHDCChgGAEFDCOggGEEFDCMgAKGEVDAMAIKGEZAAcMIKGAYAQUMI6CAYQQUMIyAAoYRUMAwAgoYRkABwwgoYBgBBQwjoIBhBBQwjIAChhFQwDACChhGQAHDCChgGAEFDCOggGEEFDCMgAKGEVDAsG84OO7aOXehvL0uu1R+75+6vDOf3NzcGCgGgCJ0cQHDCChgGAEFDCOggGEEFDCMgAKGEVDAMAIKGEZAAcOSL/XrDcbDxC9xuc2WSZaD9QbjiXNu5JzrR0v4TmVJ27l/pHj93mB8LK+bzDZbrkqWyZfnOEV5ypYld+h+qrH9Q95zsnOwibW4Hwt+tnbOLaKf/RD9+ywKhQ/K04JtPXPOVdr5u/QG45lzbioBnG2z5Z31pXLg/HPmvcF47v9UPkj9HfvuInq/vrJ4ET3nTfD3Y9l3JwXbelKhTKd7XrvouMZ8hf2dQllyx7LN0CR+v73BeFB0HA/g9/VR9LQ30b+vU60ZTr4WtzcYhy+w8SdLUW0WPc97Fj+vNxifSmie7ntejbL25QQ73VXOgv8zlDL5AzRRLMswCuiVlOn6nuf51uLOyR6U82jf82qW8WKbLe/tMcn/m4fHsW5Zou2vCiqBd9tsOS25nZGU86uwa5b1Pk2OQX04h3VOYDk5h3KyqpKDsZJwHlxOed5QDuJH6RZru5IyVf6kTFDOTYLylS7LNlv2UxzHwFn071GFbUwO6BEk1WRAhxW7GF+RbqTqiSbh/FFal3nZcsrz827Pe+WQrmXf1e5CSTmrnKipjBJWGOfRv0+kh3SQYGyrOnwqq6mAnmmEMycna6nuyi5Bt9Zbb7PlrOKm5sHJ9l5xcmymObaVljRuXVohPYJ5itfeZsvzgvCXqThHBSFvXFMBTXEQig5AFYtgXFb5gEiIwu7QQmrhOjbbbJmii9Vqty2SJKAiPp5leg8jC/upiYCuNVvPnASiVg0ns7XhhFPdAxKW50ShlU9Sg0sruk6x7X18hRX3LOQ4vkv0kpW6uXn3NsV5W1bygG6z5ekBT6u67cqzpnIQvgpQ3QNSUJZp1VZUJlJSTDjl2092XPYYFlwScWVnVw9Vo5tronvrOr6SaBJd39L6XqJwZvKo5LjnsWtjgiruFR0aUBPDgK4HNKQ1ERNvx9KsaWukJ2EhoEcya1/IUvfWdTWgchDiVUlaByTeTtGqmS6aFazISU6CFo+391UUk8QTV6V0tQVNucb1TkvcwHpks2RiyIfzVYtlLDObO7Ey/nR8Ly6UnUoYnVSCx7Iyq2gdcJMWUQVx282VSaTPZCmpq7NiSxstKDR9kpU3K+kmLhSvV1dWoptrZnIo19UWtNPfVp7Qpx0fhFjs+FRIkxbRJ6aKAjqxNqnX1Ra067dnaJSRNcBFs7mfZ/Itdm9dhwPadAtqYsq+TW2tXspJ8OJPz4yiv5vq3rquBlRq9FTjoniFzjrVp+0foLYDEL/+82ClV+sfLSvS5YUK8VhJ61JIHFAzU/YGtPrRrR3HYiTrc68tVqRdDmhcW2p9104cUHO1cltkfXHhx/l8SIJLNEns6eaauvYZ6mxA5RpYOCYq+r6jUqS7FF7zu7CyZOwBaGoxR7xK6LmlxfGxrn/t5lc1tsKKn/j/J/mUxiPV1CxvURCTfStfXZ0OqHwYOvwUS91PnoQn2Ttaz8NIxdjImmUJ4ofox2bnCbregrroe3FGVT+/KdfR8q+gvEr1GcdHKunYs0AcSAJqVfQlZEc1TpZ8bHPV4HjqwZPFAk1/4icM5Jnly2CdD6j7cl10KJNGr8p+K588/7l0l1W+ga8LZAng+6bfatTNNX0ZjE+zCB9SuR42k2/l69/3jXrSHZ5LN/n1Nlua+RyhZcF+ft5iMc+lMjUd0OTfLF9EWpy4lYq7OVfRkrxFom+4u0PGk7Ng+n0Vrd/ty2MY3B6ikVZTbjMRfhqn6MPn8de3TDUmrA547c0Byxr7exbNvyn7tacS9rhi7BeU484+8O8nnitoc/8WaSWgD4nMMBaNKVdat3kAdiGggGFMEgGGEVDAMAIKGEZAAcMIKGAYAQUMI6CAYZ1f6ief4v/hgKceqvRqmMekNxivlBe/P+vyghBaUMAwAgoYRkABwwgoYBgBBQwjoIBhBBQwjIAChhFQwDACChhGQAHDCChgGAEFDHsw3+onX3/50UBR2qL6KZkEnzp5ULbZ8slDKC8tKGAYAQUM44urAcNoQQHDCChgGAEFDCOggGEEdAd/c97eYDyVm/Rqbrd/wNOAWwS0gITSX8h/u+PeoFW3628Om5W9xT66i4AWG8kdtZ8p3yI9D/v0nucBt1Svg/YG41HByfdJbhFf6xbhO7btJEjTureg33Er9dxkmy2vd/zukG3nt8oPb/2+lnJXrgDkS7f3tfAzjS997g3Gt2XcZstR3W1F27yOb0Ef/N6Xe6WxvFF6RBOpeP3yxivpIS20bl0vvaKJbH8j26993mu3oP2C9Z3PfWF7g/Gp0rbDMaHf5gvZGXUdF2zfSQVTmbzvj1E4vRPn3I8190tYttOC8tcqu/tSfn8MnyuPn/02X0nFG7/mTN6L1vBiIcMVX/4L2Uev5Lys/Z4knO9l+x+cc5fy/rK6532SWz9ss+XnHRsUfrSnhSpjGrYK+aJvv6OVasOp8q0G8n2xkdb+qdTg/u/HdVrmbbac5/s0uIWFdvmn0d+1x88LfxLnPSAJjNqtOGTc78Nyts2Wk+Dn+Xm5KqiUy8ormX5+POV9jOocX9fQGDQ/WVRnQxvcfl15K3YUlPGT7y6GFZlFQdfwQh4vlGe1N7JfFsHPFvJzLZN8OBFucJst/eu8868vQ5A68mN8Gmz/UqN73sTNk/IdU6smKSIni6+9NoqtxiQ6YKs62/ZjzN5gvJYu7Yn8+NS/xgO4KdBIAjQPhgATpZ6Qk67gtQR/JF1E38N4LV3SWqQV8+U/3zFHcS5d3WHNYdJchlofe4PxhVQyq7qtp0vVgvYG45v8ITvgSnaGho/Btn+RA6rZEr2QLlb+0Nj2SFqg3Im8j8X+/9Y6X7mufSUjLc6dlkjBVFrMhezvC+m6a8hb+/uCUmucKEOrge9GSyXmu84/+evodd9Eqi7um+Dx0p/kdWdZA2fBtj/IjzVv9+cvrTwJHrW3Ld2dYRRSJy1H3cmzJKQX4Ss/v2BjJWN9f8KfFE3sVCXnxURauo3yGDefk9hVyeb7vnZPRo6xL/u3cs779/LW6iRRyvtjLgomicyO5eQAnQYni5OW6HN3N0X3X0EelKOCmfmJYo8oHwa8lssuavvCh783GPveWz+eRJThUd7C1QqoTHJduy8VzkK2n88cV35Pj+EGvvks7rFSK+0PZvjvuidNPou4CSYTToLfmwunnFwv4plP+d0ib/mVw6TVrY35xuJHuaQylfOlL+F8Ku+x7vv4SeYZplLZDIMKztR10DbktZ/WeO6tXLfMHz/VvFa2CGYrT6LfaZwcMY1KKj+5ivbpInpOHfvKqjKTKwtBXsr+vx0bSmC/K6qAKnodXNe+kfPGh/9d3eOr3YLOE7YIc2nNvuqO+H/3BuPvFU7MS9nRRQsV6lyrPJeAz4JZ0Y3UtpqTRAvZPxrXgvOVQ3e6frK/Xyt0cb+/Z7/64KicS34/y8qlYdDlVJllle3PZfuj4Pw51zgWfOVJg4Jv0ruwfg0UNrBYvll5jWr98gqMoAVtmOKSRHQAAQUMo4sLGEZAAcMIKGAYAQUMI6CAYQQUMIyAAoYRUMAwAgoYRkABwwgoYBgBBQwjoIBhBBQwjIAChhFQwDACChhGQAHDCChgGAEFDCOggGEEFDCMgAKGEVDAMAIKGEZAAcMIKGAYAQUMI6CAVc65/wMJr//rxTZMvAAAAABJRU5ErkJggg==" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="width:477px">
	<tbody>
		<tr>
			<td style="text-align:right; width:467px"><span style="font-size:11px"><strong>RECA: 2850-439-038474/01-01140-0523</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="width:478px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:466px"><span style="font-size:10px"><strong>CONTRATO DE APERTURA DE CR&Eacute;DITO SIMPLE DENOMINADO T&Oacute;TEM PERSONAL</strong>, que celebran de una parte la Sociedad Mercantil denominada <strong>&ldquo;T&Oacute;TEM PR&Eacute;STAMOS&rdquo;, SOCIEDAD AN&Oacute;NIMA DE CAPITAL VARIABLE, SOCIEDAD FINANCIERA DE OBJETO M&Uacute;LTIPLE, ENTIDAD NO REGULADA</strong>, a quien en lo sucesivo se le denominar&aacute; como &ldquo;LA PARTE ACREDITANTE&rdquo;, representada en este acto por el Lic. Abelardo Sebasti&aacute;n Romero Ruano, en su car&aacute;cter de Representante Legal, como se acredita en la escritura p&uacute;blica n&uacute;mero 3823 de fecha 29 de agosto de 2022, Poder otorgado ante la Fe P&uacute;blica de la licenciada Luz Mar&iacute;a Angelica Alatorre Carbajal, Notario P&uacute;blico n&uacute;mero 186 del Estado de M&eacute;xico, con residencia en la Ciudad de Atizap&aacute;n de Zaragoza, por otra parte __________________________________________________________________, a quien en lo sucesivo se le denominara <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong>, de conformidad con las siguientes declaraciones y cl&aacute;usulas:</span></td>
		</tr>
	</tbody>
</table>

<table border="0" cellpadding="0" cellspacing="1" style="width:478px">
	<tbody>
		<tr>
			<td style="text-align:center; width:468px"><span style="font-size:11px"><u><strong>DECLARACIONES</strong></u></span></td>
		</tr>
	</tbody>
</table>

<table style="width:483px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:471px"><span style="font-size:10px"><strong>PRIMERA.</strong> - De &ldquo;<strong>LA PARTE ACREDITANTE&rdquo;</strong> por conducto de su representante:<br />
			<strong>I.-</strong> Declara la sociedad denominada &ldquo;T&Oacute;TEM PR&Eacute;STAMOS, S.A. DE C.V., SOFOM, ENR&rdquo;, haberse constituido como Sociedad An&oacute;nima de Capital Variable, Sociedad Financiera De Objeto M&uacute;ltiple, Entidad No Regulada y de conformidad con lo dispuesto por las leyes mexicanas, y que dicha constituci&oacute;n consta en la Escritura P&uacute;blica N&uacute;mero 35,106 de fecha 03 de octubre de 2008, misma Escritura P&uacute;blica que fue pasada ante la Fe del Notario P&uacute;blico N&uacute;mero 215, de la ciudad de M&eacute;xico, Licenciado Uriel Oliva S&aacute;nchez, misma que fue Inscrita en el Registro P&uacute;blico de la Propiedad y de Comercio, bajo el folio mercantil n&uacute;mero 45082-14, de fecha 18 de diciembre de 2008.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:486px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:474px"><span style="font-size:10px"><strong>II.- </strong>Que su representada tiene como domicilio el siguiente: Av. Adolfo Ru&iacute;z Cortines Edif. Torre 2, PB, Mz. 1, Lt. 26, Oficina 118, Lomas de Atizap&aacute;n 2da Secc. Atizap&aacute;n de Zaragoza, Estado de M&eacute;xico, C.P. 52977.<br />
			<strong>III.-</strong> Que el Lic. Abelardo Sebasti&aacute;n Romero Ruano en su car&aacute;cter de representante legal de &ldquo;<strong>LA PARTE ACREDITANTE&rdquo;</strong>, con el que comparece a la celebraci&oacute;n y otorgamiento del presente contrato, no le ha sido revocado, modificado o limitado en forma alguna, por lo que cuenta con la capacidad legal suficiente para otorgarlo y obligar a su representada en t&eacute;rminos de este, tal y como quedar&aacute; acreditado dentro del presente contrato.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:487px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:475px"><span style="font-size:10px"><strong>IV.-</strong> Para su constituci&oacute;n y operaci&oacute;n con car&aacute;cter de Sociedad Financiera de Objeto M&uacute;ltiple, Entidad No Regulada, no requiere de autorizaci&oacute;n de la Secretar&iacute;a de Hacienda y Cr&eacute;dito P&uacute;blico para la celebraci&oacute;n y cumplimiento de este instrumento; as&iacute; como tampoco se encuentra sujeta a la supervisi&oacute;n y vigilancia de la Comisi&oacute;n Nacional Bancaria y de Valores, &uacute;nicamente para lo dispuesto por el art&iacute;culo 56 de la Ley General de Organizaciones y Actividades Auxiliares de Cr&eacute;dito.<br />
			<strong>V.-</strong> El Registro Federal de Contribuyentes es TPR081003MJ1.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:488px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:476px"><span style="font-size:10px"><strong>VI.- </strong>Que previa a la firma del contrato se le inform&oacute; a <strong>&ldquo;LA PARTE ACREDITADA</strong>&rdquo;, las condiciones del presente instrumento; as&iacute; como el Costo Anual Total (que en lo sucesivo se le denominar&aacute; CAT) del presente instrumento.<br />
			<strong>VII.- </strong>Que otorga conforme a este instrumento un cr&eacute;dito de n&oacute;mina hasta el monto m&aacute;ximo del cr&eacute;dito al que <strong>&ldquo;LA PARTE ACREDITADA</strong>&rdquo;, pueden acceder.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:492px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:480px"><span style="font-size:10px"><strong>SEGUNDA</strong>. - <strong>De &ldquo;LA PARTE ACREDITADA&rdquo;</strong> bajo protesta de decir verdad:<br />
			<strong>I.- </strong>Ser mexicano, mayor de edad, con capacidad legal suficiente para celebrar el presente contrato, oblig&aacute;ndose consecuentemente a los t&eacute;rminos de este y que tiene como domicilio el siguiente__________________________________________________ y su correo electr&oacute;nico es ________________________.<br />
			<strong>II.- </strong>Que reconoce la personalidad con la que<strong> &ldquo;LA PARTE ACREDITANTE&rdquo;</strong> comparece a la celebraci&oacute;n del presente acto;<br />
			<strong>III.- </strong>Que ha solicitado por <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> el otorgamiento de un cr&eacute;dito de n&oacute;mina en moneda nacional, en su favor el cual tendr&aacute; un manejo individual.<br />
			<strong>IV.- </strong>Que cuenta con la capacidad econ&oacute;mica para hacer frente a las obligaciones que adquiere por medio del presente contrato.<br />
			<strong>V.-</strong>Previo a la firma del presente contrato, se le inform&oacute; el <strong>Costo Anual Total (CAT),</strong> informaci&oacute;n proporcionada &ldquo;para fines informativos y de comparaci&oacute;n exclusivamente&rdquo;, as&iacute; como las caracter&iacute;sticas generales del cr&eacute;dito, datos que, entre otros, son el tipo de cr&eacute;dito, monto del cr&eacute;dito, tasas, periodicidad de su c&aacute;lculo, comisiones o gastos que se generar&aacute;n por su celebraci&oacute;n.<br />
			VI.- Declara <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> que son ciertos los datos proporcionados para la elaboraci&oacute;n del presente contrato, as&iacute; como que son aut&eacute;nticos los documentos que entregaron a<strong> &ldquo;LA PARTE ACREDITANTE&rdquo;</strong> para la obtenci&oacute;n del cr&eacute;dito solicitado.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:494px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:482px"><span style="font-size:10px"><strong>DECLARACIONES COMUNES. -</strong><br />
			<strong>I.-</strong> Que <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong>, ha entregado a <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> los documentos que se anexan al presente contrato: Car&aacute;tula marcada como Anexo 1 la cual forma parte integral del presente contrato, pagar&eacute; marcado como Anexo 2, autorizaci&oacute;n para consultar el buro de cr&eacute;dito marcada como Anexo 3, tabla de amortizaci&oacute;n marcada como Anexo 4.<br />
			Manifiestan las partes, bajo protesta de decir verdad que todas y cada una de las declaraciones que anteceden se encuentran apegadas a la realidad por lo que asumen cualquier tipo de responsabilidad por falsedad de declaraciones, datos, e informaci&oacute;n en que incurran por declarar falsamente.<br />
			Expuesto lo anterior, las partes est&aacute;n de acuerdo en otorgar las siguientes:</span></td>
		</tr>
	</tbody>
</table>

<table border="0" cellpadding="0" cellspacing="1" style="width:496px">
	<tbody>
		<tr>
			<td style="text-align:center; width:488px"><span style="font-size:11px"><strong>CL&Aacute;USULAS</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="width:496px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:486px"><span style="font-size:10px"><strong>PRIMERA. - APERTURA. - &ldquo;LA PARTE ACREDITANTE&rdquo;</strong> representada en este acto por el Lic. Abelardo Sebasti&aacute;n Romero Ruano, en su car&aacute;cter de representante legal de dicha Sociedad; OTORGA a favor de &ldquo;LA PARTE ACREDITADA&rdquo; una apertura de Cr&eacute;dito personal, hasta por el equivalente a 15 d&iacute;as de su ingreso neto, monto renovable al momento de la liquidaci&oacute;n del cr&eacute;dito anterior, durante el transcurso de un a&ntilde;o calendario. Dentro del l&iacute;mite del cr&eacute;dito no se encuentran comprendidos los Intereses, Comisiones y Gastos que deba cubrir &ldquo;LA PARTE ACREDITADA&rdquo; en virtud de este Instrumento.</span></td>
		</tr>
	</tbody>
</table>

<table>
	<tbody>
		<tr>
			<td><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="height:29px; width:501px">
	<tbody>
		<tr>
			<td style="text-align:right; width:491px"><strong><span style="font-size:11px">RECA: 2850-439-038474/01-01140-0523</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:502px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:492px"><span style="font-size:10px"><strong>SEGUNDA. -<u>DISPOSICI&Oacute;N</u>. - &ldquo;LA PARTE ACREDITANTE&rdquo; </strong>se obliga a poner a disposici&oacute;n de <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> la cantidad a la que asciende el cr&eacute;dito otorgado, mediante transferencia electr&oacute;nica a la cuenta que proporcione <strong>&ldquo;LA PARTE ACREDITADA</strong>&rdquo;.<br />
			<strong>TERCERA. </strong>- <u><strong>DOCUMENTACI&Oacute;N</strong></u>. - La disposici&oacute;n del cr&eacute;dito quedar&aacute; documentada con el pagar&eacute; que suscribir&aacute; &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; a la orden de <strong>&ldquo;LA PARTE ACREDITANTE</strong>&rdquo;, por un plazo que no exceder&aacute; en ning&uacute;n caso al de la duraci&oacute;n de este contrato. Se anexa al presente contrato (anexo 2).</span></td>
		</tr>
	</tbody>
</table>

<table style="width:503px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:493px"><span style="font-size:10px"><strong>CUARTA. - <u>TASAS DE INTER&Eacute;S. </u></strong>- <strong>&ldquo;LA PARTE ACREDITADA</strong>&rdquo; se obliga a pagar a <strong>&ldquo;LA PARTE ACREDITANTE</strong>&rdquo;:<br />
			<strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; A) </strong>INTERESES ORDINARIOS. - Ambas partes convienen en que el capital dado en cr&eacute;dito causar&aacute; un inter&eacute;s ordinario a una tasa del <strong>0% (CERO POR CIENTO)</strong> anual fija sobre saldos insolutos calculados de la siguiente manera: Se multiplica capital por la tasa de inter&eacute;s anual, dividiendo entre 360 trescientos sesenta d&iacute;as multiplicando el resultado as&iacute; obtenido por el n&uacute;mero de d&iacute;as efectivamente transcurridos durante cada per&iacute;odo en el cual se devenguen los intereses a la tasa aplicable. &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; se obliga a pagar a &ldquo;<strong>LA PARTE ACREDITANTE&rdquo;</strong>, de forma mensual los intereses ordinarios sobre la suma principal insoluta del Cr&eacute;dito. El monto de los intereses generados causar&aacute; el Impuesto al Valor Agregado, &eacute;ste deber&aacute; ser cubierto junto con el pago de dichos intereses. Queda expresamente entendido y reconocido por las partes de este contrato que la estructura de generaci&oacute;n y pago de intereses pactada en este contrato no implica un pago anticipado de intereses en forma alguna.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:505px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:495px"><span style="font-size:10px"><strong>&nbsp; &nbsp; &nbsp; &nbsp;B)</strong> INTERESES MORATORIOS. - &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; se obliga a pagar a &ldquo;<strong>LA PARTE ACREDITANTE</strong>&rdquo; intereses moratorios sobre los saldos vencidos a partir del incumplimiento y hasta el d&iacute;a de pago, a raz&oacute;n de la tasa resultante de multiplicar 2 (Dos) veces la tasa de inter&eacute;s ordinaria. El monto de los intereses que resulten de conformidad a lo establecido en el presente inciso causar&aacute; el Impuesto al Valor Agregado (I.V.A.).</span></td>
		</tr>
	</tbody>
</table>

<table style="width:507px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:497px"><span style="font-size:10px"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;C)</strong> M&Eacute;TODO DE C&Aacute;LCULO DE INTERESES. - Los intereses, tanto ordinarios como moratorios, se calcular&aacute;n dividiendo la tasa anual de inter&eacute;s aplicable entre trescientos sesenta y multiplicando el resultado as&iacute; obtenido por el n&uacute;mero de d&iacute;as efectivamente transcurridos durante cada per&iacute;odo en el cual se devenguen los intereses a la tasa aplicable. Los c&aacute;lculos se efectuar&aacute;n cerr&aacute;ndose a cent&eacute;simas. Se entender&aacute;n como d&iacute;as efectivamente transcurridos los que se cuenten como un d&iacute;a, de la fecha del inicio del c&aacute;lculo al cierre de cada periodo pactado.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:511px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:501px"><span style="font-size:10px"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; D)</strong> COBRO DE INTERESES. - El pago de los intereses no podr&aacute; ser exigido por adelantado, sino &uacute;nicamente por periodos vencidos, por lo que los intereses generados se cobrar&aacute;n &uacute;nica y exclusivamente al final de cada periodo de pago establecido</span>.</td>
		</tr>
	</tbody>
</table>

<table style="width:513px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:503px"><span style="font-size:10px"><strong>QUINTA. - <u>COMISIONES.</u></strong> - Las partes convienen que &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; pagar&aacute; a &ldquo;<strong>LA PARTE ACREDITANTE</strong>&rdquo; en su caso la(s) comisione(s) de acuerdo con lo siguiente:<br />
			COMISI&Oacute;N POR APERTURA. - &ldquo;LA PARTE ACREDITADA&rdquo;, pagar&aacute; a &ldquo;LA PARTE ACREDITANTE&rdquo; por concepto de Apertura, una comisi&oacute;n del <strong>13% (TRECE POR CIENTO</strong>), que se calcular&aacute; sobre el importe del Cr&eacute;dito otorgado. Dicha comisi&oacute;n, ser&aacute; requerida de pago por &ldquo;<strong>LA PARTE ACREDITANTE</strong>&rdquo;, al momento que <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> firme el presente contrato.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:514px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:504px"><span style="font-size:10px"><strong>SEXTA. &ndash; <u>PAGO. </u></strong>- La fecha l&iacute;mite de pago peri&oacute;dico ser&aacute; la establecida en la Tabla de Amortizaci&oacute;n (anexo 4) que podr&aacute; consultar &ldquo;LA PARTE ACREDITADA&rdquo; en el formato anexo al presente contrato, y cuando la fecha de pago caiga en d&iacute;a inh&aacute;bil est&aacute; se recorrer&aacute; al d&iacute;a siguiente h&aacute;bil sin que proceda comisi&oacute;n alguna o pago de intereses moratorios. &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; deber&aacute; efectuar el Pago Total o los Pagos Parciales (seg&uacute;n sea el caso), por conducto del PATR&Oacute;N mediante el descuento y la entrega, conforme al Contrato/Convenio de Colaboraci&oacute;n y al Mandato; y bajo los t&eacute;rminos que establece el Contrato. &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; estar&aacute; obligada a comprobar, en cualquier momento, a &ldquo;LA PARTE ACREDITANTE&rdquo; el descuento y la entrega por lo que deber&aacute; conservar los recibos de n&oacute;mina que registren el descuento.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:515px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:505px"><span style="font-size:10px"><strong>S&Eacute;PTIMA. -<u>COSTO ANUAL TOTAL O &ldquo;CAT&rdquo;</u></strong>. - Se entender&aacute; por &ldquo;CAT&rdquo; El Costo Anual Total de financiamiento expresado en t&eacute;rminos porcentuales anuales que, para fines informativos y de comparaci&oacute;n, incorpora la totalidad de los costos y gastos inherentes a los cr&eacute;ditos que otorgan las Instituciones, el cual deber&aacute; ser calculado de acuerdo con los componentes y metodolog&iacute;a previstos en las circulares correspondientes de Banco de M&eacute;xico, y sus modificaciones si las hubiere. En cumplimiento a lo anterior se da a conocer el &ldquo;<strong>CAT</strong>&rdquo; (Costo Anual Total) de este financiamiento &ldquo;para fines informativos y de comparaci&oacute;n exclusivamente&rdquo;, el cual, en t&eacute;rminos de lo establecido en este contrato, ser&aacute; del _____% (______ por ciento).</span></td>
		</tr>
	</tbody>
</table>

<table style="width:516px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:506px"><span style="font-size:10px"><strong>OCTAVA. - <u>PAGO DE CAPITAL.</u> </strong>- <strong>&ldquo;LA PARTE ACREDITADA</strong>&rdquo; se obliga a pagar a &ldquo;<strong>LA PARTE ACREDITANTE</strong>&rdquo; la suma dispuesta del cr&eacute;dito, capital y sus respectivos intereses ordinarios, moratorios y accesorios, mediante pagos peri&oacute;dicos que cubrir&aacute;n cada una de las Amortizaciones establecidas en la tabla de amortizaci&oacute;n (Anexo 4), pero dichas amortizaciones se cubrir&aacute;n por &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo;, en el siguiente orden:<br />
			<strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;A)</strong>. - Comisiones<br />
			<strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;B)</strong>. - Intereses Moratorios.<br />
			<strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;C).</strong> - Intereses Ordinarios</span><br />
			<span style="font-size:10px"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;D).</strong> - Capital.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:518px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:508px"><span style="font-size:10px"><strong>&ldquo;LA PARTE ACREDITANTE</strong>&rdquo; al momento de firmar el presente contrato, y cada vez que se efectu&eacute; un pago anticipado, recibir&aacute; de &ldquo;<strong>LA PARTE ACREDITANTE</strong>&rdquo; una tabla de amortizaci&oacute;n actualizada, ya sea f&iacute;sicamente poniendo a disposici&oacute;n de <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> o por medio del correo electr&oacute;nico que <strong>&ldquo;LA PARTE ACREDITADA</strong>&rdquo; proporcione.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:520px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:510px"><span style="font-size:10px"><strong>NOVENA. - <u>PAGOS ANTICIPADOS</u>. </strong>- &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; podr&aacute; anticipar pagos de amortizaciones, sin pena ni castigo, siempre y cuando se encuentren al corriente en los pagos exigibles de conformidad con el presente contrato y el importe del pago anticipado sea por una cantidad igual o mayor al pago que deba realizar &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; en el periodo correspondiente, el pago total o parcial de la suma principal insoluta del cr&eacute;dito y de sus intereses.</span></td>
		</tr>
	</tbody>
</table>

<table>
	<tbody>
		<tr>
			<td><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="width:516.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:506px"><span style="font-size:11px"><strong>RECA: 2850-439-038474/01-01140-0523</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="width:518.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:508px"><span style="font-size:10px">En el caso de que <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> quiera liquidar el saldo total, podr&aacute; solicitar al correo electr&oacute;nico de<strong> &ldquo;LA PARTE ACREDITANTE&rdquo;</strong> el saldo insoluto a pagar, una vez recibida la solicitud de informaci&oacute;n del saldo a liquidar, &ldquo;<strong>LA PARTE ACREDITANTE&rdquo;</strong> deber&aacute; informarle a <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> a m&aacute;s tardar el d&iacute;a h&aacute;bil siguiente el saldo insoluto por el medio solicitado y ponerlo a su disposici&oacute;n dentro de los 5 (cinco) d&iacute;as h&aacute;biles siguientes en sus oficinas. De ser un pago total, dentro de 10 (diez) d&iacute;as h&aacute;biles posteriores al pago <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> enviar&aacute; por medio de correo electr&oacute;nico a <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> el comprobante de liquidaci&oacute;n del cr&eacute;dito y le har&aacute; llegar por el mismo medio el estado de cuenta donde se haga constar el fin de la relaci&oacute;n contractual y la inexistencia de adeudos derivados de la presente relaci&oacute;n contractual dentro de los 10 d&iacute;as h&aacute;biles posteriores a la fecha en que se haya realizado el pago total del adeudo.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:518.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:508px"><span style="font-size:10px">En los casos de anticipos parciales, los montos recibidos por <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> se aplicar&aacute;n, conforme la CL&Aacute;USULA OCTAVA, sin que esto exima a <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> de su obligaci&oacute;n de cubrir los pagos inmediatos siguientes en forma continua y consecutiva. En el caso de que <strong>&ldquo;LA PARTE ACREDITADA</strong>&rdquo; efect&uacute;en un pago anticipado, &ldquo;<strong>LA PARTE ACREDITANTE</strong>&rdquo; les entregar&aacute; un comprobante de dicho pago.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:520.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:510px"><span style="font-size:10px"><strong>D&Eacute;CIMA.- <u>CUMPLIMIENTO DE LAS OBLIGACIONES DE PAGO</u></strong>.- Todos los pagos que deban de efectuar <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> en favor de &ldquo;LA PARTE ACREDITANTE&rdquo; al amparo de este instrumento, tanto por el capital como por concepto de intereses y dem&aacute;s consecuencias legales, los har&aacute;n en las fechas correspondientes, en d&iacute;as y horas h&aacute;biles, sin necesidad de previo requerimiento, en las oficinas de <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> que se se&ntilde;alan en el presente contrato, o en el lugar que &eacute;ste le indique con posterioridad:</span></td>
		</tr>
	</tbody>
</table>

<table style="width:521.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:511px"><span style="font-size:10px"><strong>&nbsp; &nbsp; &nbsp; &nbsp;A).-</strong> LUGAR DE PAGO.- Todas las cantidades pagaderas por <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> a <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> de conformidad con el presente instrumento, ser&aacute;n pagadas en Pesos Mexicanos, en la fecha de su vencimiento, en el domicilio de &ldquo;LA PARTE ACREDITANTE&rdquo; ubicado en Av. Adolfo Ru&iacute;z Cortines Edif. Torre 2, PB, Mz. 1, Lt. 26, Oficina 118, Lomas de Atizap&aacute;n 2da Secc. Atizap&aacute;n de Zaragoza, Estado de M&eacute;xico, C.P. 52977, a la fecha del presente contrato, o en cualquier otro domicilio que indique por escrito <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> con la debida anticipaci&oacute;n, antes de las <strong>14:00 (catorce) </strong>horas, del d&iacute;a en que deba hacerse el pago correspondiente.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:522.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:512px"><span style="font-size:10px"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;B)</strong>.- MEDIOS DE PAGO.-<strong> &ldquo;LA PARTE ACREDITADA</strong>&rdquo; podr&aacute; efectuar los pagos en efectivo, cheques y &oacute;rdenes de transferencias de fondos por medios electr&oacute;nicos para el pago del principal, intereses, comisiones y gastos del cr&eacute;dito documentado bajo este instrumento, en el entendido de que: (i) los cheques podr&aacute;n ser librados por <strong>&ldquo;LA PARTE ACREDITADA&rdquo;,</strong> incluyendo aquellos que hayan sido expedidos a cargo de otra Instituci&oacute;n de Cr&eacute;dito, en el entendido de que se entender&aacute;n recibidos por <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> invariablemente &ldquo;salvo buen cobro&rdquo; y(ii) las &oacute;rdenes de transferencias de fondos por medios electr&oacute;nicos podr&aacute;n ser enviadas a solicitud de <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong>.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:524.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:514px"><span style="font-size:10px"><strong>D&Eacute;CIMA PRIMERA</strong>. - <strong><u>CESI&Oacute;N DE DEUDA</u>.</strong> - En ning&uacute;n caso se presumir&aacute; que <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> haya expresado su consentimiento en la sustituci&oacute;n de deudor alguno, por permitir que terceros ejecuten actos que deba ejecutar <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> como pago principal de, intereses, comisiones, pagos parciales o peri&oacute;dicos, a&uacute;n y cuando dichos terceros lo hagan en nombre propio y no por cuenta de <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> en t&eacute;rminos de las cl&aacute;usulas que anteceden.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:525.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:515px"><span style="font-size:10px"><strong>D&Eacute;CIMA SEGUNDA.<u>- FECHAS DE ACREDITAMIENTO.</u>-</strong> Cada pago deber&aacute; acreditarse de acuerdo al medio de pago que se utilice, de la manera siguiente: a) Efectivo: Se acreditar&aacute; el mismo d&iacute;a; b) Cheque: (i) A cargo de <strong>&ldquo;T&Oacute;TEM PR&Eacute;STAMOS</strong>&rdquo;, <strong>SOCIEDAD AN&Oacute;NIMA DE CAPITAL VARIABLE, SOCIEDAD FINANCIERA DE OBJETO M&Uacute;LTIPLE, ENTIDAD NO REGULADA</strong>, se acreditar&aacute; al d&iacute;a siguiente en que haya sido efectivamente abonado a la cuenta de &ldquo;LA PARTE ACREDITANTE&rdquo;; c) Domiciliaci&oacute;n: Se acreditar&aacute;: (i) En la fecha que se acuerde con el cliente, o (ii) en la fecha l&iacute;mite de pago del cr&eacute;dito; y d) Transferencias electr&oacute;nicas de Fondos: (i) A trav&eacute;s del Sistema de Pagos Electr&oacute;nicos Interbancarios (SPEI), se acreditar&aacute; el mismo d&iacute;a, (ii) Dentro de las oficinas de &ldquo;LA PARTE ACREDITANTE&rdquo; se acreditar&aacute; el mismo d&iacute;a. Lo anterior en el entendido de que, en todo caso, las cantidades correspondientes deber&aacute;n quedar perfecta y absolutamente liberadas y disponibles a satisfacci&oacute;n de <strong>&ldquo;LA PARTE ACREDITANTE</strong>&rdquo; a m&aacute;s tardar a<u><strong> las 14:00 (catorce) </strong></u>horas del d&iacute;a en que debe hacerse el pago correspondiente, pues de lo contrario, aquellos pagos que efectivamente se hayan acreditado fuera de dicho horario, se considerar&aacute;n hechos el d&iacute;a h&aacute;bil siguiente, con la consecuente generaci&oacute;n de intereses moratorios, en su caso.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:527.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:517px"><span style="font-size:10px"><strong>D&Eacute;CIMA TERCERA. - <u>VIGENCIA. </u>&ldquo;LA PARTE ACREDITADA</strong>&rdquo; se obliga a pagar a <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> el importe del cr&eacute;dito, sus intereses, accesorios y dem&aacute;s consecuencias a su cargo en un plazo ___________ contado a partir de la fecha de firma de este Instrumento. Sin embargo, este instrumento mantendr&aacute; su vigencia, respecto de las obligaciones a cargo de<strong> &ldquo;LA PARTE ACREDITADA&rdquo;</strong> hasta que &eacute;sta liquide totalmente las cantidades ya sean por capital, intereses o cualquier otro accesorio que resulten a su cargo derivadas de este contrato, el cual no ser&aacute; prorrogable.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:528.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:518px"><span style="font-size:10px"><strong>D&Eacute;CIMA CUARTA. - <u>CAUSAS DE VENCIMIENTO ANTICIPADO</u></strong>. Informando previamente a &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; con 5 d&iacute;as de anticipaci&oacute;n, <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> podr&aacute; dar por vencido anticipadamente el plazo estipulado en la Cl&aacute;usula D&Eacute;CIMA CUARTA del presente contrato y exigir el pago de la suerte principal del cr&eacute;dito junto con sus intereses ordinarios, intereses moratorios y las comisiones mencionadas en la Cl&aacute;usula QUINTA y dem&aacute;s cantidades que deban pagarse de acuerdo con los t&eacute;rminos de este contrato, en los siguientes casos de incumplimiento de &ldquo;<strong>LA PARTE ACREDITADA&rdquo;:</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="width:529.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:519px"><span style="font-size:10px"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; A).</strong> - Si &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; deja de cubrir puntualmente una o varias exhibiciones de capital, intereses, comisiones y primas de seguros, en su caso.<br />
			<strong>&nbsp; &nbsp; &nbsp; B).</strong> - Si &ldquo;<strong>LA PARTE ACREDITADA</strong>&rdquo; faltara al cumplimiento de cualquiera de sus obligaciones contra&iacute;das conforme a este contrato.<br />
			<strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;C). -</strong> Si se descubre falsedad, inexistencia, falta de autenticidad o legalidad de las declaraciones, informaciones y documentos que hubieren servido de base al otorgamiento del cr&eacute;dito.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:530.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:520px"><span style="font-size:10px"><strong>D&Eacute;CIMA QUINTA.- - <u>AVISOS Y NOTIFICACIONES</u></strong>. - Todos los avisos y notificaciones que las partes deban comunicarse una a otra, deber&aacute;n ser por escrito, por lo que, para los efectos del presente Contrato, las partes se&ntilde;alan como sus domicilios los siguientes</span>:</td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>

<table>
	<tbody>
		<tr>
			<td><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="width:520.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:510px"><strong><span style="font-size:11px">RECA: 2850-439-038474/01-01140-0523</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:520px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:449px"><span style="font-size:10px"><strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong>: Av. Adolfo Ru&iacute;z Cortines Edif. Torre 2, PB, Mz. 1, Lt. 26, Oficina 118, Lomas de Atizap&aacute;n 2da Secc. Atizap&aacute;n de Zaragoza, Estado de M&eacute;xico, C.P. 52977. <strong>&ldquo;LA PARTE ACREDITADA&rdquo;: ________________________________________________________________________________.</strong><br />
			Cualquier cambio de domicilio deber&aacute; ser comunicado a <strong>&quot;LA PARTE ACREDITANTE&quot;</strong> por escrito, mediante carta certificada con acuse de recibo dentro de los tres, d&iacute;as siguientes a la fecha en que tenga lugar dicho cambio.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:522.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:512px"><span style="font-size:10px"><strong>D&Eacute;CIMA SEXTA. -<u> MODIFICACIONES AL CONTRATO.</u></strong> -: El presente contrato podr&aacute; ser modificado por <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> cuando lo considere conveniente siempre y cuando notifique a <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> con 30 d&iacute;as naturales de anticipaci&oacute;n a la entrada en vigor de dichas modificaciones, mediante escrito, correo electr&oacute;nico &oacute; a trav&eacute;s del estado de cuenta. La notificaci&oacute;n en su caso realice<strong> &ldquo;LA PARTE ACREDITANTE&rdquo;</strong> deber&aacute; especificar de manera clara y notoria la fecha a partir de la cual las modificaciones comienzan a surtir efecto.<br />
			En caso de que <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> no se encuentre de acuerdo con las modificaciones realizadas por<strong> &ldquo;LA PARTE ACREDITANTE&rdquo;</strong>, podr&aacute; solicitar la terminaci&oacute;n anticipada del presente contrato dentro de los 30 d&iacute;as naturales posteriores a la notificaci&oacute;n a la cual hace referencia el p&aacute;rrafo inmediato anterior, sin responsabilidad ni comisi&oacute;n alguna a su cargo, debiendo cubrir, en su caso, todos y cada uno de los adeudos que se hubiesen generado a su cargo a la fecha de dar por terminado el presente instrumento.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:525.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:515px"><span style="font-size:10px"><strong>D&Eacute;CIMA SEPTIMA</strong>. -<strong> TERMINACI&Oacute;N ANTICIPADA DEL CONTRATO</strong>.- <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> podr&aacute; solicitar en todo momento la terminaci&oacute;n anticipada del contrato, de acuerdo a la vigencia mencionada en la cl&aacute;usula DECIMOCUARTA del presente contrato, debiendo cubrir en su caso y en los t&eacute;rminos pactados en el mismo, el monto total del adeudo, incluyendo todos los accesorios financieros que &eacute;ste hubiera generado a la fecha en que se solicite la terminaci&oacute;n, solicitando por escrito la terminaci&oacute;n anticipada y presentando el recibo de pago total del cr&eacute;dito en la oficina de<strong> &ldquo;LA PARTE ACREDITANTE&rdquo;</strong> o bien al correo electr&oacute;nico <u><span style="color:#0000ff">administracion@totemprestamos.mx</span></u><br />
			<strong>&ldquo;LA PARTE ACREDITATANTE&rdquo;</strong> una vez recibida la solicitud y el comprobante de pago le entregar&aacute; a <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> un acuse de recibo, un n&uacute;mero de folio de cancelaci&oacute;n y la constancia de liquidaci&oacute;n del cr&eacute;dito correspondiente.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:527.333px">
	<tbody>
		<tr>
			<td style="width:517px"><span style="font-size:10px"><strong>D&Eacute;CIMA OCTAVA</strong> .- <u><strong>CANCELACI&Oacute;N</strong></u>. <strong>&ldquo;LA PARTE ACREDITADA&rdquo; </strong>podr&aacute; cancelar sin ninguna responsabilidad o comisi&oacute;n alguna a su cargo, el cr&eacute;dito objeto del presente contrato dentro de los 10 d&iacute;as h&aacute;biles posteriores a la firma del presente contrato, siempre y cuando no haya utilizado o dispuesto del cr&eacute;dito. Para el tr&aacute;mite de cancelaci&oacute;n &ldquo;LA PARTE ACREDITADA&rdquo; deber&aacute; presentar solicitud por escrito en el domicilio de la sucursal de &ldquo;LA PARTE ACREDITANTE&rdquo; donde se haya aprobado el cr&eacute;dito.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:528.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:518px"><span style="font-size:10px"><strong>DECIMA NOVENA.</strong>- <strong><u>ESTADOS DE CUENTA</u></strong>. - &ldquo;<strong>LA PARTE ACREDITANTE</strong>&rdquo; enviar&aacute; al domicilio mencionado en la cl&aacute;usula DECIMASEXTA a <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> un estado de cuenta sin que esto cause ning&uacute;n costo adicional, con la finalidad de enterarse de manera oportuna de la informaci&oacute;n referente al cr&eacute;dito. Dicho estado de cuenta se enviar&aacute; dentro de los cinco d&iacute;as h&aacute;biles posteriores al &uacute;ltimo corte o pago del cr&eacute;dito correspondiente.<strong> &ldquo;LA PARTE ACREDITANTE&rdquo;</strong> tendr&aacute; un periodo de 90 d&iacute;as naturales para objetar el contenido del estado de cuenta, enviando un correo electr&oacute;nico explicando el motivo de la inconformidad o aclaraci&oacute;n al correo <u><span style="color:#0000ff">administracion@totemprestamos.mx</span></u>, donde le proporcionar&aacute;n respuesta a su aclaraci&oacute;n en un plazo no mayor a 15 d&iacute;as h&aacute;biles, por el mismo medio.<br />
			<strong>&ldquo;LA PARTE ACREDITANTE&rdquo; </strong>pone a disposici&oacute;n de <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> el env&iacute;o de dicho estado de cuenta a su correo electr&oacute;nico, si as&iacute; lo desea <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> puede solicitar se sustituya el env&iacute;o de su estado de cuenta f&iacute;sico por el env&iacute;o de un estado de cuenta digital, mencionando su correo electr&oacute;nico y aceptando dicha sustituci&oacute;n de env&iacute;o. Acepto me env&iacute;en mi estado de cuenta al correo electr&oacute;nico _________________________</span></td>
		</tr>
	</tbody>
</table>

<table style="width:530.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:520px"><span style="font-size:10px"><strong>VIG&Eacute;SIMA.</strong> - <strong><u>CENTRO DE ATENCI&Oacute;N DE &ldquo;LA PARTE ACREDITANTE&rdquo; Y DATOS DEL CENTRO DE ATENCI&Oacute;N DE LA COMISI&Oacute;N NACIONAL PARA LA PROTECCI&Oacute;N Y DEFENSA DE LOS USUARIOS DE SERVICIOS FINANCIEROS</u></strong>.- Para efectos del presente contrato <strong>&ldquo;LA PARTE ACREDITANTE&rdquo;</strong> da a conocer el n&uacute;mero telef&oacute;nico de la Unidad Especializada de Atenci&oacute;n a Usuarios y del Centro de Atenci&oacute;n de <strong>&ldquo;T&Oacute;TEM PR&Eacute;STAMOS&rdquo;</strong>, <strong>SOCIEDAD AN&Oacute;NIMA DE CAPITAL VARIABLE, SOCIEDAD FINANCIERA DE OBJETO M&Uacute;LTIPLE, ENTIDAD NO REGULADA,</strong> Con domicilio en Av. Adolfo Ru&iacute;z Cortines Edif. Torre 2, PB, Mz. 1, Lt. 26, Oficina 118, Lomas de Atizap&aacute;n 2da Secc. Atizap&aacute;n de Zaragoza, Estado de M&eacute;xico, C.P. 52977. Tel&eacute;fono: 5515 42 37 99. Correo electr&oacute;nico: <u><span style="color:#0000ff">administracion@totemprestamos.mx </span></u>con horario de atenci&oacute;n de<strong> lunes a viernes de 9:00 a 16:00 hrs.</strong> Las dudas y aclaraciones podr&aacute;n ser enviadas mediante correo electr&oacute;nico o por llamada telef&oacute;nica y ratificada por escrito acompa&ntilde;ado de los documentos de soporte correspondientes ante la unidad especializada. As&iacute; como tambi&eacute;n<strong> &ldquo;LA PARTE ACREDITADA&rdquo;</strong> podr&aacute; acudir directamente para presentar cualquier queja o reclamaci&oacute;n, as&iacute; como solicitar cualquier aclaraci&oacute;n respecto del producto y los servicios ofrecidos en el presente contrato, ante la<strong> Comisi&oacute;n Nacional para la Protecci&oacute;n y Defensa de los Usuarios de Servicios Financieros (CONDUSEF)</strong>, esto de conformidad con la Ley de Protecci&oacute;n y Defensa de los usuarios de Servicios Financieros <strong>a los tel&eacute;fonos 53400999 o a la LADA sin costo 01 800 999 8080,</strong> as&iacute; como a la direcci&oacute;n de Internet.<span style="color:#0000ff"> <u>www.condusef.gob.mx</u>. </span>O al correo electr&oacute;nico <span style="color:#0000ff"><u>asesoria@condusef.gob.mx.</u></span></span></td>
		</tr>
	</tbody>
</table>

<table style="width:530.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:520px"><span style="font-size:10px"><strong>VIG&Eacute;SIMA PRIMERA.</strong>- <strong><u>AUTORIZACI&Oacute;N PARA CONSULTAS EN SOCIEDADES DE INFORMACI&Oacute;N CREDITICIA</u></strong>.- <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> autoriza expresamente a &ldquo;LA PARTE ACREDITANTE&rdquo; para que solicite y obtengan de cualquier sociedad de informaci&oacute;n crediticia, informaci&oacute;n sobre las operaciones crediticias y otras de naturaleza an&aacute;loga en que haya intervenido; manifiesta su pleno conocimiento de la naturaleza y alcance de dicha informaci&oacute;n y consiente que &ldquo;<strong>LA PARTE ACREDITANTE&rdquo;</strong> podr&aacute; realizar consultas peri&oacute;dicas del historial crediticio de ellas durante el tiempo que<strong> &ldquo;LA PARTE ACREDITANTE&rdquo;</strong> mantenga relaci&oacute;n jur&iacute;dica con &eacute;stas. Esta Autorizaci&oacute;n tendr&aacute; vigencia durante la vida del presente contrato, plazo que comenzar&aacute; a transcurrir a partir de la fecha de la firma del presente contrato y permanecer&aacute; vigente mientras exista cualquier relaci&oacute;n jur&iacute;dica entre &ldquo;LA PARTE ACREDITANTE&rdquo; y &ldquo;LA PARTE ACREDITADA&rdquo;. Se adjunta al presente contrato la autorizaci&oacute;n para consultar el bur&oacute; de cr&eacute;dito como <strong>Anexo 3.</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="width:532.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:522px"><span style="font-size:10px"><strong>VIG&Eacute;SIMA SEGUNDA. - C&Aacute;RATULA DE CR&Eacute;DITO.</strong> &ndash; Con la finalidad de transparentar las condiciones y caracter&iacute;sticas del cr&eacute;dito otorgado a <strong>&ldquo;LA PARTE ACREDITADA&rdquo;</strong> se hace menci&oacute;n que la car&aacute;tula (anexo 1), forma parte integral del presente contrato de cr&eacute;dito.</span></td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>

<table>
	<tbody>
		<tr>
			<td><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="width:528.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:519px"><strong><span style="font-size:11px">RECA: 2850-439-038474/01-01140-0523</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:529.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:519px"><span style="font-size:10px"><strong>VIG&Eacute;SIMA TERCERA.- <u>LEY APLICABLE Y JURISDICCI&Oacute;N</u>.</strong> - El presente Contrato se regir&aacute; e interpretar&aacute; conforme a las leyes vigentes de M&eacute;xico. Son competentes los Tribunales de la Ciudad de M&eacute;xico. Para conocer de cualquier controversia que se suscitase con motivo de la interpretaci&oacute;n o ejecuci&oacute;n de este Contrato, a cuyo efecto las Partes renuncian al fuero de cualquier otro domicilio que pudiera corresponderles por cualquier causa.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:530.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:520.328px"><strong><span style="font-size:10px">ENTERADAS LAS PARTES DEL CONTENIDO Y FUERZA LEGAL DE LAS CL&Aacute;USULAS DEL PRESENTE CONTRATO DE CR&Eacute;DITO, LO FIRMAN DE CONFORMIDAD EN 5 HOJAS &Uacute;TILES Y EN DOS EJEMPLARES, EN LA CIUDAD DE M&Eacute;XICO. A LOS ___ D&Iacute;AS DEL MES DE ____DE 20__, QUEDANDO UN EJEMPLAR Y LOS ANEXOS RESPECTIVOS EN PODER DE &ldquo;LA PARTE ACREDITADA&rdquo;</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="height:27px; width:531px">
	<tbody>
		<tr>
			<td style="height:184.062px; text-align:center; width:256px"><span style="font-size:11px"><strong>LA PARTE ACREDITANTE</strong></span></td>
			<td style="height:184.062px; text-align:center; width:259px"><span style="font-size:11px"><strong>LA PARTE ACREDITADA</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="height:36px; width:531px">
	<tbody>
		<tr>
			<td style="text-align:center; width:258px">
			<p>_____________________________</p>

			<p><span style="font-size:8px"><strong>&ldquo;T&Oacute;TEM PR&Eacute;STAMOS&rdquo;, S.A. DE C.V.</strong></span></p>

			<p><span style="font-size:7px"><strong>(NOMBRE DEL ACREDITADO)</strong><br />
			<strong>SOCIEDAD FINANCIERA DE OBJETO M&Uacute;LTIPLE NO REGULADA</strong><br />
			<strong>REPRESENTADA POR ABELARDO SEBASTI&Aacute;N ROMERO RUANO</strong></span></p>
			</td>
			<td style="text-align:center; vertical-align:top; width:258px">
			<p>_____________________________</p>
			<span style="font-size:8px"><strong>(NOMBRE DEL ACREDITADO)</strong></span></td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>
"""
        : '';
    String anexo4 = nombrePerfilfile == ''
        ? """
<table style="height:69px; width:134px">
	<tbody>
		<tr>
			<td style="width:122px"><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="height:117px; width:345px">
	<tbody>
		<tr>
			<td style="height:18px; text-align:justify; width:196px"><span style="font-size:11px"><strong>&nbsp; &nbsp; &nbsp; &nbsp;</strong></span><span style="font-size:10px"><strong> &nbsp; SOLICITUD DE ADELANTO</strong></span></td>
		</tr>
		<tr>
			<td style="height:36px; width:196px"><span style="font-size:11px"><strong>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;</strong></span></td>
			<td style="height:36px; width:151px"><span style="font-size:10px"><strong>Fecha:${widget.fechaactualdocumentos} </strong></span></td>
		</tr>
		<tr>
			<td style="height:16.5625px; text-align:center; width:196px"><span style="font-size:10px"><strong>DATOS DE COLABORADOR</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="height:206px; width:445px">
	<tbody>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>No. De Empleado:${widget.noEmpleado}</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:464.5px"><span style="font-size:11px"><strong>Nombre completo:${widget.nombre} ${widget.apellidoPaterno} ${widget.apellidoMaterno}</strong></span></td>
			<td style="width:464.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Fecha de nacimiento:</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Nacionalidad:</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Ocupaci&oacute;n:</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Domicilio particular:${widget.direccionCp}</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>CURP:</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Genero:</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Entidad federativa de nacimiento:</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Pa&iacute;s de Nacimiento:</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>N&uacute;mero de tel&eacute;fono:${widget.telefono}</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Correo electr&oacute;nico:${widget.email}</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>RFC con homoclave:</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
		<tr>
			<td style="width:264.5px"><span style="font-size:11px"><strong>Sueldo Mensual:${widget.salario}</strong></span></td>
			<td style="width:264.5px">&nbsp;</td>
		</tr>
	</tbody>
</table>

<table style="height:139px; width:347px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:337px"><span style="font-size:11px">Solicito un pr&eacute;stamo de <strong>TOTEM PRESTAMOS SA DE CV SOFOM ENR</strong> por la cantidad de ____${widget.montoPrestamo}_____ Autorizo que me sea descontado el importe del pago correspondiente, aceptando que, si por alguna causa se omitiera el descuento, se haga el ajuste con los intereses moratorios a la fecha.</span></td>
		</tr>
	</tbody>
</table>

<table cellpadding="1" cellspacing="1" style="width:351px">
	<tbody>
		<tr>
			<td style="width:341px"><span style="font-size:10px"><strong>CUESTIONARIO</strong></span></td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:416px; width:348px">
	<tbody>
		<tr>
			<td style="width:336px"><strong><span style="font-size:10px">No. De dep&oacute;sitos esperados por mes:  ${widget.transacciones}_Monto ${widget.montotransacciones}<br />
			Tipo___Transferencia___ Naturaleza_____&nbsp;N&oacute;mina&nbsp;______<br />
			&iquest;Desempe&ntilde;a o ha desempe&ntilde;ado alg&uacute;n cargo p&uacute;blico nacional o extranjero en los &uacute;ltimos 5 a&ntilde;os?<br />
			SI ________ NO____X_____<br />
			Cargo___________NA__________ Periodo________NA_______<br />
			&iquest;Alg&uacute;n familiar que desempe&ntilde;e o haya desempe&ntilde;ado un cargo p&uacute;blico nacional o extranjero en los &uacute;ltimos 5 a&ntilde;os?<br />
			SI ________ NO___X____<br />
			Nombre____________NA________________ Parentesco________NA__________<br />
			Cargo______________NA____________ Periodo_______NA_________<br />
			Origen de los recursos: N&oacute;mina<br />
			Destino de los recursos__________Adquisici&oacute;n de bienes_________<br />
			Declaro bajo protesta de decir verdad que para la obtenci&oacute;n del cr&eacute;dito actu&oacute; a nombre y por cuenta:<br />
			Propia_____x______ Tercero__________________<br />
			En caso de actuar por cuenta de un tercero<br />
			Nombre_____________NA_________________ Parentesco__________NA_________</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:352px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:340px"><span style="font-size:9px"><strong>TOTEM PRESTAMOS SA DE CV SOFOM E.N.R le informa que los datos y la informaci&oacute;n solicitada por la presente solicitud de cr&eacute;dito a usted (es) o cualquier acto de renovaci&oacute;n de su contrato de cr&eacute;dito, son tratados con estricta confidencialidad por los encargados de cuidar, proteger y archivar sus datos personales en los t&eacute;rminos de la Ley Federal de Protecci&oacute;n de datos Personales en posesi&oacute;n de los particulares (LFPDPPP). Lo invitamos a leer el aviso de privacidad que est&aacute; en las oficinas de t&oacute;tem pr&eacute;stamos o en la p&aacute;gina de www.totemprestamos.com La informaci&oacute;n que se solicita es para poder determinar su solvencia y viabilidad financiera, solvencia moral as&iacute; como datos para poderlo (os) identificar y ubicarlo (s) con la finalidad del otorgamiento del cr&eacute;dito que usted (es) solicita (n).TOTEM PRESTAMOS SA DE CV SOFOM E.N.R. no transferir&aacute; sus datos personales, salvo en los siguientes casos y contando con su consentimiento: (i) a Sociedades de informaci&oacute;n crediticia, (ii) a autoridades que as&iacute; lo soliciten por la v&iacute;a judicial o bien en los casos a que se refiere la LFPDPPP, (iii) a la Comisi&oacute;n Nacional Bancaria y de Valores cuando as&iacute; lo solicite. Al firmar la presente solicitud de cr&eacute;dito al final autoriza expresamente a TOTEM PRESTAMOS SA DE CV SOFOM E.N.R, para hacer uso de la informaci&oacute;n suministrada en esta solicitud de cr&eacute;dito, documento que tiene car&aacute;cter confidencial.</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="height:36px; width:354px">
	<tbody>
		<tr>
			<td style="width:342px"><span style="font-size:10px"><strong>Nombre, Firma y Huella del Solicitante_____${widget.nombre} ${widget.apellidoPaterno} ${widget.apellidoMaterno}______</strong></span></td>
		</tr>
	</tbody>
</table>
 """
        : '';
    String anexo5 = """
<table style="width:101.333px">
	<tbody>
		<tr>
			<td style="width:91px"><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:528px"><strong><span style="font-size:10px">ANEXO 4</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:539.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:529px"><strong><span style="font-size:10px">RECA: 2850-439-038474/01-01140-0523</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:528px"><strong><span style="font-size:10px">TABLA DE AMORTIZACI&Oacute;N</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="width:528px">
			<p style="text-align:center"><strong><span style="font-size:10px">T&Oacute;TEM PR&Eacute;STAMOS, S.A. DE C.V. SOFOM, E.N.R.</span></strong></p>
			</td>
		</tr>
	</tbody>
</table>

<table>
	<tbody>
		<tr>
			<td>Nombre del acreditado</td>
		</tr>
	</tbody>
</table>

<table border="1" style="height:102px; width:539px style="font-size:8px"">
	<tbody>
		<tr>
			<td style="width:127.75px">Monto</td>
			<td style="width:127.75px">${widget.montoPrestamo}</td>
			<td style="width:127.75px">Fecha de entrega</td>
			<td style="width:127.75px">${widget.fechaactualdocumentos}</td>
		</tr>
		<tr>
			<td style="width:127.75px">Plazo</td>
			<td style="width:127.75px">1</td>
			<td style="width:127.75px">Fecha de pago</td>
			<td style="width:127.75px">${widget.fechaVencimiento}</td>
		</tr>
		<tr>
			<td style="width:127.75px">Periodicidad</td>
			<td style="width:127.75px">1</td>
			<td style="width:127.75px">Comisi&oacute;n</td>
			<td style="width:127.75px">${widget.comision}</td>
		</tr>
		<tr>
			<td style="width:127.75px">&nbsp;</td>
			<td style="width:127.75px">&nbsp;</td>
			<td style="width:127.75px">Pago</td>
			<td style="width:127.75px">${widget.totalPago}</td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>

<table border="1" style="height:175px; width:983px">
	<tbody>
		<tr>
			<td style="width:40.875px font-size:2px"><span style="font-size:9px">N&uacute;mero De Pago</span></td>
			<td style="width:40.875px"><span style="font-size:9px">Fecha de Pago</span></td>
			<td style="width:40.875px"><span style="font-size:9px">Importe de abono</span></td>
			<td style="width:40.875px"><span style="font-size:9px">Comisi&oacute;n</span></td>
			<td style="width:40.875px"><span style="font-size:9px">IVA</span></td>
			<td style="width:33px"><span style="font-size:9px">Total Amortizaci&oacute;n</span></td>
			<td style="width:154px"><span style="font-size:9px">Saldo Anterior</span></td>
			<td style="width:73px"><span style="font-size:9px">Saldo Actual</span></td>
		</tr>
		<tr>
			<td style="width:40.875px"><span style="font-size:9px">1</span></td>
			<td style="width:40.875px font-size:4px"><span style="font-size:9px">${widget.fechaVencimiento}</span></td>
			<td style="width:40.875px"><span style="font-size:9px">${widget.montoPrestamo}</span></td>
			<td style="width:40.875px"><span style="font-size:9px">${widget.comisionSinIva}</span></td>
			<td style="width:40.875px"><span style="font-size:9px">${widget.iva}</span></td>
			<td style="width:33px"><span style="font-size:9px">${widget.totalPago}</span></td>
			<td style="width:154px"><span style="font-size:9px">${widget.montoPrestamo}</span></td>
			<td style="width:73px"><span style="font-size:9px">${widget.totalPago}</td>
		</tr>
	</tbody>
</table>

<p>&nbsp;</p>

<table style="width:539px">
	<tbody>
		<tr>
			<td style="text-align:center; width:267px"><span style="font-size:10px">EL ACREDITANTE</span></td>
			<td style="text-align:center; width:258px"><span style="font-size:10px">EL ACREDITADO</span></td>
		</tr>
	</tbody>
	<tbody>
		<tr>
			<td style="text-align:center; width:273px">
			<p>_________________________________&nbsp;<br />
			<span style="font-size:9px"><strong>T&Oacute;TEM PR&Eacute;STAMOS&rdquo;, S.A. DE C.V. SOCIEDAD FINANCIERA DE OBJETO M&Uacute;LTIPLE NO REGULADA&nbsp;<br />
			REPRESENTADA POR EL<br />
			LIC. ABELARDO SEBASTIAN ROMERO RUANO</strong></span></p>
			</td>
			<td style="text-align:center; vertical-align:top; width:258px">
			<p>____________________</p>

			<p>&nbsp;<span style="font-size:9px">&nbsp;</span><span style="font-size:9px"><strong>${widget.nombre} ${widget.apellidoPaterno} ${widget.apellidoMaterno}</strong></span></p>
			</td>
		</tr>
	</tbody>
</table>


""";
    String anexo6 = nombreBurofile == ''
        ? """
<table style="width:101.333px">
	<tbody>
		<tr>
			<td style="width:91px"><img class="note-float-left" src="data:image/png;base64,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" style="float:left; height:105px; width:105px" /></td>
		</tr>
	</tbody>
<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:528px"><strong><span style="font-size:10px">ANEXO 3</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:539.333px">
	<tbody>
		<tr>
			<td style="text-align:right; width:529px"><strong><span style="font-size:10px">RECA: 2850-439-038474/01-01140-0523</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="text-align:center; width:528px"><strong><span style="font-size:10px">AUTORIZACI&Oacute;N PARA CONSULTAR SOCIEDADES DE INFORMACI&Oacute;N CREDITICIA</span></strong></td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="width:528px">
			<p style="text-align:justify"><span style="font-size:10px">Por este conducto autorizo expresamente a <strong>T&Oacute;TEM PR&Eacute;STAMOS S.A. DE C.V., SOFOM, E.N.R</strong>., para que por conducto de sus funcionarios facultados lleve a cabo investigaciones, sobre mi comportamiento crediticio o el de la Empresa que represento en <strong>Circulo de Cr&eacute;dito S.A. de C.V. SIC.</strong></span></p>
			</td>
		</tr>
	</tbody>
</table>

<table style="width:538.333px">
	<tbody>
		<tr>
			<td style="width:528px">
			<p style="text-align:justify"><span style="font-size:10px">Declaro que conozco la naturaleza y alcance de la informaci&oacute;n que se solicitar&aacute;, del uso que T&Oacute;TEM PR&Eacute;STAMOS S.A. DE C.V., SOFOM, E.N.R., har&aacute; de tal informaci&oacute;n y de que &eacute;sta podr&aacute; realizar consultas peri&oacute;dicas sobre mi historial o el de la empresa que represento, consintiendo que esta autorizaci&oacute;n se encuentre vigente por un per&iacute;odo de 3 a&ntilde;os contados a partir de su expedici&oacute;n y en todo caso durante el tiempo que se mantenga la relaci&oacute;n jur&iacute;dica.</span></p>
			</td>
		</tr>
	</tbody>
</table>

<table style="width:539.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:529px"><span style="font-size:10px">En caso de que la solicitante sea una Persona Moral, declaro bajo protesta de decir verdad Ser Representante Legal de la empresa mencionada en esta autorizaci&oacute;n; manifestando que a la fecha de firma de la presente autorizaci&oacute;n los poderes no me han sido revocados, limitados, ni modificados en forma alguna.</span></td>
		</tr>
	</tbody>
</table>

<table style="width:540.333px">
	<tbody>
		<tr>
			<td style="text-align:justify; width:530px"><span style="font-size:10px">Estoy consciente y acepto que este documento quede bajo custodia de <strong>T&Oacute;TEM PR&Eacute;STAMOS S.A. DE C.V., SOFOM, E.N.R</strong>. y/o Sociedad de Informaci&oacute;n Crediticia consultada para efectos de control y cumplimiento del art&iacute;culo 28 de la Ley para Regular las Sociedades de Informaci&oacute;n Crediticia; mismo que se&ntilde;ala que las Sociedades s&oacute;lo podr&aacute;n proporcionar informaci&oacute;n a un Usuario, cuando &eacute;ste cuente con la autorizaci&oacute;n expresa del Cliente mediante su firma aut&oacute;grafa.</span></td>
		</tr>
	</tbody>
</table>

<table>
	<tbody>
		<tr>
			<td><span style="font-size:10px"><strong>Autorizaci&oacute;n para:</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="height:21px; width:542.333px">
	<tbody>
		<tr>
			<td style="width:184.5px"><span style="font-size:10px"><strong>Persona F&iacute;sica (PF)___X____</strong></span></td>
			<td style="width:341px"><span style="font-size:10px"><strong>Persona Moral (PM) ________</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="width:545px">
	<tbody>
		<tr>
			<td style="width:402px"><span style="font-size:10px">Nombre del solicitante (Persona F&iacute;sica o Raz&oacute;n Social de la Persona Moral):____${widget.nombre} ${widget.apellidoPaterno} ${widget.apellidoMaterno}____</span></td>
		</tr>
	</tbody>
</table>

<table>
	<tbody>
		<tr>
			<td><span style="font-size:10px">Para el caso de Persona Moral, nombre del Representante Legal:</span></td>
		</tr>
	</tbody>
</table>

<table>
	<tbody>
		<tr>
			<td><span style="font-size:10px">NA</span></td>
		</tr>
	</tbody>
</table>

<table style="width:542.333px">
	<tbody>
		<tr>
			<td style="vertical-align:top; width:532px">____________________________________________________________</td>
		</tr>
	</tbody>
</table>

<table style="width:543.333px">
	<tbody>
		<tr>
			<td style="width:533px"><span style="font-size:10px">RFC de la persona f&iacute;sica o la persona moral ______________________________</span></td>
		</tr>
	</tbody>
</table>

<table style="width:228.333px">
	<tbody>
		<tr>
			<td style="width:218px"><span style="font-size:10px"><strong>Domicilio fiscal del solicitante</strong></span></td>
		</tr>
	</tbody>
</table>

<table style="height:5px; width:544.333px">
	<tbody>
		<tr>  ${widget.direccionExt}, , , , C.P. 
			<td style="width:186px"><span style="font-size:10px">Calle:____${widget.direccionCalle}____</span></td>
			<td style="width:192px"><span style="font-size:10px">Colonia:____${widget.direccionColonia}_____</span></td>
		</tr>
	</tbody>
</table>

<table style="height:13px; width:545.333px">
	<tbody>
		<tr>
			<td style="width:163.656px"><span style="font-size:10px">Municipio: __${widget.direccionMunicipio}____</span></td>
			<td style="width:163.656px"><span style="font-size:10px">Estado: ____${widget.estado}___</span></td>
			<td style="width:195px"><span style="font-size:10px">C&oacute;digo postal:__${widget.direccionCp}___</span></td>
		</tr>
	</tbody>
</table>

<table style="width:545.333px">
	<tbody>
		<tr>
			<td style="width:535px"><span style="font-size:10px">Tel&eacute;fono(s): ___________________________________________</span></td>
		</tr>
	</tbody>
</table>

<table style="width:546.333px">
	<tbody>
		<tr>
			<td style="width:536px"><span style="font-size:10px">Lugar y fecha en que se firma la autorizaci&oacute;n__${widget.fechaactualdocumentos}__</span></td>
		</tr>
	</tbody>
</table>

<table style="height:52px; width:547.333px">
	<tbody>
		<tr>
			<td style="width:537px">
			<p style="text-align:center"><span style="font-size:10px">_______________________________________</span></p>

			<p style="text-align:center"><span style="font-size:10px">Nombre y Firma de Persona F&iacute;sica, o Representante Legal de la empresa</span></p>
			</td>
		</tr>
	</tbody>
</table>

<table style="width:546.333px">
	<tbody>
		<tr>
			<td style="width:536px"><span style="font-size:10px">Para uso exclusivo de la Empresa que efect&uacute;a la consulta T&Oacute;TEM PR&Eacute;STAMOS S.A. DE C.V., SOFOM, E.N.R</span></td>
		</tr>
		<tr>
			<td style="width:536px"><span style="font-size:10px">Fecha de Consulta SIC: ___${widget.fechaactualdocumentos}__</span></td>
		</tr>
		<tr>
			<td style="width:536px"><span style="font-size:10px">Folio de Consulta SIC (PF);___________________</span></td>
		</tr>
	</tbody>
</table>
"""
        : '';
    return HtmlWidget(""" $anexo1 $anexo2 $anexo3 $anexo4 $anexo5 $anexo6 """);
  }
}

Future<void> iniciaload() async {
  await Future.delayed(const Duration(seconds: 10));
}
