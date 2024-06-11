import 'package:flutter/material.dart';

import '../screens/screens.dart';

class BottomNavigator extends StatefulWidget {
  const BottomNavigator({
    super.key,
  });

  @override
  State<BottomNavigator> createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {

  int _currentIndex = 0; // Agrega esta línea

  final _pages = [HomeScreen(), ByBookScreen()]; // Agrega las páginas aquí

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex], // Muestra la página correspondiente
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Cambia la página cuando se toca un ítem
          });
        },
        backgroundColor: Colors.indigo[100],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.black),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.black),
            label: 'Ajustes',
          ),
        ],
      ),
    );
  }
}
