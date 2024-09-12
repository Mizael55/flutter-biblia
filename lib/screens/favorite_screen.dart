import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/providers.dart';
import '../share_preferences/preferences.dart';
import '../widgets/widgets.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final favorite = Provider.of<FavoriteProvider>(context, listen: false);
    final letterSize = Preferences.getSize;
    return Scaffold(
      body: ListView.builder(
        itemCount: favorite.favoriteList.length,
        itemBuilder: (context, index) {
          final data = favorite.favoriteList[index];
          return Card(
            margin: const EdgeInsets.all(15),
            child: ListTile(
              title: Text(
                '${data['Book']} ${data['Chapter']}',
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
          );
        },
      ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
