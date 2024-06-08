import 'package:biblia/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';
import 'books_names_chapter_number.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                        onTap: () {
                          Provider.of<BooksNamesProvider>(context,
                                  listen: false)
                              .setCap(gridIndex + 1);
                          Provider.of<BooksNamesProvider>(context,
                                  listen: false)
                              .fetchSpecificChapter(
                            booksNames[index]['names'].toString(),
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
