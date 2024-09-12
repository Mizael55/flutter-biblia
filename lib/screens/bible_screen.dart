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
  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
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
              padding: const EdgeInsets.only(left: 2.0, top: 6),
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
                    onPressed: () {
                      favorite.setFavoriteList = [
                        ...favorite.favoriteList,
                        data
                      ];
                      Provider.of<ScreenRoute>(context, listen: false)
                          .setIndex(2);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SelectedRoutes()));
                    },
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: favorite.favoriteList.contains(data)
                          ? Colors.red
                          : Colors.indigo,
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
