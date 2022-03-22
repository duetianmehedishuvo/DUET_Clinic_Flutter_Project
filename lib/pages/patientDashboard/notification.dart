import 'package:duet_clinic/pages/role.dart';
import 'package:duet_clinic/services/backend.dart';
import 'package:flutter/material.dart';

class ShowNotification extends StatelessWidget {
  const ShowNotification({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Your Appointment"), backgroundColor: Colors.teal),
        body: Backend().showPatientNotification(currentUser.uid));
  }
}
