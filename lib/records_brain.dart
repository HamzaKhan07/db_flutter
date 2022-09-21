import 'package:flutter/cupertino.dart';
import 'stud_data.dart';

class RecordsBrain extends ChangeNotifier {
  List<StudData> data;

  void setData(var records) {
    data = records;
    notifyListeners();
  }
}
