import 'package:biblia/share_preferences/preferences.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final letterSize = Preferences.size;
    final chapter = Provider.of<BooksNamesProvider>(context).chapterList;

    if (chapter.isEmpty) {
      return const Scaffold(
        body: Center(
            child: Column(
          children: [
            Text('Cargando...'),
            CircularProgressIndicator.adaptive(),
          ],
        )),
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
        title: Text('${chapter[0]['Book']}',
            style: const TextStyle(
                color: Colors.black,
                fontSize: 22.0,
                fontWeight: FontWeight.bold)),
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
                    style: TextStyle(
                      fontSize: letterSize,
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
                    style: TextStyle(
                      fontSize: letterSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${data['Text']}',
                      style: TextStyle(fontSize: letterSize),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
