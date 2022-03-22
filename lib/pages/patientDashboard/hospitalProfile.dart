import 'package:duet_clinic/model/user.dart';
import 'package:duet_clinic/pages/patientDashboard/bookAppointmentForm.dart';
import 'package:duet_clinic/services/backend.dart';
import 'package:duet_clinic/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HospitalProfile extends StatefulWidget {
  String uid;

  HospitalProfile({Key? key, this.uid = ''}) : super(key: key);

  @override
  _HospitalProfileState createState() => _HospitalProfileState();
}

class _HospitalProfileState extends State<HospitalProfile> {
  Doctor? doctor;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getDoctorDetails();
  }

  void getDoctorDetails() async {
    setState(() => isLoading = true);
    DocumentSnapshot doc = await doctorCollection.doc(widget.uid).get();

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
      counter: doc["counter"],
      uid: widget.uid,
    );
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(title: Text(doctor!.clinicName!), backgroundColor: Colors.teal),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                        radius: 60,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Center(
                    child: Text(
                      doctor!.clinicName!,
                      style: const TextStyle(
                        fontSize: 35,
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
                  const Center(
                    child: Text(
                      'Current appointment number being attended to : ',
                      style: TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Center(
                    child: FlatButton(
                      onPressed: () {},
                      color: Colors.teal[400],
                      child: Text(doctor!.counter.toString(), style: const TextStyle(fontSize: 24, color: Colors.white)),
                    ),
                  ),
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
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                          ],
                        )),
                  ),
                  const SizedBox(height: 70),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                    child: FlatButton(
                      color: Colors.teal,
                      child: const Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Book Appointment',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (BuildContext context) => BookAppointment(doctor: doctor!)));
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          );
  }
}
