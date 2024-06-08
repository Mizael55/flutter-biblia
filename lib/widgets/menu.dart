import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final booksNames = Provider.of<BooksNamesProvider>(context).booksNames;

    return Drawer(
        child: ListView.builder(
      itemCount: booksNames.length,
      itemBuilder: (context, index) {
        return ListTile(
            title: Column(
          children: <Widget>[
            ExpansionTile(
              title: Text(
                  '${booksNames[index].names[0]} - ${booksNames[index].chapters}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              children: [
                if (booksNames[index].chapters > 0)
                  GridView.builder(
                    shrinkWrap: true,
                    itemCount: booksNames[index].chapters,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6,
                    ),
                    itemBuilder: (context, gridIndex) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
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
