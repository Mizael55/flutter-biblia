import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../share_preferences/preferences.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({Key? key}) : super(key: key);

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  @override
  Widget build(BuildContext context) {
    final ScrollController _scrollController = ScrollController();

    final letterSize = Preferences.getSize;
    final chapter = Provider.of<BookProviders>(context).chapterList;
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_scrollController.position.minScrollExtent);
      }
    });

    if (chapter.isEmpty) {
      Provider.of<BookProviders>(context).getChapterList();
      return const Scaffold(
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Cargando...'),
            CircularProgressIndicator(backgroundColor: Colors.indigo),
          ],
        )),
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
              icon: Icon(
                Icons.menu,
                color: theme == ThemeData.dark() ? Colors.white : Colors.black,
              ),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              }),
        ),
        centerTitle: true,
        title: Text('${chapter[0]['Book']}',
            style: TextStyle(
                color: theme == ThemeData.dark() ? Colors.white : Colors.black,
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
        controller: _scrollController,
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
                  IconButton(
                    onPressed: () async {
                      await FlutterShare.share(
                        title: 'Versículo del día',
                        text:
                            '${data['Book']} ${data['Chapter']} ${data['Verse']} ${data['Text']}',
                      );
                    },
                    icon: const Icon(Icons.share, color: Colors.indigo, size: 17.0),
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
