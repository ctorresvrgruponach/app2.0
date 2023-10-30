import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'config/datos.dart';
import 'config/vistas.dart';

// Importa las rutas

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'APP NACH',
      debugShowCheckedModeBanner: modo == 'dev' ? true : false,
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 7, 15, 168),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/', // Ruta inicial
      routes: {
        '/': (context) => const InicioSplashScreen(), // Página principal
        'home': (context) => const HomeScreen(),
        'login': (context) => const Login(), // Página principal
        'pantalla': (context) => const OtraPantalla(), // Otra pantalla
        'firma': (context) => const Firma(),
        'servicios': (context) => const ServiciosScreen(),
        'mis_adelantos': (context) => const MisAdelantos(),
        'adelanto_nomina': (context) => const AdelantoScreen(),
        'pedir_adelanto': (context) => const PedirAdelantoScreen(),
        'vista_html': (context) => const HTMLtoWidget(),
        'valores_pedir_adelanto': (context) => const ImagePickerApp(),
        'pdf': (context) => const PdfViewerPage(),
      },
    );
  }
}
