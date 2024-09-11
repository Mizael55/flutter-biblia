import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../share_preferences/preferences.dart';
import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late AdmobInterstitial interstitialAd;

  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-7568006196201830/3482519473",
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.loaded) {
          interstitialAd.show();
        } else if (event == AdmobAdEvent.closed) {
          // Añadir un retraso antes de cargar el siguiente anuncio
          Future.delayed(Duration(seconds: 60), () {
            interstitialAd.load();
          });
          // Actualizar el versículo del día
          Provider.of<BookProviders>(context, listen: false)
              .fetchVerseOfTheDay();
        }
      },
    );

    interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    final letterSize = Preferences.getSize;
    final verse = Provider.of<BookProviders>(context).verseOfTheDay;
    final theme = Provider.of<ThemeProvider>(context).currentTheme;

    if (verse.isEmpty) {
      Provider.of<BookProviders>(context).fetchVerseOfTheDay();
      return Scaffold(
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

    final data = verse[0]; // Solo renderiza el primer versículo

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
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text('Versículo del día',
            style: TextStyle(
                color: theme == ThemeData.dark() ? Colors.white : Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold)),
      ),
      drawer: const DrawerMenu(),
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
            child: Card(
              child: Column(
                children: [
                  ListTile(
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
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 300),
            child: AdmobBanner(
              adUnitId: "ca-app-pub-7568006196201830/2419923083",
              adSize: AdmobBannerSize.BANNER,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }

  // @override
  // void dispose() {
  //   interstitialAd.dispose();
  //   super.dispose();
  // }
}
