import 'package:flutter/material.dart';

import '../helpers/guardarvars.dart';

BottomNavigationBar bottomNachBar(context, selectedIndex) {
  return BottomNavigationBar(
    showUnselectedLabels: true,
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.account_balance_wallet),
        activeIcon: Icon(Icons.account_balance_wallet),

        label: 'Historial',
        // label: 'Home',
        backgroundColor: Color.fromARGB(255, 209, 207, 207),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.star),
        tooltip: 'Productos',
        activeIcon: Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.star),
        label: 'Productos',

        //label: 'Business',

        backgroundColor: Color.fromARGB(255, 209, 207, 207),
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        tooltip: 'Home',
        activeIcon: Icon(color: Color.fromARGB(255, 5, 50, 91), Icons.home),
        label: 'Home',

        backgroundColor: Color.fromARGB(255, 209, 207, 207),
        // backgroundColor: Colors.purple,
      ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        activeIcon: Icon(Icons.settings),
        tooltip: 'Configura tu firma',
        label: 'Configura tu firma',
        backgroundColor: Color.fromARGB(255, 209, 207, 207),
        // backgroundColor: Colors.pink,
      ),
      BottomNavigationBarItem(
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
          Navigator.pushNamedAndRemoveUntil(context, 'home', (route) => false);
          break;
        case 3:
          Navigator.pushNamedAndRemoveUntil(context, 'firma', (route) => false);
          break;
        case 4:
          //   Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
          showMenu<String>(
            context: context,
            position: const RelativeRect.fromLTRB(1000.0, 1000.0, 0.0, 0.0),
            items: <PopupMenuItem<String>>[
              PopupMenuItem<String>(
                  child: ElevatedButton(
                onPressed: () {
                  SharedPreferencesHelper.borrashared();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false);
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 5, 50, 91)),
                child: const Text('Cerrar sesión'),
              )),
            ],
            elevation: 8.0,
          );
          break;
      }
    },
  );
}

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
