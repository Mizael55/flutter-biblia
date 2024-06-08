import 'dart:convert';

class NameBooks {
  List<String> names;
  String abrev;
  int chapters;
  Testament testament;

  NameBooks({
    required this.names,
    required this.abrev,
    required this.chapters,
    required this.testament,
  });

  factory NameBooks.fromJson(String str) => NameBooks.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory NameBooks.fromMap(Map<String, dynamic> json) => NameBooks(
        names: List<String>.from(json["names"].map((x) => x)),
        abrev: json["abrev"],
        chapters: json["chapters"],
        testament: testamentValues.map[json["testament"]]!,
      );

  Map<String, dynamic> toMap() => {
        "names": List<dynamic>.from(names.map((x) => x)),
        "abrev": abrev,
        "chapters": chapters,
        "testament": testamentValues.reverse[testament],
      };

  @override
  String toString() {
    return 'NameBooks(names: $names, abrev: $abrev, chapters: $chapters, testament: $testament)';
  }
}

enum Testament { ANTIGUO_TESTAMENTO, NUEVO_TESTAMENTO }

final testamentValues = EnumValues({
  "Antiguo Testamento": Testament.ANTIGUO_TESTAMENTO,
  "Nuevo Testamento": Testament.NUEVO_TESTAMENTO
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
