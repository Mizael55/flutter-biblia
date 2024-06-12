import 'dart:convert';
import 'package:flutter/services.dart';

class Book {
  readJson() async {
    final response = await rootBundle.loadString('assets/spanish.json');
    final data = json.decode(response) as List;
    final bookData =
        data.where((element) => element['Book'] == 'Génesis').toList();

    int lastChapter = bookData.last['Chapter'];

    final r = bookData
        .takeWhile((element) => element['Chapter'] <= lastChapter)
        .toList();

    return r.cast<Map<String, dynamic>>();
  }

  fetchSpecificChapter(String name, int cap) async {
    final response = await rootBundle.loadString('assets/spanish.json');
    final data = json.decode(response) as List;

    final bookData = data.where((element) => element['Book'] == name).toList();

    final r =
        bookData.skipWhile((element) => element['Chapter'] < cap).toList();

    int lastChapter = r.last['Chapter'];

    final chapterData =
        r.takeWhile((element) => element['Chapter'] <= lastChapter).toList();

    return chapterData.cast<Map<dynamic, dynamic>>();
  }
}
