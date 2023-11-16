// app_routes.dart

import 'package:com.gruponach.nach_empleado/views/prestamos/solicita_prestamo.dart';

import '../config/vistas.dart';
import '../views/prestamos/prestamo_nomina.dart';

class AppRoutes {
  static const String inicio = '/';
  static const String home = 'home';
  static const String login = 'login';
  static const String otraPantalla = 'pantalla';
  static const String firma = 'firma';
  static const String servicios = 'servicios';
  static const String misAdelantos = 'mis_adelantos';
  static const String adelantoNomina = 'adelanto_nomina';
  static const String actualizaempleado = 'actualizaempleado';
  static const String vistaHtml = 'vista_html';
  static const String recibos = 'recibos';
  static const String valoresPedirAdelanto = 'valores_pedir_adelanto';
  static const String pdf = 'pdf';
  static const String reviewSignaturePage = 'reviewSignaturePage';
  static const String xml = 'xml';

  //Prestamos
  static const String prestamo         = 'prestamo';
  static const String solicitaPrestamo = 'solicita_prestamo';

  // Agrega la definición de initialRoute
  static const String initialRoute = inicio;

  // Agrega la definición de routes
  static final routes = {
    inicio: (context) => const InicioSplashScreen(),
    home: (context) => const HomeScreen(),
    login: (context) => const Login(),
    otraPantalla: (context) => const OtraPantalla(),
    firma: (context) => const Firma(),
    servicios: (context) => const ServiciosScreen(),
    misAdelantos: (context) => const MisAdelantos(),
    adelantoNomina: (context) => const AdelantoScreen(),
    actualizaempleado: (context) => const ActualizaEmpleadoScreen(),
    vistaHtml: (context) => const HTMLtoWidget(),
    recibos: (context) => const ReciboNominaScreen(),
    valoresPedirAdelanto: (context) => const ValoresPedirAdelantoScreen(),
    pdf: (context) => const PdfViewerPage(),
    reviewSignaturePage: (context) => const ReviewSignaturePage(),
    xml: (context) => const XmlDownloadPage(),

    // Prestamos
    prestamo:         (context) => const Prestamo(),
    solicitaPrestamo: (context) => const SolicitaPrestamo(),
  };
}
