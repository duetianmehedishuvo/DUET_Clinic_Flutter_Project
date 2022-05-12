import 'package:duet_clinic/model/appointment.dart';
import 'package:duet_clinic/model/user.dart';
import 'package:duet_clinic/pages/patientDashboard/notification.dart';
import 'package:duet_clinic/pages/role.dart';
import 'package:duet_clinic/services/backend.dart';
import 'package:duet_clinic/shared/loading.dart';
import 'package:flutter/material.dart';

class BookAppointment extends StatefulWidget {
  Doctor? doctor;
  BookAppointment({Key? key, this.doctor}) : super(key: key);

  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  bool validName=true,validAge = true,validGender = true,isLoading = false;



  void bookAppointment()async{
    String name = nameController.text.trim();
    String age = ageController.text.trim();
    String gender = genderController.text.trim();
    String comment = commentController.text.trim();
    setState((){
      validName = name.isNotEmpty;
      validAge = age.isNotEmpty;
      validGender = gender.isNotEmpty;
    });
    if(validName && validAge && validGender){
      setState(()=>isLoading = true);
      Appointment appoit = Appointment(
        name:name,
        age:int.parse(age),
        gender: gender,
        comment: comment,
        clinicName:widget.doctor!.clinicName!,
      );
      await Backend().bookAppointment(appoit,widget.doctor!.uid!,currentUser.uid);
      Navigator.pop(context);
      Navigator.pop(context);
      Navigator.push(context,MaterialPageRoute(builder:(BuildContext context)=>const ShowNotification()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:const Text("Book Appointment")),
      body: isLoading?const Loading():Padding(
        padding: const EdgeInsets.all(13.0),
        child: ListView(
          children:[
            Center(
              child:Text(widget.doctor!.clinicName!,style: const TextStyle(fontSize:30),)
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: nameController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                hintText: "Enter Patient Name",
                border: const OutlineInputBorder(),
                labelText: "Name",
                errorText: validName?null:"Name Can't Be Empty"
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                hintText: "Enter Patient Age",
                border: const OutlineInputBorder(),
                labelText: "Age",
                errorText: validAge?null:"Age Can't Be Empty"
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: genderController,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                hintText: "Enter Patient Gender",
                border: const OutlineInputBorder(),
                labelText: "Gender",
                errorText: validGender?null:"Gender Can't Be Empty"
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              controller: commentController,
              keyboardType: TextInputType.multiline,
              maxLines: null,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[50],
                hintText: "Add Edition Comment",
                border: const OutlineInputBorder(),
                labelText: "Comment(optional)",
              ),
            ),
            const SizedBox(height:40),


              RaisedButton(
                child: const Text("Submit"),
                onPressed: (){bookAppointment();},
              )
          ]
        ),
      ),
    );
  }
}