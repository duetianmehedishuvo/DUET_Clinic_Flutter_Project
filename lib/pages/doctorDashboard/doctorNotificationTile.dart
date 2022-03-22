import 'package:duet_clinic/model/appointment.dart';
import 'package:duet_clinic/pages/doctorDashboard/confirmAppointment.dart';
import 'package:flutter/material.dart';

class DocNotTile extends StatelessWidget {
  Appointment? appointment;
  String msg = '';

  DocNotTile({Key? key, this.appointment}) : super(key: key) {
    msg = appointment!.confirmed
        ? "You Confirmed ${appointment!.name} Appointment"
        : "${appointment!.name} wants to book appointment.";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ConfirmAppointment(
                        appointment: appointment!,
                        msg: msg,
                      )));
        },
        child: Card(
          child: ListTile(
            title: Text(msg),
          ),
        ));
  }
}
