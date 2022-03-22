import 'package:clinico/model/appointment.dart';
import 'package:clinico/pages/role.dart';
import 'package:clinico/services/backend.dart';
import 'package:clinico/shared/loading.dart';
import 'package:flutter/material.dart';

class ConfirmAppointment extends StatefulWidget {
  Appointment? appointment;
  String msg = '';

  ConfirmAppointment({Key? key, this.appointment, this.msg = ''}) : super(key: key);

  @override
  _ConfirmAppointmentState createState() => _ConfirmAppointmentState();
}

class _ConfirmAppointmentState extends State<ConfirmAppointment> {
  TextEditingController appointmentNumberController = TextEditingController();
  bool isLoading = false, validAppointmentNumber = true;

  void getAppointmentFormInfo() async {
    setState(() {
      isLoading = true;
    });
    setState(() => isLoading = false);
  }

  void confirmAppointmentNumber() async {
    String appointment = appointmentNumberController.text.trim();
    setState(() => validAppointmentNumber = appointment.isNotEmpty);
    if (validAppointmentNumber) {
      setState(() => isLoading = true);
      int appointmentNumber = int.parse(appointment);
      await Backend().confirmBooking(currentUser.uid, widget.appointment!.patientId, appointmentNumber,
          widget.appointment!.patientAppointmentId, widget.appointment!.doctorAppointmentId);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Loading()
        : Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.indigo,
            title: const Text('Appointment Status', style: TextStyle(color: Colors.white)),
          ),
          body: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(15, 8, 15, 8),
              child: ListView(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child: Text(
                      widget.appointment!.clinicName,
                      style: const TextStyle(
                        fontSize: 30,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Name : ' + widget.appointment!.name,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Age : ' + widget.appointment!.age.toString(),
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Gender : ' + widget.appointment!.gender,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Comments : ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    widget.appointment!.comment,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'Payment Screenshot : ',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        widget.appointment!.stringimage,
                        height: 800,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: appointmentNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.grey[50],
                      hintText: "allot an appointment number to this patient",
                      border: const OutlineInputBorder(),
                      labelText: "Enter an Appointment Number",
                      errorText: validAppointmentNumber ? null : "Appointment number can't be empty",
                    ),
                  ),
                  const SizedBox(height: 50),
                  FlatButton(
                    child: const Text('Confirm', style: TextStyle(color: Colors.white, fontSize: 18)),
                    color: Colors.indigoAccent,
                    onPressed: () {
                      confirmAppointmentNumber();
                    },
                  ),
                ],
              ),
            ),
          ),
        );
  }
}
