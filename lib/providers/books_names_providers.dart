import 'package:biblia/services/get_books.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class BooksNamesProvider extends ChangeNotifier {
  final List<NameBooks> _booksNames = [];

  List<NameBooks> get booksNames => _booksNames;

  Future<void> gettingBooksNames() async {
    final List<NameBooks> booksNames = await GetBooks().fetchBooks();
    _booksNames.addAll(booksNames);
    notifyListeners();
  }
}
