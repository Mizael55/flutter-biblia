import 'dart:convert';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:biblia/screens/song_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:provider/provider.dart';
import '../models/models.dart';
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class HimnosScreen extends StatefulWidget {
  @override
  _HimnosScreenState createState() => _HimnosScreenState();
}

class _HimnosScreenState extends State<HimnosScreen> {
  List<Song> allSongs = [];
  List<Song> displayedSongs = [];
  List<Map<String, dynamic>> favoriteSongs = [];
  bool isFavorite = true;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSongs();
    loadFavorites();
    _searchController.addListener(() {
      filterSongs(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> loadSongs() async {
    final String response =
        await rootBundle.rootBundle.loadString('assets/himnario_data.json');
    final data = json.decode(response) as List;
    setState(() {
      allSongs = data.map((json) => Song.fromJson(json)).toList();
      displayedSongs = allSongs;
    });
  }

  Future<void> loadFavorites() async {
    final favorites = await FavoriteSongsProvider().getFavoritesSongsHimnos();
    setState(() {
      favoriteSongs = favorites;
    });
  }

  Future<void> toggleFavorite(Song song) async {
    if (favoriteSongs.any((fav) => fav['title'] == song.title)) {
      await FavoriteSongsProvider().deleteFavoriteSongsHimnos(song.title);
    } else {
      await FavoriteSongsProvider()
          .insertFavoriteSongsHimnos(song.title, song.lyrics);
    }
    loadFavorites();
  }

  void filterSongs(String query) {
    final searchLower = query.toLowerCase();

    final filteredSongs = allSongs
        .asMap()
        .entries
        .where((entry) {
          final index = entry.key + 1; // El índice es 1-based
          final song = entry.value;
          final titleLower = song.title.toLowerCase();
          final indexString = index.toString();

          return titleLower.contains(searchLower) ||
              indexString.contains(searchLower);
        })
        .map((entry) => entry.value)
        .toList();

    setState(() {
      displayedSongs = filteredSongs;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeProvider>(context).currentTheme;
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Himnos'),
        actions: [
          Text(isFavorite ? 'Favoritos' : 'Volver',
              style: TextStyle(fontSize: 20)),
          IconButton(
            icon: !isFavorite
                ? Icon(Icons.arrow_back,
                    color:
                        theme == ThemeData.dark() ? Colors.white : Colors.black)
                : Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
        bottom: isFavorite
            ? PreferredSize(
                preferredSize: Size.fromHeight(kToolbarHeight),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
              )
            : null,
      ),
      drawer: const DrawerMenu(),
      body: displayedSongs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : !isFavorite
              ? Stack(children: [
                  ListView.builder(
                    padding: EdgeInsets.only(bottom: 60),
                    itemCount: favoriteSongs.length,
                    itemBuilder: (context, index) {
                      final favorite = favoriteSongs[index];
                      final song = allSongs.firstWhere(
                          (song) => song.title == favorite['title']);
                      final songIndex = allSongs.indexOf(song) + 1;
                      return ListTile(
                        title: Text(
                          '$songIndex. ${song.title}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        subtitle:
                            song.author != null ? Text(song.author!) : null,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SongDetailScreen(song: song),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ])
              : Stack(
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.only(bottom: 60),
                      itemCount: displayedSongs.length,
                      itemBuilder: (context, index) {
                        final song = displayedSongs[index];
                        final songIndex = allSongs.indexOf(song) +
                            1; // Obtener el índice original
                        final isFavoriteSong = favoriteSongs
                            .any((fav) => fav['title'] == song.title);

                        return ListTile(
                          title: Text(
                            '$songIndex. ${song.title}',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          subtitle:
                              song.author != null ? Text(song.author!) : null,
                          trailing: IconButton(
                            icon: Icon(
                              isFavoriteSong
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: isFavoriteSong ? Colors.red : null,
                            ),
                            onPressed: () {
                              toggleFavorite(song);
                            },
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SongDetailScreen(song: song),
                              ),
                            );
                          },
                        );
                      },
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: AdmobBanner(
                        adUnitId:
                             "ca-app-pub-7568006196201830/2419923083",
                        adSize: AdmobBannerSize.BANNER,
                      ),
                    ),
                  ],
                ),
      bottomNavigationBar: BottomNavigator(),
    );
  }
}
