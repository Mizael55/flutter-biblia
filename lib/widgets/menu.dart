import 'package:biblia/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booksNames = [
  {
    'names': 'Génesis',
    'chapters': 50,
  },
  {
    'names': 'Éxodo',
    'chapters': 40,
  },
  {
    'names': 'Levítico',
    'chapters': 27,
  },
  {
    'names': 'Números',
    'chapters': 36,
  },
  {
    'names': 'Deuteronomio',
    'chapters': 34,
  },
  {
    'names': 'Josué',
    'chapters': 24,
  },
  {
    'names': 'Jueces',
    'chapters': 21,
  },
  {
    'names': 'Rut',
    'chapters': 4,
  },
  {
    'names': '1 Samuel',
    'chapters': 31,
  },
  {
    'names': '2 Samuel',
    'chapters': 24,
  },
  {
    'names': '1 Reyes',
    'chapters': 22,
  },
  {
    'names': '2 Reyes',
    'chapters': 25,
  },
  {
    'names': '1 Crónicas',
    'chapters': 29,
  },
  {
    'names': '2 Crónicas',
    'chapters': 36,
  },
  {
    'names': 'Esdras',
    'chapters': 10,
  },
  {
    'names': 'Nehemías',
    'chapters': 13,
  },
  {
    'names': 'Ester',
    'chapters': 10,
  },
  {
    'names': 'Job',
    'chapters': 42,
  },
  {
    'names': 'Salmos',
    'chapters': 150,
  },
  {
    'names': 'Proverbios',
    'chapters': 31,
  },
  {
    'names': 'Eclesiastés',
    'chapters': 12,
  },
  {
    'names': 'Cantares',
    'chapters': 8,
  },
  {
    'names': 'Isaías',
    'chapters': 66,
  },
  {
    'names': 'Jeremías',
    'chapters': 52,
  },
  {
    'names': 'Lamentaciones',
    'chapters': 5,
  },
  {
    'names': 'Ezequiel',
    'chapters': 48,
  },
  {
    'names': 'Daniel',
    'chapters': 12,
  },
  {
    'names': 'Oseas',
    'chapters': 14,
  },
  {
    'names': 'Joel',
    'chapters': 3,
  },
  {
    'names': 'Amós',
    'chapters': 9,
  },
  {
    'names': 'Abdías',
    'chapters': 1,
  },
  {
    'names': 'Jonás',
    'chapters': 4,
  },
  {
    'names': 'Miqueas',
    'chapters': 7,
  },
  {
    'names': 'Nahúm',
    'chapters': 3,
  },
  {
    'names': 'Habacuc',
    'chapters': 3,
  },
  {
    'names': 'Sofonías',
    'chapters': 3,
  },
  {
    'names': 'Hageo',
    'chapters': 2,
  },
  {
    'names': 'Zacarías',
    'chapters': 14,
  },
  {
    'names': 'Malaquías',
    'chapters': 4,
  },
  {
    'names': 'Mateo',
    'chapters': 28,
  },
  {
    'names': 'Marcos',
    'chapters': 16,
  },
  {
    'names': 'Lucas',
    'chapters': 24,
  },
  {
    'names': 'Juan',
    'chapters': 21,
  },
  {
    'names': 'Hechos',
    'chapters': 28,
  },
  {
    'names': 'Romanos',
    'chapters': 16,
  },
  {
    'names': '1 Corintios',
    'chapters': 16,
  },
  {
    'names': '2 Corintios',
    'chapters': 13,
  },
  {
    'names': 'Gálatas',
    'chapters': 6,
  },
  {
    'names': 'Efesios',
    'chapters': 6,
  },
  {
    'names': 'Filipenses',
    'chapters': 4,
  },
  {
    'names': 'Colosenses',
    'chapters': 4,
  },
  {
    'names': '1 Tesalonicenses',
    'chapters': 5,
  },
  {
    'names': '2 Tesalonicenses',
    'chapters': 3,
  },
  {
    'names': '1 Timoteo',
    'chapters': 6,
  },
  {
    'names': '2 Timoteo',
    'chapters': 4,
  },
  {
    'names': 'Tito',
    'chapters': 3,
  },
  {
    'names': 'Filemón',
    'chapters': 1,
  },
  {
    'names': 'Hebreos',
    'chapters': 13,
  },
  {
    'names': 'Santiago',
    'chapters': 5,
  },
  {
    'names': '1 Pedro',
    'chapters': 5,
  },
  {
    'names': '2 Pedro',
    'chapters': 3,
  },
  {
    'names': '1 Juan',
    'chapters': 5,
  },
  {
    'names': '2 Juan',
    'chapters': 1,
  },
  {
    'names': '3 Juan',
    'chapters': 1,
  },
  {
    'names': 'Judas',
    'chapters': 1,
  },
  {
    'names': 'Apocalipsis',
    'chapters': 22,
  },
];

    return Drawer(
        child: ListView.builder(
      itemCount: booksNames.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Column(
          children: <Widget>[
            ExpansionTile(
              title: Text(
                  '${booksNames[index]['names'].toString()} - ${booksNames[index]['chapters'].toString()}',
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold)),
              children: [
                if (booksNames[index]['chapters'] != null)
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: booksNames[index]['chapters'] as int,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                    ),
                    itemBuilder: (context, gridIndex) {
                      return GestureDetector(
                        onTap:(){
                          Provider.of<BooksNamesProvider>(context, listen: false).fetchSpecificChapter(
                            booksNames[index]['names'].toString(),
                            (gridIndex + 1),
                          );
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return const ByBookScreen();
                          }));
                        },
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Center(
                            child: Text(
                              '${gridIndex + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ],
        ));
      },
    ));
  }
}
