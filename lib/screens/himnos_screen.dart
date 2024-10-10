import 'dart:convert';
import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../providers/providers.dart';
import '../widgets/widgets.dart';

class Song {
  final String title;
  final String? author;
  final List<Verse> verses;

  Song({required this.title, this.author, required this.verses});

  factory Song.fromJson(Map<String, dynamic> json) {
    var list = json['verses'] as List;
    List<Verse> versesList = list.map((i) => Verse.fromJson(i)).toList();

    return Song(
      title: json['title'],
      author: json['author'],
      verses: versesList,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'verses': verses.map((v) => v.toJson()).toList(),
    };
  }

  String get lyrics {
    return verses.map((v) => v.toString()).join('\n');
  }
}

class Verse {
  final String? verse;
  final String? chorus;
  final String text;

  Verse({this.verse, this.chorus, required this.text});

  factory Verse.fromJson(Map<String, dynamic> json) {
    return Verse(
      verse: json['verse']?.toString(),
      chorus: json['chorus']?.toString(),
      text: json['text'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'verse': verse,
      'chorus': chorus,
      'text': text,
    };
  }

  @override
  String toString() {
    return [
      if (verse != null) verse,
      text,
      if (chorus != null) 'Coro: $chorus',
    ].where((element) => element != null && element.isNotEmpty).join('\n');
  }
}

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
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: Text('Himnos'),
        actions: [
          Text(isFavorite ? 'Favoritos' : 'Volver',
              style: TextStyle(fontSize: 20)),
          IconButton(
            icon: !isFavorite
                ? Icon(Icons.arrow_back, color: Colors.black)
                : Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              setState(() {
                isFavorite = !isFavorite;
              });
            },
          ),
        ],
        bottom: PreferredSize(
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
        ),
      ),
      drawer: const DrawerMenu(),
      body: displayedSongs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : isFavorite
              ? Stack(
                  children: [
                    ListView.builder(
                      itemCount: displayedSongs.length,
                      itemBuilder: (context, index) {
                        final song = displayedSongs[index];
                        final songIndex = allSongs.indexOf(song) +
                            1; // Obtener el índice original
                        final isFavoriteSong = favoriteSongs
                            .any((fav) => fav['title'] == song.title);

                        return ExpansionTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  '$songIndex. ${song.title}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              IconButton(
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
                            ],
                          ),
                          subtitle:
                              song.author != null ? Text(song.author!) : null,
                          children: song.verses.map((verse) {
                            return ListTile(
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (verse.verse != null) ...[
                                    Text(
                                      verse.verse!,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                  if (verse.text.isNotEmpty)
                                    Text(
                                      verse.text,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  if (verse.chorus != null) ...[
                                    Text(
                                      'Coro',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      verse.chorus!,
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ],
                                ],
                              ),
                            );
                          }).toList(),
                        );
                      },
                    ),
                    // Positioned(
                    //   bottom: 0,
                    //   left: 0,
                    //   right: 0,
                    //   child: AdmobBanner(
                    //     adUnitId: "ca-app-pub-7568006196201830/2419923083",
                    //     adSize: AdmobBannerSize.BANNER,
                    //   ),
                    // ),
                  ],
                )
              : favoriteSongs.isEmpty
                  ? Center(child: Text('No hay favoritos'))
                  : Stack(
                      children: [
                        ListView.builder(
                          itemCount: favoriteSongs.length,
                          itemBuilder: (context, index) {
                            final favorite = favoriteSongs[index];
                            final song = allSongs.firstWhere(
                                (song) => song.title == favorite['title']);
                            final songIndex = allSongs.indexOf(song) +
                                1; // Obtener el índice original

                            return ExpansionTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      '$songIndex. ${song.title}',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ],
                              ),
                              subtitle: song.author != null
                                  ? Text(song.author!)
                                  : null,
                              children: song.verses.map((verse) {
                                return ListTile(
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (verse.verse != null) ...[
                                        Text(
                                          verse.verse!,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                      if (verse.text.isNotEmpty)
                                        Text(
                                          verse.text,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      if (verse.chorus != null) ...[
                                        Text(
                                          'Coro',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          verse.chorus!,
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              }).toList(),
                            );
                          },
                        ),
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
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
}
