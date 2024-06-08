import 'package:biblia/db/spanish_bible.dart';

class Book {
  // static const String getllBooksNames = 'https://bible-api.deno.dev/api/books';
  // static const String getChapter = 'https://bible-api.deno.dev/api/read/rv1960';
  // static const String defautl =
  //     'https://bible-api.deno.dev/api/read/rv1960/genesis/1';

  // Future<List<NameBooks>> fetchBooks() async {
  //   final response = await http.get(Uri.parse(getllBooksNames));

  //   if (response.statusCode == 200) {
  //     List<dynamic> jsonResponse = json.decode(response.body);
  //     List<NameBooks> books =
  //         jsonResponse.map((data) => NameBooks.fromMap(data)).toList();
  //     return books;
  //   } else {
  //     throw Exception('Failed to load books');
  //   }
  // }

  // Future<Map<dynamic, dynamic>> fetchChapter(String? name, String? cap) async {
  //   final http.Response response;
  //   if (name == null || name == '' || cap == null || cap == '') {
  //     response = await http.get(Uri.parse(defautl));
  //   } else {
  //     response = await http.get(Uri.parse('$getChapter/$name/$cap'));
  //   }

  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     Map<dynamic, dynamic> chapter = jsonResponse;
  //     return chapter;
  //   } else {
  //     throw Exception('Failed to load chapter');
  //   }
  // }

  // Future<Map<dynamic, dynamic>> nextChapter(String? name, int? cap) async {
  //   final http.Response response;
  //   if (name == null || name == '') {
  //     response = await http.get(Uri.parse(defautl));
  //   } else {
  //     response = await http.get(Uri.parse('$getChapter/$name/$cap'));
  //   }

  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     Map<dynamic, dynamic> chapter = jsonResponse;
  //     return chapter;
  //   } else {
  //     throw Exception('Failed to load chapter');
  //   }
  // }

  // Future<Map<dynamic, dynamic>> previousChapter(String? name, int? cap) async {
  //   final http.Response response;
  //   if (name == null || name == '') {
  //     response = await http.get(Uri.parse(defautl));
  //   } else {
  //     response = await http.get(Uri.parse('$getChapter/$name/$cap'));
  //   }

  //   if (response.statusCode == 200) {
  //     final jsonResponse = json.decode(response.body);
  //     Map<dynamic, dynamic> chapter = jsonResponse;
  //     return chapter;
  //   } else {
  //     throw Exception('Failed to load chapter');
  //   }
  // }

  Future<List<Map<String, Object>>> fetching() async {
    final response = SpanishBible.spanishBible;
    return response;
  }

  Future<List<Map<String, Object>>> fetchSpecificChapter(
      String name, int cap) async {
    final response = SpanishBible.spanishBible
        .skipWhile((element) => !(element['Book'] == name && element['Chapter'] == cap))
        .toList();
    return response;
  }
}
