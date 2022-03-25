import 'package:duet_clinic/model/user.dart';
import 'package:duet_clinic/services/backend.dart';
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

  List<ShortDoctor> allShortDoctors = [];
  List<ShortDoctor> allShortDoctorsTemp = [];
  bool isLoading = false;

  initializeAllShortDoctors() async {
    allShortDoctors.clear();
    allShortDoctorsTemp.clear();
    isLoading = true;
    allShortDoctors = [];
    allShortDoctorsTemp = [];
    allShortDoctors.addAll(await Backend.getShortDoctor());
    allShortDoctorsTemp.addAll(await Backend.getShortDoctor());
    isLoading = false;
    notifyListeners();
  }

  searchAllShortDoctors(String query) {
    if (query.isEmpty) {
      allShortDoctors.clear();
      allShortDoctors.addAll(allShortDoctorsTemp);
      notifyListeners();
    } else {
      allShortDoctors = [];
      allShortDoctorsTemp.forEach((doctorData) async {
        if ((doctorData.clinicName!.toLowerCase().contains(query.toLowerCase())) ||
            (doctorData.name!.toLowerCase().contains(query.toLowerCase()))) {
          allShortDoctors.add(doctorData);
        }
      });
      notifyListeners();
    }
  }
}
