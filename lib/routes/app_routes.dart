// app_routes.dart

import 'package:com.gruponach.nach_empleado/views/adelanto/documentos_adelantos.dart';
import 'package:com.gruponach.nach_empleado/views/cajadeahorro/valorescaja.dart';
import 'package:com.gruponach.nach_empleado/views/prestamos/documentos.dart';

import '../config/vistas.dart';
import '../views/cajadeahorro/cajaoperacionscreen.dart';
import '../views/notificaciones/notificaciones.dart';
import '../views/prestamos/prestamo_nomina.dart';
import '../views/prestamos/solicita_prestamo.dart';
import '../views/vacaciones/vacaciones.dart';

class AppRoutes {
  static const String inicio = '/';
  // static const String home = 'home';
  static const String nuevohome = 'home';
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
  static const String solicitudes = 'solicitudes';
  static const String cajaopereciones = 'caja_ahorro';
  static const String cajavalores = 'cajavalores';
  static const String documentosadelanto = 'documentosadelanto';
  //Prestamos
  static const String prestamo = 'prestamo';
  static const String solicitaPrestamo = 'solicita_prestamo';
  static const String documentos = 'documentos';
  //Vacaciones
  static const String vacaciones = 'solicitud_vacaciones';
  static const String detallesNotificacion = 'detalles_notificacion';

  //Notificaciones
  static const String notificaciones = 'notificaciones';
  static const String solicitudesPendientes = 'solicitudesPendientes';

  // Servicios Activos
  static const String serviciosActivos = 'servicios_activos';

  // Agrega la definición de initialRoute
  static const String initialRoute = inicio;

  // Agrega la definición de routes
  static final routes = {
    inicio: (context) => const InicioSplashScreen(),
    // home: (context) => const HomeScreen(),
    nuevohome: (context) => const Home(),
    login: (context) => const Login(),
    otraPantalla: (context) => const OtraPantalla(),
    firma: (context) => const Firma(
          data: '0',
        ),
    servicios: (context) => const ServiciosScreen(),
    solicitudes: (context) => const SolicitudesScreen(),
    misAdelantos: (context) => const MisAdelantos(),
    adelantoNomina: (context) => const AdelantoScreen(),
    actualizaempleado: (context) => const ActualizaEmpleadoScreen(),
    vistaHtml: (context) => const HTMLtoWidget(),
    recibos: (context) => const ReciboNominaScreen(),
    valoresPedirAdelanto: (context) => const ValoresPedirAdelantoScreen(),
    pdf: (context) => const PdfViewerPage(),
    reviewSignaturePage: (context) => const ReviewSignaturePage(),
    xml: (context) => const XmlDownloadPage(),
    cajaopereciones: (context) => const CajaDeAhorroScreen(),
    cajavalores: (context) => const ValoresPedirCajaScreen(),
    documentosadelanto: (context) => const VerDocumentosAdelantos(
          data: 0,
          idoperacion: 0,
        ),

    // Prestamos
    prestamo: (context) => const Prestamo(),
    solicitaPrestamo: (context) => const SolicitaPrestamo(),
    documentos: (context) => const VerDocumentos(
          data: 0,
          idoperacion: 0,
        ),

    //Vacaciones
    vacaciones: (context) => const Vacaciones(),
    detallesNotificacion: (context) => const DetallesNotificaciones(),
    // pruebas: (context) =>  MyAppState(),

    // notificaciones
    notificaciones: (context) => const Notificaciones(),
    // notificaciones: (context) => VerNotificaciones(),
    solicitudesPendientes: (context) => const SolicitudesRealizadas(),

    //Servicios Activos
    serviciosActivos: (context) => const MisSolicitudes(),
  };
}
