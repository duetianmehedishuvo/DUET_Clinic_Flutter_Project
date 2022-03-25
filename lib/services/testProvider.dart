import 'package:flutter/foundation.dart';

List<String> categoryImageLists = [
  'assets/Burn sergery.png',
  'assets/Cancer.png',
  'assets/cardiologist.png',
  'assets/diabetology.png',
  'assets/ENT(ear nose throat).png',
  'assets/gynecologist.png',
  'assets/kidney.png',
  'assets/Medicine.png',
  'assets/neurology.png',
  'assets/Orthopedic Truma.png'
];

class TestProvider with ChangeNotifier {
  List<String> categoryLists = [
    'Burn Surgery',
    'Cancer',
    'Cardiologist',
    'Diabetics',
    'Ear Nose Throat',
    'Gynecologist',
    'Kidney',
    'Medicine',
    'Neurology',
    'Orthopedic Trauma'
  ];

  String selectCategory = 'Burn Surgery';

  changeSelectCategory(String category) {
    selectCategory = category;
    notifyListeners();
  }
}
