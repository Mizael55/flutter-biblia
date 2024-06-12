import 'dart:convert';
import 'package:flutter/services.dart';

class Book {
  readJson() async {
    final response = await rootBundle.loadString('assets/spanish.json');
    final data = json.decode(response) as List;
    return data.cast<Map<String, dynamic>>();
  }

  fetchSpecificChapter(String name, int cap) async {
    final response = await rootBundle.loadString('assets/spanish.json');
    final data = json.decode(response);
    final r = data
        .skipWhile((element) =>
            !(element['Book'] == name && element['Chapter'] == cap))
        .toList();
    return r.cast<Map<String, dynamic>>();
  }
}
