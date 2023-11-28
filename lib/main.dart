// main.dart

import 'libs/lib.dart';
// Importa las rutas desde el archivo separado

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
        useMaterial3: false,
        primaryColor: const Color.fromARGB(255, 251, 251, 251),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute:
          AppRoutes.initialRoute, // Usa la ruta inicial desde AppRoutes
      routes: AppRoutes.routes, // Usa las rutas definidas en AppRoutes
    );
  }
}
