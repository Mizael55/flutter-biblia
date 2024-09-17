import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context);
    final index = Provider.of<ScreenRoute>(context).currentIndex;
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home,
              color: theme.currentTheme == ThemeData.dark()
                  ? Colors.white
                  : Colors.black),
          label: 'Inicio',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_book_rounded,
              color: theme.currentTheme == ThemeData.dark()
                  ? Colors.white
                  : Colors.black),
          label: 'Biblia',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.music_note,
              color: theme.currentTheme == ThemeData.dark()
                  ? Colors.white
                  : Colors.black),
          label: 'Coros',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_books,
              color: theme.currentTheme == ThemeData.dark()
                  ? Colors.white
                  : Colors.black),
          label: 'Himnos',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite,
              color: theme.currentTheme == ThemeData.dark()
                  ? Colors.white
                  : Colors.black),
          label: 'Favoritos',
        ),
        // BottomNavigationBarItem(
        //   icon: Icon(Icons.settings,
        //       color: theme.currentTheme == ThemeData.dark()
        //           ? Colors.white
        //           : Colors.black),
        //   label: 'Ajustes',
        // ),
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
