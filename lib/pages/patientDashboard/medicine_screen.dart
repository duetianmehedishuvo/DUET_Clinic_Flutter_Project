import 'package:duet_clinic/pages/patientDashboard/add_edit_medicine_screen.dart';
import 'package:duet_clinic/pages/patientDashboard/medicine_details_screen.dart';
import 'package:duet_clinic/pages/role.dart';
import 'package:duet_clinic/pages/widgets/custom_loader.dart';
import 'package:duet_clinic/pages/widgets/custome_text_fields.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MedicineScreen extends StatefulWidget {
  const MedicineScreen({Key? key}) : super(key: key);

  @override
  State<MedicineScreen> createState() => _MedicineScreenState();
}

class _MedicineScreenState extends State<MedicineScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<TestProvider>(context, listen: false).initializeAllMedicins();
    Provider.of<TestProvider>(context, listen: false).getAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Consumer<TestProvider>(builder: (context, testProvider, child) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(Icons.close)),
                      Expanded(
                        child: CustomTextField(
                          hintText: 'Search Medicine',
                          isShowBorder: true,
                          suffixIconUrl: Icons.search,
                          isShowSuffixIcon: true,
                          isIcon: true,
                          onSuffixTap: () {},
                          isMedicineSearch: true,
                        ),
                      ),
                      const SizedBox(width: 15),
                      currentUser.uid == testProvider.adminKey
                          ? IconButton(
                              onPressed: () {
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const AddEditMedicineScreen()));
                              },
                              icon: const Icon(Icons.add))
                          : const SizedBox.shrink()
                    ],
                  ),
                ),
                Container(height: 2, margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), color: Colors.teal),
                testProvider.medicins.isNotEmpty && !testProvider.isMedicineLoading
                    ? Expanded(
                        child: ListView.builder(
                            itemCount: testProvider.medicins.length,
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => MedicineDetailsScreen(
                                          medicineModel: testProvider.medicins[index],
                                          isEdit: currentUser.uid == testProvider.adminKey)));
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 1,
                                        offset: const Offset(0, 1), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          const Text('Name: ', style: TextStyle(fontWeight: FontWeight.w500)),
                                          Text('${testProvider.medicins[index].name}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Company: ', style: TextStyle(fontWeight: FontWeight.w500)),
                                          Text('${testProvider.medicins[index].companyName}'),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          const Text('Weight: ', style: TextStyle(fontWeight: FontWeight.w500)),
                                          Text('${testProvider.medicins[index].quantity}'),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      )
                    : testProvider.medicins.isEmpty && !testProvider.isMedicineLoading
                        ? SizedBox(
                            height: MediaQuery.of(context).size.height * 0.4,
                            child: const Center(child: Text('No Data Found')))
                        : SizedBox(height: MediaQuery.of(context).size.height * 0.4, child: const CustomLoader())
              ],
            );
          }),
        ),
      ),
    );
  }
}
