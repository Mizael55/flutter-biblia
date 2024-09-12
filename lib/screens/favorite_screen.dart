import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../share_preferences/preferences.dart';
import '../widgets/widgets.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteProvider>(context).favoriteList;
    final letterSize = Preferences.getSize;

    if(favorite.isEmpty){
      Provider.of<FavoriteProvider>(context, listen: false).getAllFavorites();
    }


    return Scaffold(
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
                return Card(
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
                            icon:
                                Icon(Icons.favorite_rounded, color: Colors.red),
                          ),
                        ],
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
