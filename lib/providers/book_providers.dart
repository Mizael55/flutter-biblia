import 'package:biblia/services/book.dart';
import 'package:flutter/material.dart';

class BookProviders extends ChangeNotifier {
  bool oldBooks = true;
  late int cap;
  final List<Map<dynamic, dynamic>> _chapterList = [];
  final List<Map<dynamic, dynamic>> _fullBible = [];
  // final List<dynamic> _fullBible = [];
  final List<Map<dynamic, dynamic>> _verseOfTheDay = [];
  List<Map<dynamic, dynamic>> get verseOfTheDay => _verseOfTheDay;
  List<Map<dynamic, dynamic>> get chapterList => _chapterList;
  List<Map<dynamic, dynamic>> get fullBible => _fullBible;
  // List<dynamic> get fullBible => _fullBible;

  int getCap() {
    return cap;
  }

  bool getOldBooks() {
    return oldBooks;
  }

  void setCap(int cap) {
    this.cap = cap;
  }

  void setOldBooks(bool oldBooks) {
    this.oldBooks = oldBooks;
    notifyListeners();
  }

  Future<List<Map<dynamic, dynamic>>> getChapterList() async {
    final List<Map<dynamic, dynamic>> chapterList = await Book().readJson();
    _chapterList.clear();
    _chapterList.addAll(chapterList);
    notifyListeners();
    return chapterList;
  }
  Future<List<Map<dynamic, dynamic>>> readAllJson() async {
    final List<Map<dynamic, dynamic>> fullBible = await Book().readAllJson();
    _fullBible.clear();
    _fullBible.addAll(fullBible);
    notifyListeners();
    return fullBible;
  }

  Future<List<Map<dynamic, dynamic>>> fetchSpecificChapter(String name) async {
    final List<Map<dynamic, dynamic>> chapterList =
        await Book().fetchSpecificChapter(name, cap);
    _chapterList.clear();
    _chapterList.addAll(chapterList);
    notifyListeners();
    return chapterList;
  }

  Future<List<Map<dynamic, dynamic>>> fetchVerseOfTheDay() async {
    final verse = await Book().fetchVerseOfTheDay();
    _verseOfTheDay.clear();
    _verseOfTheDay.add(verse);
    notifyListeners();
    return _verseOfTheDay;
  }
}
