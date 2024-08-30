import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../share_preferences/preferences.dart';
import '../widgets/widgets.dart';
import 'screens.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final letterSize = Preferences.getSize;
    final verse = Provider.of<BookProviders>(context).verseOfTheDay;
    if (verse.isEmpty) {
      Provider.of<BookProviders>(context).fetchVerseOfTheDay();
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Cargando...'),
              CircularProgressIndicator(backgroundColor: Colors.indigo),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: const Text(
          'Versículo del día',
          style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: verse.length,
        itemBuilder: (context, index) {
          final data = verse[index];
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
            child: Card(
              child: ListTile(
                contentPadding: const EdgeInsets.all(15.0),
                title: Row(
                  children: [
                    Text(
                      '${data['Book']}: ${data['Chapter']}',
                      style: TextStyle(
                        fontSize: letterSize,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () async {
                        await FlutterShare.share(
                          title: 'Versículo del día',
                          text:
                              '${data['Book']} ${data['Chapter']} ${data['Verse']} ${data['Text']}',
                        );
                      },
                      icon: const Icon(Icons.share),
                    ),
                  ],
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.all(8.0),
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
