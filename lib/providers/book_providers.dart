import 'package:biblia/services/book.dart';
import 'package:flutter/material.dart';

class BooksNamesProvider extends ChangeNotifier {
  bool oldBooks = true;
  late int cap;
  final List<Map<dynamic, dynamic>> _chapterList = [];
  List<Map<dynamic, dynamic>> get chapterList => _chapterList;

  int getCap() {
    return cap;
  }
  bool getOldBooks() {
    return oldBooks;
  }
  void setCap(int cap) {
    this.cap = cap;
  }

  void setOldBooks( bool oldBooks) {
    this.oldBooks = oldBooks;
    notifyListeners();
  }

  Future<List<Map<dynamic, dynamic>>> getChapterList() async {
    final List<Map<dynamic, dynamic>> chapterList = await Book().readJson();
    _chapterList.addAll(chapterList);
    notifyListeners();
    return chapterList;
  }

  Future<List<Map<dynamic, dynamic>>> fetchSpecificChapter(
      String name) async {
    final List<Map<dynamic, dynamic>> chapterList =
        await Book().fetchSpecificChapter(name, cap);
    _chapterList.clear();
    _chapterList.addAll(chapterList);
    notifyListeners();
    return chapterList;
  }
}
