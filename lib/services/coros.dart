import 'dart:convert';
import 'package:flutter/services.dart';

class Coros {
  readCorosJson() async {
    final response = await rootBundle.loadString('assets/coros.json');
    final data = json.decode(response) as List;
    return data.cast<Map<String, dynamic>>();
  }
}
