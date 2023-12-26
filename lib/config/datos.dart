//const String modo = "";
const String modo = "dev";
const String protocolossl = "https";
const String protocolodev = "http";
const String baseUrldev = "3.144.234.124";
const String baseUrl = "movil.nachservice.com.mx";
const String portRelease = ":80";
const String portDev = ":81";
const String completeUrldev = "$baseUrldev$portDev";
const String completeUrl = "$baseUrl$portRelease";
const String noInternet = 'Su conexión a internet es debil o inexistente';
const String endpointLogin = '/login';
const String endpointOperacion = '/operacion';
const String endpointSOperacion = '/guardar_adelanto';
const String endpointOperaciones = '/adelanto_nomina';
const String endpointFiles = '/descargar_archivo';
const String endpointDatosEmpleado = '/solicita_adelanto_nomina';
const String endpointactualiza = '/empleado_update';
const String endpointMisAadelantos = '/mis_adelantos';
const String endpointMisAadelantosFiles = '/mis_adelantos_files';
const String actualizamisarchivos = '/mis_adelantos_actualiza_files';
const String enviarfirma = '/guarda_firma';
const String enviarAprobacion = '/acepta_aval_prestamo';
const String endpointMisPrestamosFiles = '/mis_adelantos';
const String endpointMisservicios = '/mis_servicios';
const String endpointPeriodos = '/get_periodos';
const String endpointOperacionesRecibos = '/recibos_nomina';
const String endpointPeriodosRecibos = '/recibos_periodos';
const String endpointRecibosBase64 = '/descarga_recibo_nomina';
const String endpointMisNotificaciones = '/notifica_aval';
const String endpointcajaahorro = '/caja_ahorro';
const String endpointDatosCaja = '/solicita_caja_ahorro';
const String endpointPeriodosRecibosTransitorios =
    '/recibos_periodos_transitorios';

//PRESTAMOS NOMINA
const String prestamo = '/prestamo_nomina';
const String solicitaPrestamo = '/solicita_prestamo_nomina';
const String calculaPrestamo = '/calcula_prestamo';
const String confirmaPrestamo = '/guarda_prestamo';
const String solicitaPrestamoEdit = '/edita_prestamo_nomina';
const String muestraDocumentos = '/generar_archivos_prestamos';

//VACACIONES
const String operacionSolicitudVacaciones = '/solicitud_vacaciones';
const String solicitaVacaciones           = '/solicita_vacaciones';
const String confirmaVacaciones           = '/guarda_vacaciones';
const String confirmaRechazaVacaciones    = '/autoriza_rechaza_vacaciones';

//Mis solicitudes 
const String misSolicitudes               = '/solicitudes_app';
const String solicitudes                  = '/solicitudes';

//Detalles Notificaciones 
const String detallsNotificacion = '/solicitudes_detalle';

//Notificaciones Activas 

const String notificacionesActivas = '/notificaciones';


List<String> myList = ['Identificación (INE)', 'INE'];

Map<String, String> someMap = {};
