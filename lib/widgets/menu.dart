import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import 'books_names_chapter_number.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isOldBook = Provider.of<BooksNamesProvider>(context).oldBooks;
    return Drawer(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      isOldBook ? Colors.indigo[200] : Colors.white),
                ),
                onPressed: () {
                  Provider.of<BooksNamesProvider>(context, listen: false)
                      .setOldBooks(true);
                },
                child: Text('Antiguo T',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
              TextButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      isOldBook ? Colors.white : Colors.indigo[200]),
                ),
                onPressed: () {
                  Provider.of<BooksNamesProvider>(context, listen: false)
                      .setOldBooks(false);
                },
                child: Text('Nuevo T',
                    style: TextStyle(
                        color: Colors.indigo,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(top: 1),
            itemCount: isOldBook ? booksNamesOld.length : bookNamesNew.length,
            itemBuilder: (context, index) {
              return ListTile(
                  title: Column(
                children: <Widget>[
                  ExpansionTile(
                    title: Text(
                        isOldBook
                            ? '${booksNamesOld[index]['names'].toString()} - ${booksNamesOld[index]['chapters'].toString()}'
                            : '${bookNamesNew[index]['names'].toString()} - ${bookNamesNew[index]['chapters'].toString()}',
                        style: const TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold)),
                    children: [
                      if (booksNamesOld[index]['chapters'] != null ||
                          bookNamesNew[index]['chapters'] != null)
                        GridView.builder(
                          padding: const EdgeInsets.all(1),
                          shrinkWrap: true,
                          itemCount: isOldBook
                              ? booksNamesOld[index]['chapters'] as int
                              : bookNamesNew[index]['chapters'] as int,
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
                                  isOldBook
                                      ? booksNamesOld[index]['names'].toString()
                                      : bookNamesNew[index]['names'].toString(),
                                );
                                Navigator.pop(context);
                              },
                              child: Container(
                                margin: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: Colors.indigo,
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
          ),
        ),
      ],
    ));
  }
}
