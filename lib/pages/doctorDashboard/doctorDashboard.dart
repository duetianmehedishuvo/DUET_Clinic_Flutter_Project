import 'package:clinico/model/user.dart';
import 'package:clinico/pages/doctorProfileForm.dart';
import 'package:clinico/pages/role.dart';
import 'package:clinico/services/auth.dart';
import 'package:clinico/services/backend.dart';
import 'package:clinico/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DoctorDashboard extends StatefulWidget {
  const DoctorDashboard({Key? key}) : super(key: key);

  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  Doctor? doctor;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getDoctorDetails();
  }

  void getDoctorDetails() async {
    setState(() => isLoading = true);
    DocumentSnapshot? doc = await doctorCollection.doc(currentUser.uid).get();
    doctor = Doctor(
        address: doc["address"],
        bio: doc["bio"],
        clinicName: doc["clinicName"],
        displayName: doc["displayName"],
        educationalQualification: doc["educationalQualification"],
        email: doc["email"],
        fee: doc["fee"],
        paymentMethod: doc["paymentMethod"],
        photoURL: doc["photoURL"],
        timing: doc["timing"],
        uid: currentUser.uid,
        counter: doc["counter"]);
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
          appBar: AppBar(
            title: Text(doctor!.clinicName!),
            backgroundColor: Colors.indigo,
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
            child: ListView(
              children: [
                const SizedBox(
                  height: 40,
                ),
                Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(doctor!.photoURL!),
                      radius: 40,
                    ),
                  ),
                ),
                Container(
                    alignment: Alignment.topRight,
                    padding: const EdgeInsets.only(right: 10),
                    child: ClipOval(
                      child: Material(
                        color: Colors.transparent, // button color
                        elevation: 0.0,
                        child: InkWell(
                          splashColor: Colors.blueGrey, // inkwell color
                          child: const SizedBox(
                              width: 50,
                              height: 50,
                              child: Icon(
                                Icons.edit,
                                size: 25,
                              )),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DoctorProfileForm(doctor: doctor, isEdit: true)));
                          },
                        ),
                      ),
                    )),
                Center(
                  child: Text(
                    doctor!.clinicName!,
                    style: const TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Divider(),
                const SizedBox(
                  height: 30,
                ),
                Card(
                    child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Center(
                        child: Text(
                          'Dr. ' + doctor!.displayName!,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: Text(
                          doctor!.educationalQualification!,
                          style: const TextStyle(
                            fontSize: 24,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        doctor!.bio!,
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                )),
                const SizedBox(
                  height: 10,
                ),
                Card(
                  child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          const Center(
                            child: Text(
                              'Address : ',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              doctor!.address!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Center(
                            child: Text(
                              'Timing : ',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              doctor!.timing!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Center(
                            child: Text(
                              'UPI Id : ',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              doctor!.paymentMethod!,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          const Center(
                            child: Text(
                              'Fees : ',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              doctor!.fee! + ' rs. at clinic',
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ),
                        ],
                      )),
                ),
                const SizedBox(
                  height: 70,
                ),
                Center(
                  child: RaisedButton(
                    child: const Text(
                      "Log Out",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: () {
                      // Navigator.pop(context);
                      AuthServices().signOutGoogle();
                    },
                    color: Colors.indigo,
                  ),
                ),
                const SizedBox(height: 30)
              ],
            ),
          ),
        );
  }
}
