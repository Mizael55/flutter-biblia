import 'package:biblia/services/book.dart';
import 'package:flutter/material.dart';

class BooksNamesProvider extends ChangeNotifier {
  bool oldBooks = true;
  late int cap;
  final List<Map<String, Object>> _chapterList = [];
  final List<Map<String, Object>> _byBook = [];
  List<Map<String, Object>> get chapterList => _chapterList;
  // List<Map<String, Object>> get byBook => _byBook;
  // get de cap
  int getCap() {
    return cap;
  }
  bool getOldBooks() {
    return oldBooks;
  }
  // crea un set de cap
  void setCap(int cap) {
    this.cap = cap;
  }

  void setOldBooks( bool oldBooks) {
    this.oldBooks = oldBooks;
    notifyListeners();
  }
  // final List<NameBooks> _booksNames = [];
  // final Map<dynamic, dynamic> _chapter = {};

  // List<NameBooks> get booksNames => _booksNames;
  // Map<dynamic, dynamic> get chapter => _chapter;

// crea un set de name y cap
  // void setChapter({required String name, required int cap}) {
  //   this.name = name;
  //   this.cap = cap;
  // }

  // Future<void> gettingBooksNames() async {
  //   final List<NameBooks> booksNames = await Book().fetchBooks();
  //   _booksNames.addAll(booksNames);
  //   notifyListeners();
  // }

  // Future<void> gettingChapter(String? name, int? cap) async {
  //   final parsing = cap.toString();
  //   final Map<dynamic, dynamic> chapter =
  //       await Book().fetchChapter(name, parsing);
  //   _chapter.addAll(chapter);
  //   notifyListeners();
  // }

  // Future<void> nextChapter() async {
  //   final Map<dynamic, dynamic> chapter = await Book().nextChapter(name, cap);
  //   _chapter.clear();
  //   _chapter.addAll(chapter);
  //   cap++;
  //   notifyListeners();
  // }

  // Future<void> previousChapter() async {
  //   final Map<dynamic, dynamic> chapter =
  //       await Book().previousChapter(name, cap);
  //   _chapter.clear();
  //   _chapter.addAll(chapter);
  //   cap--;
  //   notifyListeners();
  // }

  Future<List<Map<String, Object>>> getChapterList() async {
    final List<Map<String, Object>> chapterList = await Book().fetching();
    _chapterList.addAll(chapterList);
    notifyListeners();

    return chapterList;
  }

  Future<List<Map<String, Object>>> fetchSpecificChapter(
      String name) async {
    final List<Map<String, Object>> chapterList =
        await Book().fetchSpecificChapter(name, cap);
    _chapterList.clear();
    _chapterList.addAll(chapterList);
    notifyListeners();
    return chapterList;
  }
}
