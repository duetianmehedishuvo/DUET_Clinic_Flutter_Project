import 'package:clinico/model/user.dart';
import 'package:clinico/pages/doctorDashboard/doctorBottomBar.dart';
import 'package:clinico/pages/patientDashboard/patientBottomBar.dart';
import 'package:clinico/pages/role.dart';
import 'package:clinico/services/backend.dart';
import 'package:clinico/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LoggedWrapper extends StatefulWidget {
  MyUser? user;

  LoggedWrapper({Key? key, this.user}) : super(key: key);

  @override
  _LoggedWrapperState createState() => _LoggedWrapperState();
}

class _LoggedWrapperState extends State<LoggedWrapper> {
  bool isLoading = true;
  bool isDoctor = false, isPatient = false;

  @override
  void initState() {
    super.initState();

    print('shuvo owow ${widget.user!.uid}');

    getInfo();
  }

  void getInfo() async {
    DocumentSnapshot docColl = await doctorCollection.doc(widget.user!.uid).get();
    bool temdoc = false, temPat = false;
    temdoc = docColl.exists;
    if (!temdoc) {
      DocumentSnapshot patColl = await patientCollection.doc(widget.user!.uid).get();
      temPat = patColl.exists;
      if (temPat) {
        currentUser = widget.user!;
        currentUser.isDoctor = false;
      }
    } else {
      currentUser = widget.user!;
      currentUser.isDoctor = true;
    }
    setState(() {
      isDoctor = temdoc;
      isPatient = temPat;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? const Loading() : (isDoctor ? const DoctorBottom() : (isPatient ? const Patientbottonbar() : Role(user: widget.user)));
  }
}