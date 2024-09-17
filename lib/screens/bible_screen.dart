import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../share_preferences/preferences.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({Key? key}) : super(key: key);

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
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
      ),
      drawer: const DrawerScreen(),
      body: Stack(
        children: [
          ListView.builder(
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
                  padding: const EdgeInsets.only(left: 2.0, top: 25),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                        icon: const Icon(Icons.share,
                            color: Colors.indigo, size: 17.0),
                      ),
                      IconButton(
                        onPressed: favorite.favoriteList.any(
                                (element) => element['text'] == data['Text'])
                            ? null
                            : () {
                                final verse = {
                                  'idx': data['Index'],
                                  'testament': data['Testament'],
                                  'book': data['Book'],
                                  'boookNumber': data['BoookNumber'],
                                  'verse': data['Verse'],
                                  'chapter': data['Chapter'],
                                  'text': data['Text'],
                                  'title': data['Title']
                                };
                                favorite.setFavoriteList(verse);
                                Provider.of<ScreenRoute>(context, listen: false)
                                    .setIndex(4);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SelectedRoutes()));
                              },
                        icon: Icon(
                          Icons.favorite_rounded,
                          color: favorite.favoriteList.any(
                                  (element) => element['text'] == data['Text'])
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          Positioned(
            top: 10,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Provider.of<BookProviders>(context, listen: false).setCap(
                  chapter[0]['Chapter'] + 1,
                );
                Provider.of<BookProviders>(context, listen: false)
                    .fetchSpecificChapter(
                  chapter[0]['Book'],
                );
              },
              child: const Icon(Icons.arrow_forward_rounded),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                Provider.of<BookProviders>(context, listen: false).setCap(
                  chapter[0]['Chapter'] - 1,
                );
                Provider.of<BookProviders>(context, listen: false)
                    .fetchSpecificChapter(
                  chapter[0]['Book'],
                );
              },
              child: const Icon(Icons.arrow_back_rounded),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
