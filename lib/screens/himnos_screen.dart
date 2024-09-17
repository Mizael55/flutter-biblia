import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;

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
}

class HimnosScreen extends StatefulWidget {
  @override
  _HimnosScreenState createState() => _HimnosScreenState();
}

class _HimnosScreenState extends State<HimnosScreen> {
  List<Song> allSongs = [];
  List<Song> displayedSongs = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadSongs();
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
    final String response = await rootBundle.rootBundle.loadString('assets/himnario_data.json');
    final data = json.decode(response) as List;
    setState(() {
      allSongs = data.map((json) => Song.fromJson(json)).toList();
      displayedSongs = allSongs;
    });
  }

  void filterSongs(String query) {
    final filteredSongs = allSongs.where((song) {
      final titleLower = song.title.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      displayedSongs = filteredSongs;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Himnos'),
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
      body: displayedSongs.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: displayedSongs.length,
              itemBuilder: (context, index) {
                final song = displayedSongs[index];
                return ExpansionTile(
                  title: Text('${index + 1}. ${song.title}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  subtitle: song.author != null ? Text(song.author!) : null,
                  children: song.verses.map((verse) {
                    return ListTile(
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (verse.verse != null) ...[
                            Text(verse.verse!, style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                          if (verse.text.isNotEmpty) Text(verse.text, style: TextStyle(fontSize: 18)),
                          if (verse.chorus != null) ...[
                            Text('Coro', style: TextStyle(fontWeight: FontWeight.bold)),
                            Text(verse.chorus!, style: TextStyle(fontSize: 18))
                          ],
                        ],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
    );
  }
}