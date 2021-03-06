import 'package:duet_clinic/model/user.dart';
import 'package:duet_clinic/pages/doctorDashboard/doctorBottomBar.dart';
import 'package:duet_clinic/pages/role.dart';
import 'package:duet_clinic/services/backend.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:duet_clinic/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorProfileForm extends StatefulWidget {
  MyUser? user;
  Doctor? doctor;
  bool isEdit = false;

  DoctorProfileForm({Key? key, this.user, this.doctor, this.isEdit = false}) : super(key: key);

  @override
  _DoctorProfileFormState createState() => _DoctorProfileFormState();
}

class _DoctorProfileFormState extends State<DoctorProfileForm> {
  TextEditingController clinicNameController = TextEditingController();
  TextEditingController educationalQualificationController = TextEditingController();
  TextEditingController timingController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController feeController = TextEditingController();
  TextEditingController paymentMethodController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  bool validClinicName = true, validTiming = true, validAdd = true, validFee = true, validPayMeth = true, isLoading = false;

  @override
  void initState() {
    super.initState();



    if (widget.isEdit) {
      clinicNameController.text = widget.doctor!.clinicName!;
      educationalQualificationController.text = widget.doctor!.educationalQualification!;
      timingController.text = widget.doctor!.timing!;
      addressController.text = widget.doctor!.address!;
      feeController.text = widget.doctor!.fee!;
      paymentMethodController.text = widget.doctor!.paymentMethod!;
      bioController.text = widget.doctor!.bio!;
    }
  }

  void saveDoctorDetail() async {
    String clinicName = clinicNameController.text.trim();
    String educationalQualification = educationalQualificationController.text.trim();
    String timing = timingController.text.trim();
    String address = addressController.text.trim();
    String fee = feeController.text.trim();
    String paymentMethod = paymentMethodController.text.trim();
    String bio = bioController.text.trim();
    setState(() {
      validClinicName = clinicName.isNotEmpty;
      validTiming = timing.isNotEmpty;
      validAdd = address.isNotEmpty;
      validFee = fee.isNotEmpty;
      validPayMeth = paymentMethod.isNotEmpty;
    });
    if (validClinicName && validTiming && validAdd && validFee && validPayMeth) {
      if (!widget.isEdit) {
        currentUser = widget.user!;
        currentUser.isDoctor = true;
      }
      setState(() => isLoading = true);
      Doctor doctor = Doctor(
          uid: widget.isEdit ? widget.doctor!.uid : widget.user!.uid,
          clinicName: clinicName,
          educationalQualification: educationalQualification,
          timing: timing,
          address: address,
          fee: fee,
          paymentMethod: paymentMethod,
          bio: bio,
          displayName: widget.isEdit ? widget.doctor!.displayName : widget.user!.displayName,
          email: widget.isEdit ? widget.doctor!.email : widget.user!.email,
          photoURL: widget.isEdit ? widget.doctor!.photoURL : widget.user!.photoURL);



      widget.isEdit
          ? await Backend().updateDoctorData(doctor, Provider.of<TestProvider>(context,listen: false).selectCategory)
          : await Backend().addDoctorInDataBase(doctor, Provider.of<TestProvider>(context,listen: false).selectCategory);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => const DoctorBottom()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(widget.isEdit ? "Edit Your Profile" : "Create Your Profile"),
      ),
      body: isLoading
          ? const Loading()
          : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: ListView(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: CircleAvatar(
                          backgroundImage: NetworkImage(widget.isEdit ? widget.doctor!.photoURL! : widget.user!.photoURL),
                          radius: 50),
                    ),
                  ),
                  Center(
                      child: Container(
                          margin: const EdgeInsets.only(top: 20),
                          child: Text(widget.isEdit ? widget.doctor!.displayName! : widget.user!.displayName))),
                  Center(
                    child: Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: Text(widget.isEdit ? widget.doctor!.email! : widget.user!.email)),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: clinicNameController,
                    maxLines: null,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        hintText: "Enter your clinic Name",
                        border: const OutlineInputBorder(),
                        labelText: "Clinic Name",
                        errorText: validClinicName ? null : "Clinic Name can't be empty"),
                  ),
                  const SizedBox(height: 20),
                  const FittedBox(
                      child: Text('Please Select one which is on specialist you?',
                          maxLines: 1, style: TextStyle(fontSize: 16))),
                  Container(
                    margin: const EdgeInsets.only(top: 13),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(border: Border.all(), borderRadius: BorderRadius.circular(4)),
                    child: DropdownButton(
                      value: Provider.of<TestProvider>(context).selectCategory,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      underline: const SizedBox.shrink(),
                      isExpanded: true,
                      items: Provider.of<TestProvider>(context, listen: false).categoryLists.map((String items) {
                        return DropdownMenuItem(value: items, child: Text(items));
                      }).toList(),
                      onChanged: (String? newValue) {
                        Provider.of<TestProvider>(context, listen: false).changeSelectCategory(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: educationalQualificationController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: "Enter your educational qualifications",
                      border: const OutlineInputBorder(),
                      labelText: "Educational Qualifications",
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: timingController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        hintText: "Enter Your Clinic Timing",
                        border: const OutlineInputBorder(),
                        labelText: "Timing",
                        errorText: validTiming ? null : "Timing can't be empty"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: addressController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        hintText: "Enter Full Address of Your Clinic",
                        border: const OutlineInputBorder(),
                        labelText: "Address",
                        errorText: validAdd ? null : "Address can't be empty"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: feeController,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        hintText: "Enter Your Fee Amount.",
                        border: const OutlineInputBorder(),
                        labelText: "Fee",
                        errorText: validFee ? null : "Fees can't be empty"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: paymentMethodController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.grey[50],
                        hintText: "Enter Your Number.",
                        border: const OutlineInputBorder(),
                        labelText: "Payment Method",
                        errorText: validPayMeth ? null : "Payment Method can't be empty"),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: bioController,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: "Write a short bio about you.",
                      border: const OutlineInputBorder(),
                      labelText: "Bio",
                    ),
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    child: Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(color: Colors.teal, borderRadius: BorderRadius.circular(10)),
                        child: Text(widget.isEdit ? "Edit" : "Submit",
                            style: const TextStyle(color: Colors.white, fontSize: 18))),
                    onTap: () {
                      saveDoctorDetail();
                    },
                  ),
                  const SizedBox(height: 20)
                ],
              )),
    );
  }
}
