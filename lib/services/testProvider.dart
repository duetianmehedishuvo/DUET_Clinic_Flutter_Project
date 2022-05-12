import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:duet_clinic/model/medicine_model.dart';
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

  // add medicine
  bool isMedicineLoading = false;
  final CollectionReference medicineCollection = FirebaseFirestore.instance.collection('medicine');
  final CollectionReference adminCollection = FirebaseFirestore.instance.collection('admin');

  addMedicine(MedicineModel medicineModel) async {
    isMedicineLoading = true;
    await medicineCollection.doc(medicineModel.uId).set(medicineModel.toJson());
    isMedicineLoading = false;
    initializeAllMedicins();
    notifyListeners();
  }

  updateMedicine(MedicineModel medicineModel) async {
    isMedicineLoading = true;
    await medicineCollection.doc(medicineModel.uId).update(medicineModel.toJson());
    isMedicineLoading = false;
    initializeAllMedicins();
    notifyListeners();
  }

  deleteMedicineBYID(String uID) async {
    isMedicineLoading = true;
    await medicineCollection.doc(uID).delete();
    isMedicineLoading = false;
    initializeAllMedicins();
    notifyListeners();
  }

  List<MedicineModel> medicins = [];
  List<MedicineModel> medicinsTmp = [];

  void initializeAllMedicins() async {
    isMedicineLoading = true;
    medicins.clear();
    medicins = [];
    medicinsTmp.clear();
    medicinsTmp = [];
    QuerySnapshot snapshot = await medicineCollection.get();
    isMedicineLoading = false;
    snapshot.docs.forEach((element) {
      medicins.add(MedicineModel.fromMap(element));
    });
    medicinsTmp.addAll(medicins);
    notifyListeners();
  }

  searchMedicines(String query) {
    if (query.isEmpty) {
      medicins.clear();
      medicins.addAll(medicinsTmp);
      notifyListeners();
    } else {
      medicins = [];
      medicinsTmp.forEach((doctorData) async {
        if ((doctorData.name!.toLowerCase().contains(query.toLowerCase())) ||
            (doctorData.price!.toLowerCase().contains(query.toLowerCase())) ||
            (doctorData.companyName!.toLowerCase().contains(query.toLowerCase()))) {
          medicins.add(doctorData);
        }
      });
      notifyListeners();
    }
  }

  void setAdmin() {
    adminCollection.add({"admin": "yVgornpLoaZxX9eV5XGwW7RFSFg2"});
  }

  String adminKey = '';

  getAdmin() async {
    adminKey = '';
    QuerySnapshot snapshot = await adminCollection.get();
    adminKey = snapshot.docs.single['admin'];
  }
}
