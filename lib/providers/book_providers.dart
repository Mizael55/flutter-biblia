import 'package:biblia/services/book.dart';
import 'package:flutter/material.dart';
import '../models/models.dart';

class BooksNamesProvider extends ChangeNotifier {
  final List<NameBooks> _booksNames = [];
  final Map<dynamic,dynamic> _chapter = {};

  List<NameBooks> get booksNames => _booksNames;
  Map<dynamic,dynamic> get chapter => _chapter;

  Future<void> gettingBooksNames() async {
    final List<NameBooks> booksNames = await Book().fetchBooks();
    _booksNames.addAll(booksNames);
    notifyListeners();
  }

  Future<void> gettingChapter() async {
    final Map<dynamic,dynamic> chapter = await Book().fetchChapter();
    print(chapter);
    _chapter.addAll(chapter);
    notifyListeners();
  }
}
