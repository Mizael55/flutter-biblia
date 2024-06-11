import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // remove back button
        automaticallyImplyLeading: false,
        title: Text('Configuración', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold)),
      ),
      // agrega en el body un widget para cambiar el tema, el idioma y el tamaño de la fuente
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Temas',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                IconButton(onPressed: () {}, icon: Icon(Icons.light_mode)),
                IconButton(onPressed: () {}, icon: Icon(Icons.dark_mode)),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Idiomas',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextButton(onPressed: () {}, child: Text('English')),
                TextButton(onPressed: () {}, child: Text('Español')),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30,),
            child: Text('Tamaño de la fuente',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10,),
            child: Slider(
              value: 20,
              min: 10,
              max: 30,
              divisions: 2,
              label: '20',
              onChanged: (double value) {},
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavigator(),
    );
  }
}
