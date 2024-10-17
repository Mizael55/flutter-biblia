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