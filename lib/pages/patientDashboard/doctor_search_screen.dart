import 'package:duet_clinic/pages/patientDashboard/hospitalCard.dart';
import 'package:duet_clinic/pages/widgets/custome_text_fields.dart';
import 'package:duet_clinic/services/backend.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DoctorSearchScreen extends StatefulWidget {
  const DoctorSearchScreen({Key? key}) : super(key: key);

  @override
  _DoctorSearchScreenState createState() => _DoctorSearchScreenState();
}

class _DoctorSearchScreenState extends State<DoctorSearchScreen> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
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
                      const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                          child: CustomTextField(
                            isDoctorSearch: true,
                            hintText: 'Write Hospital / Doctor Name',
                            isShowBorder: true,
                            isShowSuffixIcon: true,
                            suffixIconUrl: Icons.search,
                            isIcon: true,
                          )),
                      Consumer<TestProvider>(
                          builder: (context, testProvider, child) => testProvider.allShortDoctors.isEmpty
                              ? Container(
                                  margin: const EdgeInsets.only(top: 100),
                                  child: const Center(child: Text('No Data Found', style: TextStyle(fontSize: 20))))
                              : Expanded(
                                  child: ListView.builder(
                                      itemCount: testProvider.allShortDoctors.length,
                                      physics: const BouncingScrollPhysics(),
                                      padding: EdgeInsets.all(15),
                                      itemBuilder: (context, index) =>
                                          HospitalCard2(doctor: testProvider.allShortDoctors[index])),
                                ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
