import 'dart:convert';

class Chapter {
    String testament;
    String name;
    int numChapters;
    int chapter;
    List<Ver> vers;

    Chapter({
        required this.testament,
        required this.name,
        required this.numChapters,
        required this.chapter,
        required this.vers,
    });

    factory Chapter.fromJson(String str) => Chapter.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Chapter.fromMap(Map<String, dynamic> json) => Chapter(
        testament: json["testament"],
        name: json["name"],
        numChapters: json["num_chapters"],
        chapter: json["chapter"],
        vers: List<Ver>.from(json["vers"].map((x) => Ver.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "testament": testament,
        "name": name,
        "num_chapters": numChapters,
        "chapter": chapter,
        "vers": List<dynamic>.from(vers.map((x) => x.toMap())),
    };

    @override
    String toString() {
        return 'Chapter(testament: $testament, name: $name, numChapters: $numChapters, chapter: $chapter, vers: $vers)';
    }
}

class Ver {
    int id;
    int number;
    String? study;
    String verse;

    Ver({
        required this.id,
        required this.number,
        this.study,
        required this.verse,
    });

    factory Ver.fromJson(String str) => Ver.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Ver.fromMap(Map<String, dynamic> json) => Ver(
        id: json["id"],
        number: json["number"],
        study: json["study"],
        verse: json["verse"],
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "number": number,
        "study": study,
        "verse": verse,
    };
}
