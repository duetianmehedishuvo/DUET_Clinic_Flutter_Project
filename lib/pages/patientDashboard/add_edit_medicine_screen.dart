import 'package:duet_clinic/model/medicine_model.dart';
import 'package:duet_clinic/pages/widgets/custom_button.dart';
import 'package:duet_clinic/pages/widgets/custom_loader.dart';
import 'package:duet_clinic/pages/widgets/custom_snackbar.dart';
import 'package:duet_clinic/pages/widgets/custome_text_fields.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddEditMedicineScreen extends StatefulWidget {
  final bool isEditSection;
  final MedicineModel? medicineModel;

  const AddEditMedicineScreen({this.medicineModel, this.isEditSection = false, Key? key}) : super(key: key);

  @override
  State<AddEditMedicineScreen> createState() => _AddEditMedicineScreenState();
}

class _AddEditMedicineScreenState extends State<AddEditMedicineScreen> {
  TextEditingController titleController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController detailsController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditSection) {
      titleController.text = widget.medicineModel!.name!;
      quantityController.text = widget.medicineModel!.quantity!;
      priceController.text = widget.medicineModel!.price!;
      detailsController.text = widget.medicineModel!.details!;
      companyNameController.text = widget.medicineModel!.companyName!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('${widget.isEditSection ? 'Update' : 'Add'} Medicine')),
      body: Consumer<TestProvider>(
          builder: (context, testProvider, child) => SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    CustomTextField(hintText: 'Product Name', controller: titleController, isShowBorder: true),
                    const SizedBox(height: 15),
                    CustomTextField(hintText: 'Product Weight', controller: quantityController, isShowBorder: true),
                    const SizedBox(height: 15),
                    CustomTextField(
                        hintText: 'Price', controller: priceController, inputType: TextInputType.number, isShowBorder: true),
                    const SizedBox(height: 15),
                    CustomTextField(hintText: 'Company Name?', controller: companyNameController, isShowBorder: true),
                    const SizedBox(height: 15),
                    CustomTextField(
                        hintText: 'Product Details', controller: detailsController, maxLines: 5, isShowBorder: true),
                    const SizedBox(height: 15),
                    !testProvider.isMedicineLoading
                        ? CustomButton(
                            btnTxt: widget.isEditSection ? 'Update' : 'Add',
                            onTap: () {
                              if (titleController.text.isEmpty ||
                                  companyNameController.text.isEmpty ||
                                  quantityController.text.isEmpty ||
                                  priceController.text.isEmpty ||
                                  detailsController.text.isEmpty) {
                                showCustomSnackBar('Please fill up all other fields', context);
                              } else {
                                MedicineModel medicine = MedicineModel(
                                    uId: widget.isEditSection
                                        ? widget.medicineModel!.uId
                                        : DateTime.now().microsecondsSinceEpoch.toString(),
                                    companyName: companyNameController.text,
                                    name: titleController.text,
                                    quantity: quantityController.text,
                                    price: priceController.text,
                                    details: detailsController.text);
                                if (widget.isEditSection) {
                                  testProvider.updateMedicine(medicine);
                                  showCustomSnackBar('Update Successfully', context, isError: false);
                                } else {
                                  testProvider.addMedicine(medicine);
                                  showCustomSnackBar('Added Successfully', context, isError: false);
                                }

                                companyNameController.text = '';
                                titleController.text = '';
                                quantityController.text = '';
                                priceController.text = '';
                                detailsController.text = '';
                              }
                            },
                            radius: 10)
                        : const CustomLoader()
                  ],
                ),
              )),
    );
  }
}
