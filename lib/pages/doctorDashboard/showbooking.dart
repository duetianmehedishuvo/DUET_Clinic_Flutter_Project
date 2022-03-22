import 'package:clinico/pages/role.dart';
import 'package:clinico/services/backend.dart';
import 'package:flutter/material.dart';

class ShowBooking extends StatelessWidget {
  const ShowBooking({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text("Your Appointment"),backgroundColor: Colors.indigo,),
      body:Backend().showDoctorNotification(currentUser.uid)
    );
  }
}