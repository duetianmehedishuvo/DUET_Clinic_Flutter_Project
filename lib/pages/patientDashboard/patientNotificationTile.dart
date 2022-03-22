import 'package:duet_clinic/model/appointment.dart';
import 'package:duet_clinic/pages/patientDashboard/AppointmentFormStatus.dart';
import 'package:flutter/material.dart';

class PatNotTile extends StatelessWidget {
  Appointment? appointment;
  String msg = "";
  Icon? icon;

  PatNotTile({Key? key, this.appointment}) : super(key: key) {
    msg = appointment!.confirmed
        ? "Your Appointment in ${appointment!.clinicName} is confirmed "
        : "Your Appointment in ${appointment!.clinicName} is pending";
    icon = appointment!.confirmed
        ? const Icon(Icons.check_box, color: Colors.green, size: 30)
        : const Icon(Icons.pending_actions, color: Colors.red, size: 30);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => AppointmentFormStatus(appointment: appointment!)));
      },
      child: Card(
          child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(children: [Expanded(child: Text(msg, style: const TextStyle(fontSize: 17))), icon!]))),
    );
  }
}
