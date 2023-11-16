import '../libs/lib.dart';

// Future<int> fetchData() async {
//   await Future.delayed(Duration(seconds: 2)); // Simulating fetching data
//   return 2; // Replace with the actual data
// }

// FutureBuilder<int> bottomNachBar(BuildContext context, int selectedIndex) {
//   return FutureBuilder<int>(
//     future: fetchData(),
//     builder: (context, snapshot) {
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return BottomNavigationBar(
//           showUnselectedLabels: true,
//           items: const <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_balance_wallet),
//               activeIcon: Icon(Icons.account_balance_wallet),

//               label: 'Historial',
//               // label: 'Home',
//               backgroundColor: Color.fromARGB(255, 209, 207, 207),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.star),
//               tooltip: 'Productos',
//               activeIcon:
//                   Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.star),
//               label: 'Productos',

//               //label: 'Business',

//               backgroundColor: Color.fromARGB(255, 209, 207, 207),
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               tooltip: 'Home',
//               activeIcon:
//                   Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.home),
//               label: 'Home',

//               backgroundColor: Color.fromARGB(255, 209, 207, 207),
//               // backgroundColor: Colors.purple,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               activeIcon: Icon(Icons.settings),
//               tooltip: 'Configura tu firma',
//               label: 'Configura tu firma',
//               backgroundColor: Color.fromARGB(255, 209, 207, 207),
//               // backgroundColor: Colors.pink,
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle_rounded),
//               activeIcon: Icon(Icons.account_circle_rounded),
//               tooltip: 'Cerrar sesión',
//               label: 'Cerrar sesión',
//               backgroundColor: Color.fromARGB(255, 209, 207, 207),

//               // backgroundColor: Colors.pink,
//             ),
//           ],
//           currentIndex: selectedIndex,
//           fixedColor: const Color.fromARGB(255, 5, 50, 91),
//           onTap: (int index) {
//             switch (index) {
//               case 0:
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'mis_adelantos', (route) => false);
//                 break;
//               case 1:
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'servicios', (route) => false);
//                 break;
//               case 2:
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'home', (route) => false);
//                 break;
//               case 3:
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'firma', (route) => false);
//                 break;
//               case 4:
//                 //   Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//                 showMenu<String>(
//                   context: context,
//                   position:
//                       const RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
//                   items: <PopupMenuItem<String>>[
//                     PopupMenuItem<String>(
//                         child: ElevatedButton(
//                       onPressed: () {
//                         SharedPreferencesHelper.borrashared();
//                         Navigator.pushNamedAndRemoveUntil(
//                             context, '/', (route) => false);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromARGB(255, 5, 50, 91)),
//                       child: const Text('Cerrar sesión'),
//                     )),
//                   ],
//                   elevation: 8.0,
//                 );
//                 break;
//             }
//           },
//         );
//       } else if (snapshot.hasError) {
//         return Text('Error: ${snapshot.error}');
//       } else if (snapshot.hasData) {
//         return BottomNavigationBar(
//           showUnselectedLabels: true,
//           items: <BottomNavigationBarItem>[
//             BottomNavigationBarItem(
//               activeIcon: Stack(
//                 children: [
//                   const Icon(Icons.notifications),
//                   Positioned(
//                     right: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 16,
//                         minHeight: 16,
//                       ),
//                       child: const Text(
//                         '1',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               icon: Stack(
//                 children: [
//                   const Icon(Icons.notifications),
//                   Positioned(
//                     right: 0,
//                     child: Container(
//                       padding: const EdgeInsets.all(2),
//                       decoration: BoxDecoration(
//                         color: Colors.red,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       constraints: const BoxConstraints(
//                         minWidth: 16,
//                         minHeight: 16,
//                       ),
//                       child: const Text(
//                         '1',
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 12,
//                         ),
//                         textAlign: TextAlign.center,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               label: 'Notificationes',
//               backgroundColor: const Color.fromARGB(255, 209, 207, 207),
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.star),
//               tooltip: 'Productos',
//               activeIcon:
//                   Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.star),
//               label: 'Productos',

//               //label: 'Business',

//               backgroundColor: Color.fromARGB(255, 209, 207, 207),
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.home),
//               tooltip: 'Home',
//               activeIcon:
//                   Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.home),
//               label: 'Home',

//               backgroundColor: Color.fromARGB(255, 209, 207, 207),
//               // backgroundColor: Colors.purple,
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.settings),
//               activeIcon: Icon(Icons.settings),
//               tooltip: 'Configura tu firma',
//               label: 'Configura tu firma',
//               backgroundColor: Color.fromARGB(255, 209, 207, 207),
//               // backgroundColor: Colors.pink,
//             ),
//             const BottomNavigationBarItem(
//               icon: Icon(Icons.account_circle_rounded),
//               activeIcon: Icon(Icons.account_circle_rounded),
//               tooltip: 'Cerrar sesión',
//               label: 'Cerrar sesión',
//               backgroundColor: Color.fromARGB(255, 209, 207, 207),

//               // backgroundColor: Colors.pink,
//             ),
//           ],
//           currentIndex: selectedIndex,
//           fixedColor: const Color.fromARGB(255, 5, 50, 91),
//           onTap: (int index) {
//             switch (index) {
//               case 0:
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'mis_adelantos', (route) => false);
//                 break;
//               case 1:
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'servicios', (route) => false);
//                 break;
//               case 2:
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'home', (route) => false);
//                 break;
//               case 3:
//                 Navigator.pushNamedAndRemoveUntil(
//                     context, 'firma', (route) => false);
//                 break;
//               case 4:
//                 //   Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//                 showMenu<String>(
//                   context: context,
//                   position:
//                       const RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
//                   items: <PopupMenuItem<String>>[
//                     PopupMenuItem<String>(
//                         child: ElevatedButton(
//                       onPressed: () {
//                         SharedPreferencesHelper.borrashared();
//                         Navigator.pushNamedAndRemoveUntil(
//                             context, '/', (route) => false);
//                       },
//                       style: ElevatedButton.styleFrom(
//                           backgroundColor:
//                               const Color.fromARGB(255, 5, 50, 91)),
//                       child: const Text('Cerrar sesión'),
//                     )),
//                   ],
//                   elevation: 8.0,
//                 );
//                 break;
//             }
//           },
//         );
//       } else {
//         return Text('No data available');
//       }
//     },
//   );
// }

BottomNavigationBar bottomNachBarfirma(context) {
  return BottomNavigationBar(
    showUnselectedLabels: true,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Text(''),

        label: '',
        // label: 'Home',
        backgroundColor: Color.fromARGB(255, 209, 207, 207),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.save),

        activeIcon: Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.save),
        label: 'Guardar',

        //label: 'Business',

        backgroundColor: Color.fromARGB(255, 209, 207, 207),
      ),
    ],
    currentIndex: 1,
    fixedColor: const Color.fromARGB(255, 5, 50, 91),
    onTap: (int index) {
      switch (index) {
        case 1:
          break;
      }
    },
  );
}

class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;

  const MyBottomNavigationBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final postMisMisNotificacionesProvider =
            ref.watch(postMisNotificacionesdetalleProviders);
        return postMisMisNotificacionesProvider.when(
          data: (data) {
            // Verifica si 'aval_prestamos' está presente en el mapa y es una lista
            final rows =
                (data['aval_prestamos'] as List?)?.cast<Map<String, dynamic>>();
            var count = rows?.length ?? 0;
            // print(count);
            return BottomNavigationBar(
              showUnselectedLabels: true,
              items: <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Stack(
                    children: [
                      const Icon(Icons.notifications),
                      count > 0
                          ? Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '$count',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : const Text(''),
                    ],
                  ),
                  icon: Stack(
                    children: [
                      const Icon(Icons.notifications),
                      count > 0
                          ? Positioned(
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                constraints: const BoxConstraints(
                                  minWidth: 16,
                                  minHeight: 16,
                                ),
                                child: Text(
                                  '$count',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            )
                          : const Text(''),
                    ],
                  ),
                  label: 'Notificationes',
                  backgroundColor: const Color.fromARGB(255, 209, 207, 207),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.star),
                  tooltip: 'Productos',
                  activeIcon:
                      Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.star),
                  label: 'Productos',

                  //label: 'Business',

                  backgroundColor: Color.fromARGB(255, 209, 207, 207),
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  tooltip: 'Home',
                  activeIcon:
                      Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.home),
                  label: 'Home',

                  backgroundColor: Color.fromARGB(255, 209, 207, 207),
                  // backgroundColor: Colors.purple,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  activeIcon: Icon(Icons.settings),
                  tooltip: 'Configura tu firma',
                  label: 'Configura tu firma',
                  backgroundColor: Color.fromARGB(255, 209, 207, 207),
                  // backgroundColor: Colors.pink,
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle_rounded),
                  activeIcon: Icon(Icons.account_circle_rounded),
                  tooltip: 'Cerrar sesión',
                  label: 'Cerrar sesión',
                  backgroundColor: Color.fromARGB(255, 209, 207, 207),

                  // backgroundColor: Colors.pink,
                ),
              ],
              currentIndex: selectedIndex,
              fixedColor: const Color.fromARGB(255, 5, 50, 91),
              onTap: (int index) {
                switch (index) {
                  case 0:
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'mis_adelantos', (route) => false);
                    break;
                  case 1:
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'servicios', (route) => false);
                    break;
                  case 2:
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'home', (route) => false);
                    break;
                  case 3:
                    Navigator.pushNamedAndRemoveUntil(
                        context, 'firma', (route) => false);
                    break;
                  case 4:
                    //   Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                    showMenu<String>(
                      context: context,
                      position:
                          const RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
                      items: <PopupMenuItem<String>>[
                        PopupMenuItem<String>(
                            child: ElevatedButton(
                          onPressed: () {
                            SharedPreferencesHelper.borrashared();
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false);
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  const Color.fromARGB(255, 5, 50, 91)),
                          child: const Text('Cerrar sesión'),
                        )),
                      ],
                      elevation: 8.0,
                    );
                    break;
                }
              },
            );
          },
          loading: () => Center(
              child: Padding(
            padding: const EdgeInsets.all(40.0),
            child: SizedBox(
              width: displayWidth(context) * 0.8,
              child: const Column(
                children: [
                  Cargando(),
                ],
              ),
            ),
          )),
          error: (error, stackTrace) {
            // Manejar el error de la solicitud
            return Center(child: Text('Error: $error'));
          },
        );
      },
    );
  }
}
