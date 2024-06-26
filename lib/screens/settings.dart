import 'package:biblia/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   final size = Provider.of<LetterSize>(context).getSize;
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Configuración',
            style: TextStyle(
                color: theme == ThemeData.dark() ? Colors.white : Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 15, bottom: 15),
            child: Row(
              children: [
                Text('Versión',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: Text('Reina Valera 1960',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Temas',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
               Switch.adaptive(
                activeColor: Colors.indigo,
                value: Preferences.darkMode,
                onChanged: (value) {
                  if (value) {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setDarkMode();
                    Preferences.darkMode = true;
                  } else {
                    Provider.of<ThemeProvider>(context, listen: false)
                        .setLightMode();
                    Preferences.darkMode = false;
                  }
                },
               ),
                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
            child: Row(
              children: [
                Text('Idiomas',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                // TextButton(onPressed: () {}, child: Text('English')),
                Padding(
                  padding: const EdgeInsets.only(left: 60),
                  child: TextButton(onPressed: () {}, child: Text('Español')),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30,
              right: 30,
            ),
            child: Text('Tamaño de la fuente',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Slider.adaptive(
              value: size,
              min: 10,
              max: 30,
              onChanged: (double value) {
                Provider.of<LetterSize>(context, listen: false).setSize(value);
                Preferences.size = value;
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
