// main.dart

// import 'package:syncfusion_flutter_calendar/calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';

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
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        SfGlobalLocalizations.delegate
      ],
      // ignore: always_specify_types
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
      ],
      locale: const Locale('es'),
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
    // localizationsDelegates: [
    //     GlobalMaterialLocalizations.delegate,
    //     GlobalWidgetsLocalizations.delegate,
    //   ],
