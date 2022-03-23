import 'package:flutter/foundation.dart';

class TestProvider with ChangeNotifier {
  List<String> categoryLists = ['head & nose', 'Hart', 'Cancer', 'Skin', 'Child and Baby'];

  String selectCategory = 'head & nose';

  changeSelectCategory(String category) {
    selectCategory = category;
    notifyListeners();
  }
}
