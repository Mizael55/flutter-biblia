import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../screens/himnos_screen.dart';
import '../screens/screens.dart';

class SelectedRoutes extends StatelessWidget {
  const SelectedRoutes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final index = Provider.of<ScreenRoute>(context).currentIndex;
    DBProvider.db.database;

    switch (index) {
      case 0:
        return const HomeScreen();
      case 1:
        return const BibleScreen();
      case 2:
        return CorosScreen();
      case 3:
        return HimnosScreen();
      case 4:
        return FavoriteScreen();
      case 5:
        return const SettingsScreen();
      default:
        return const HomeScreen();
    }
  }
}
