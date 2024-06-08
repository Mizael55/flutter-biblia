import 'dart:convert';
import '../models/models.dart';
import 'package:http/http.dart' as http;

class GetBooks {
  static const String endPoint = 'https://bible-api.deno.dev/api/books';

  Future<List<NameBooks>> fetchBooks() async {
    final response = await http.get(Uri.parse(endPoint));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      List<NameBooks> books = jsonResponse.map((data) => NameBooks.fromMap(data)).toList();
      print(books);
      return books;
    } else {
      throw Exception('Failed to load books');
    }
  }
  
}
