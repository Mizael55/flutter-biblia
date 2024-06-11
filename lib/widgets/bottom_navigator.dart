import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
     final index = Provider.of<ScreenRoute>(context).currentIndex;
    return  BottomNavigationBar(
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
        currentIndex: index,
        selectedItemColor: Colors.indigo,
        unselectedItemColor: Colors.black,
        unselectedFontSize: 12.0,
        selectedFontSize: 15.0,
        onTap: (int index) {
          Provider.of<ScreenRoute>(context, listen: false).setIndex(index);
        },
    );
  }
}
