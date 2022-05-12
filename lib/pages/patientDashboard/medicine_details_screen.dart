import 'package:duet_clinic/model/medicine_model.dart';
import 'package:duet_clinic/pages/patientDashboard/add_edit_medicine_screen.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicineDetailsScreen extends StatelessWidget {
  final MedicineModel medicineModel;
  final bool isEdit;

  const MedicineDetailsScreen({required this.medicineModel, required this.isEdit, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(medicineModel.name!),
        actions: [
          isEdit
              ? IconButton(
                  onPressed: () {
                    Provider.of<TestProvider>(context, listen: false).deleteMedicineBYID(medicineModel.uId!);
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.delete, color: Colors.red))
              : const SizedBox.shrink(),
          isEdit
              ? IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (_) => AddEditMedicineScreen(isEditSection: true, medicineModel: medicineModel)));
                  },
                  icon: const Icon(Icons.edit))
              : const SizedBox.shrink()
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Name: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('${medicineModel.name}', style: const TextStyle(fontSize: 18)),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Text('Company Name: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('${medicineModel.companyName}', style: const TextStyle(fontSize: 18)),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Text('Weight: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('${medicineModel.quantity}', style: const TextStyle(fontSize: 18)),
              ],
            ),
            const Divider(),
            Row(
              children: [
                const Text('Price: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
                Text('${medicineModel.price} ৳', style: const TextStyle(fontSize: 18)),
              ],
            ),
            const Divider(),
            const Text('Details: ', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16)),
            Text('${medicineModel.details}', style: const TextStyle(fontSize: 18)),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
