import 'package:biblia/services/coros.dart';
import 'package:flutter/material.dart';

class CorosProvider extends ChangeNotifier {
  final List<Map<dynamic, dynamic>> _coros = [];

  List<Map<dynamic, dynamic>> get coros => _coros;

  Future<List<Map<dynamic, dynamic>>> getCoros() async {
    final List<Map<dynamic, dynamic>> coros = await Coros().readCorosJson();
    // _coros.clear();
    _coros.addAll(coros);
    notifyListeners();
    return coros;
  }
}
