import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../share_preferences/preferences.dart';
import '../utils/utils.dart';
import '../widgets/widgets.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late AdmobInterstitial interstitialAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-7568006196201830/3482519473",
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.loaded) {
          if (!_isAdLoaded) {
            interstitialAd.show();
            setState(() {
              _isAdLoaded = true;
            });
          }
        }
      },
    );

    interstitialAd.load();
  }

  @override
  void dispose() {
    interstitialAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteProvider>(context).favoriteList;
    final letterSize = Preferences.getSize;

    if (favorite.isEmpty) {
      Provider.of<FavoriteProvider>(context, listen: false).getAllFavorites();
    }

    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text(
          'Versículos favoritos',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: const DrawerMenu(),
      body: favorite.isEmpty
          ? Center(
              child: Text(
                'No hay versículos favoritos',
                style: TextStyle(fontSize: letterSize),
              ),
            )
          : ListView.builder(
              itemCount: favorite.length,
              itemBuilder: (context, index) {
                final data = favorite[index];
                return GestureDetector(
                  onTap: () {
                    Provider.of<BookProviders>(context, listen: false)
                        .setCap(data['chapter']);
                    Provider.of<BookProviders>(context, listen: false)
                        .fetchSpecificChapter(
                            data['book']); // Actualiza el capítulo actual
                    Provider.of<ScreenRoute>(context, listen: false)
                        .setIndex(1);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SelectedRoutes()));
                    print('data: $data');
                  },
                  child: Card(
                    margin: const EdgeInsets.all(15),
                    child: ListTile(
                      title: Text(
                        '${data['book']} ${data['chapter']}',
                        style: TextStyle(
                          fontSize: letterSize,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(left: 2.0, top: 6),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              '${data['verse']}  ',
                              style: TextStyle(
                                fontSize: letterSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${data['text']}',
                                style: TextStyle(fontSize: letterSize),
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                await FlutterShare.share(
                                  title: 'Versículo del día',
                                  text:
                                      '${data['book']} ${data['chapter']} ${data['verse']} ${data['text']}',
                                );
                              },
                              icon: const Icon(Icons.share,
                                  color: Colors.indigo, size: 17.0),
                            ),
                            IconButton(
                              onPressed: () {
                                Provider.of<FavoriteProvider>(context,
                                        listen: false)
                                    .deleteFavorite(data['id']);
                              },
                              icon: Icon(Icons.favorite_rounded,
                                  color: Colors.red),
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
