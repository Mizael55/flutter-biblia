import 'dart:convert';

class SpanishBibleModel {
    int index;
    String testament;
    String book;
    int boookNumber;
    int verse;
    int chapter;
    String text;
    String title;

    SpanishBibleModel({
        required this.index,
        required this.testament,
        required this.book,
        required this.boookNumber,
        required this.verse,
        required this.chapter,
        required this.text,
        required this.title,
    });

    factory SpanishBibleModel.fromJson(String str) => SpanishBibleModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory SpanishBibleModel.fromMap(Map<String, dynamic> json) => SpanishBibleModel(
        index: json["Index"],
        testament: json["Testament"],
        book: json["Book"],
        boookNumber: json["BoookNumber"],
        verse: json["Verse"],
        chapter: json["Chapter"],
        text: json["Text"],
        title: json["Title"],
    );

    Map<String, dynamic> toMap() => {
        "Index": index,
        "Testament": testament,
        "Book": book,
        "BoookNumber": boookNumber,
        "Verse": verse,
        "Chapter": chapter,
        "Text": text,
        "Title": title,
    };
}
