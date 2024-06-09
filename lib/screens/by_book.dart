import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class ByBookScreen extends StatelessWidget {
  const ByBookScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final chapter = Provider.of<BooksNamesProvider>(context).byBook;

    if (chapter.isEmpty) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator.adaptive(),
        ),
      );
    }
    return Scaffold(
        appBar: AppBar(
          leading: Builder(
            builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.black),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                }),
          ),
          centerTitle: true,
          title: Text('${chapter[0]['Book']}'),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.music_note),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LiricsSongsScreen(
                              coro: true,
                            )));
              },
            ),
            // agrega otro icono tipo himnario a la derecha del appbar
            IconButton(
              icon: const Icon(Icons.book),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LiricsSongsScreen(
                              coro: false,
                            )));
              },
            ),
          ],
        ),
        drawer: const DrawerScreen(),
        body: ListView.builder(
          itemCount: chapter.length,
          itemBuilder: (context, index) {
            final data = chapter[index];
            return ListTile(
              title: data['Verse'] == 1
                  ? Text(
                      'Capitulo: ${data['Chapter']}',
                      style: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
              subtitle: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Alinea los widgets al inicio
                  children: <Widget>[
                    Text(
                      '${data['Verse']}  ',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Text(
                        '${data['Text']}',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ));
  }
}
