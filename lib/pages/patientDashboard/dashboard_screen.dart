import 'package:duet_clinic/pages/patientDashboard/doctor_search_screen.dart';
import 'package:duet_clinic/pages/patientDashboard/medicine_screen.dart';
import 'package:duet_clinic/pages/patientDashboard/notification.dart';
import 'package:duet_clinic/pages/patientDashboard/patientDashboard.dart';
import 'package:duet_clinic/pages/patientDashboard/patientInfo.dart';
import 'package:duet_clinic/pages/widgets/custom_button.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    Provider.of<TestProvider>(context, listen: false).initializeAllShortDoctors();
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Stack(
            children: [
              Container(
                width: screenWidth * (3 / 4),
                margin: const EdgeInsets.only(left: 10),
                alignment: Alignment.topLeft,
                child: Opacity(
                  opacity: 0.2,
                  child: Image.asset(
                    "assets/splash_login_registration_background_image.png",
                    height: 200,
                  ),
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text('Welcome to Hello Doctor',
                            textAlign: TextAlign.end, style: TextStyle(color: Colors.green, fontSize: 25))),
                    const SizedBox(height: 20),
                    InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const DoctorSearchScreen()));
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: const Color(0xff05a317).withOpacity(.1),
                                offset: const Offset(0, 0),
                                blurRadius: 6,
                                spreadRadius: 2)
                          ],
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.search, color: Colors.black),
                            SizedBox(width: 10),
                            Text('Search Hospital / Doctor', style: TextStyle(fontSize: 15, color: Colors.grey))
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        children: [
                          Expanded(
                              child: CustomButton(
                            btnTxt: 'Notifications',
                            radius: 30,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ShowNotification()));
                            },
                          )),
                          const SizedBox(width: 10),
                          Expanded(
                              child: CustomButton(
                            btnTxt: 'User',
                            radius: 30,
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => const PatientInfo()));
                            },
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: CustomButton(
                        btnTxt: 'Find Medicine',
                        radius: 30,
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const MedicineScreen()));
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: const Text('Please Select A Category First Which Type Doctor do you want Find?',
                            textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 15))),
                    Expanded(
                      child: Consumer<TestProvider>(
                        builder: (context, testProvider, child) => GridView.builder(
                            padding: const EdgeInsets.all(20),
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2, crossAxisSpacing: 20, mainAxisSpacing: 20, childAspectRatio: 1.1),
                            itemCount: testProvider.categoryLists.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    Navigator.of(context).push(MaterialPageRoute(
                                        builder: (_) => PatientDashboard(categoryType: testProvider.categoryLists[index])));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                            color: const Color(0xff05a317).withOpacity(.1),
                                            offset: const Offset(0, 0),
                                            blurRadius: 6,
                                            spreadRadius: 2)
                                      ],
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(categoryImageLists[index], width: 50, height: 50, fit: BoxFit.fill),
                                        const SizedBox(height: 10),
                                        Text(testProvider.categoryLists[index])
                                      ],
                                    ),
                                  ),
                                )),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
