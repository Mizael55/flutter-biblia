import 'dart:convert';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class Book {
  static const String getllBooksNames = 'https://bible-api.deno.dev/api/books';
  static const String getChapter =
      'https://bible-api.deno.dev/api/read/rv1960/genesis/1';

  Future<List<NameBooks>> fetchBooks() async {
    final response = await http.get(Uri.parse(getllBooksNames));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<NameBooks> books =
          jsonResponse.map((data) => NameBooks.fromMap(data)).toList();
      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }

  Future<Map<dynamic, dynamic>> fetchChapter() async {
    final response = await http.get(Uri.parse(getChapter));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      Map<dynamic, dynamic> chapter = jsonResponse;
      return chapter;
    } else {
      throw Exception('Failed to load chapter');
    }
  }
}
