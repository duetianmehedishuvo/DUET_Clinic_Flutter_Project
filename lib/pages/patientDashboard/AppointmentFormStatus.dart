import 'package:duet_clinic/model/appointment.dart';
import 'package:duet_clinic/services/backend.dart';
import 'package:duet_clinic/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppointmentFormStatus extends StatefulWidget {
  Appointment? appointment;
  String msg = '';
  int appointmentNumber = 0;
  String categoryName='';

  AppointmentFormStatus({Key? key, this.appointment,this.categoryName=''}) : super(key: key) {
    msg = appointment!.confirmed
        ? "Your Appointment Number is ${appointment!.appointmentNumber}"
        : "Your Appointment in ${appointment!.clinicName} is pending";
  }

  @override
  _AppointmentFormStatusState createState() => _AppointmentFormStatusState();
}

class _AppointmentFormStatusState extends State<AppointmentFormStatus> {
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getAppointmentFormInfo(widget.categoryName);
  }

  void getAppointmentFormInfo(String categoryName) async {
    setState(() {
      isLoading = true;
    });
    DocumentSnapshot doc = await doctorCollection.doc(categoryName).collection(categoryName).doc(widget.appointment!.doctorId).get();
    widget.appointmentNumber = doc["counter"];
    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
            appBar: AppBar(
                backgroundColor: Colors.teal,
                title: const Text('Appointment Status', style: TextStyle(color: Colors.white))),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    Center(child: Text(widget.appointment!.clinicName, style: const TextStyle(fontSize: 30))),
                    const SizedBox(height: 30),
                    Center(
                      child: Text("Current Appointment Number : " + widget.appointmentNumber.toString(),
                          style: const TextStyle(fontSize: 22)),
                    ),
                    const SizedBox(height: 20),
                    const Divider(),
                    const SizedBox(height: 30),
                    Text(widget.msg, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 30),
                    Text('Name : ' + widget.appointment!.name, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 30),
                    Text('Age : ' + widget.appointment!.age.toString(), style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 30),
                    Text('Gender : ' + widget.appointment!.gender, style: const TextStyle(fontSize: 18)),
                    const SizedBox(height: 30),
                    const Text('Comments : ', style: TextStyle(fontSize: 18)),
                    const SizedBox(height: 10),
                    Text(widget.appointment!.comment, style: const TextStyle(fontSize: 18)),

                  ],
                ),
              ),
            ),
          );
  }
}
