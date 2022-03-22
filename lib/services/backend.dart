import 'dart:io';
import 'package:clinico/pages/doctorDashboard/doctorNotificationTile.dart';
import 'package:clinico/pages/patientDashboard/patientNotificationTile.dart';
import 'package:uuid/uuid.dart';
import 'package:clinico/model/appointment.dart';
import 'package:clinico/model/user.dart';
import 'package:clinico/pages/patientDashboard/hospitalCard.dart';
import 'package:clinico/shared/loading.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;

var uuid = const Uuid();

FirebaseStorage storageRef = FirebaseStorage.instance;
final CollectionReference doctorCollection =
    FirebaseFirestore.instance.collection('doctors');
final CollectionReference patientCollection =
    FirebaseFirestore.instance.collection('patients');
final CollectionReference doctornotificationCollection =
    FirebaseFirestore.instance.collection('doctornotification');

class Backend{
    Future<void> addDoctorInDataBase(Doctor doctor)async{
      await doctorCollection.doc(doctor.uid).set({
         "clinicName":doctor.clinicName,
         "educationalQualification":doctor.educationalQualification,
         "timing":doctor.timing,
         "address":doctor.address,
         "fee":doctor.fee,
         "paymentMethod":doctor.paymentMethod, 
         "bio":doctor.bio,
         "displayName":doctor.displayName,
         "email":doctor.email,
         "photoURL":doctor.photoURL,
         "searchedText":doctor.clinicName!.toLowerCase(),
         "counter":0
      });
    }

  Future<void> updateDoctorData(Doctor doctor)async{
     await doctorCollection.doc(doctor.uid).update({
         "clinicName":doctor.clinicName,
         "educationalQualification":doctor.educationalQualification,
         "timing":doctor.timing,
         "address":doctor.address,
         "fee":doctor.fee,
         "paymentMethod":doctor.paymentMethod, 
         "bio":doctor.bio,
         "searchedText":doctor.clinicName!.toLowerCase(),
      });
  }

  Future<void> bookAppointment(Appointment appoint,String doctorId,String patientId)async{
    final postID = uuid.v4();
    var image = await compressImage(appoint.image, postID);
    var let = await uploadImage(image, postID);
    var media = let;
    await doctorCollection.doc(doctorId).collection("appointment").add({
        "name":appoint.name,
        "gender":appoint.gender,
        "age":appoint.age,
        "comment":appoint.comment,
        "image":media,
        "confirmed":false,
        "appointmentNumber":0,
        "time":DateTime.now().millisecondsSinceEpoch,
        "patientId":patientId,
        "patientAppointmentId":postID,
        "clinicName":appoint.clinicName
    });

    await patientCollection.doc(patientId).collection("appointment").doc(postID).set({
        "name":appoint.name,
        "gender":appoint.gender,
        "age":appoint.age,
        "comment":appoint.comment,
        "image":media,
        "confirmed":false,
        "appointmentNumber":0,
        "time":DateTime.now().millisecondsSinceEpoch,
        "doctorId":doctorId,
        "clinicName":appoint.clinicName
    });
  }

  showAllHospitalCard() {
    return StreamBuilder(
        stream: doctorCollection.snapshots(),
        builder: (context,AsyncSnapshot  snapshot) {
          if (!snapshot.hasData) {
            return const Loading();
          }
          List<HospitalCard> allhospital = [];
          snapshot.data.docs.forEach((doc) {
            allhospital.add(HospitalCard(
              doctor: Doctor(
                address: doc.data()["address"],
                bio: doc.data()["bio"],
                clinicName: doc.data()["clinicName"],
                displayName: doc.data()["displayName"],
                educationalQualification:
                    doc.data()["educationalQualification"],
                email: doc.data()["email"],
                fee: doc.data()["fee"],
                paymentMethod: doc.data()["paymentMethod"],
                photoURL: doc.data()["photoURL"],
                timing: doc.data()["timing"],
                uid: doc.id,
                counter:doc.data()["counter"]
              ),
            ));
          });
          return Column(children: allhospital);
        });
  }

  Future compressImage(_image, postId) async {
    Directory temDir = await getTemporaryDirectory();
    final temPath = temDir.path;
    Im.Image? imageFile = Im.decodeImage(_image.readAsBytesSync());
    final compressImageFile = File('$temPath/img_$postId.jpg')
      ..writeAsBytesSync(Im.encodeJpg(imageFile!, quality: 85));
    _image = compressImageFile;
    return _image;
  }

  Future<String> uploadImage(_image, postId) async {
    int id = DateTime.now().millisecondsSinceEpoch;
    UploadTask uploadTask =
        storageRef.ref().child('post$id _$postId.jpg').putFile(_image);

    String downloadURL =  await (await uploadTask).ref.getDownloadURL();

    return downloadURL;
  }

    Future<void> AddPatient(MyUser user)async{
      await patientCollection.doc(user.uid).set({
        "name":user.displayName,
        "email":user.email,
        "photoURL":user.photoURL,
      });
    }

    showPatientNotification(String patientId){
       return StreamBuilder(
         stream: patientCollection.doc(patientId).collection("appointment").orderBy("time",descending:true).snapshots(),
         builder: (context,AsyncSnapshot snapshot){
           if(!snapshot.hasData){
             return const Loading();
           }
           List<PatNotTile> allPatientNotification = [];
           snapshot.data.docs.forEach((doc){
              allPatientNotification.add(
                PatNotTile(
                  appointment: Appointment(
                    name:doc.data()["name"],
                    gender:doc.data()["gender"],
                    age:doc.data()["age"],
                    comment:doc.data()["comment"],
                    stringimage:doc.data()["image"],
                    confirmed:doc.data()["confirmed"],
                    appointmentNumber:doc.data()["appointmentNumber"],
                    clinicName:doc.data()["clinicName"],
                    doctorId: doc.data()["doctorId"]
                  ),
                )
              );
           });
           if(allPatientNotification.isEmpty){
             return const Center(
               child:Text("No Notification")
             );
           }
           return ListView(
             children: allPatientNotification,
           );
         },
       );
    }

    Future<void> confirmBooking(String doctorId,String patientId,int appointmentNumber,String patientAppointmentId,String doctorAppointmentId)async{
      await doctorCollection.doc(doctorId).collection("appointment").doc(doctorAppointmentId).update({
        "confirmed":true,
        "appointmentNumber":appointmentNumber
      });
      await patientCollection.doc(patientId).collection("appointment").doc(patientAppointmentId).update({
        "confirmed":true,
        "appointmentNumber":appointmentNumber
      });
    }

    showDoctorNotification(String doctorId){
      return StreamBuilder(
        stream:doctorCollection.doc(doctorId).collection("appointment").orderBy("time",descending:true).snapshots(),
        builder:(context,AsyncSnapshot snapshot){
          if(!snapshot.hasData){
            return const Loading();
          }
          List<DocNotTile> waitingTile = [];
          List<DocNotTile> confirmedTile = [];
          snapshot.data.docs.forEach((doc){
            doc.data()["confirmed"]?confirmedTile.add(
                DocNotTile(
                  appointment: Appointment(
                    name:doc.data()["name"],
                    gender:doc.data()["gender"],
                    age:doc.data()["age"],
                    comment:doc.data()["comment"],
                    stringimage:doc.data()["image"],
                    confirmed:doc.data()["confirmed"],
                    appointmentNumber:doc.data()["appointmentNumber"],
                    clinicName:doc.data()["clinicName"],
                    patientId: doc.data()["patientId"],
                    patientAppointmentId:doc.data()["patientAppointmentId"],
                    doctorAppointmentId:doc.id
                  ),
                )
              ):waitingTile.add(
                DocNotTile(
                  appointment: Appointment(
                    name:doc.data()["name"],
                    gender:doc.data()["gender"],
                    age:doc.data()["age"],
                    comment:doc.data()["comment"],
                    stringimage:doc.data()["image"],
                    confirmed:doc.data()["confirmed"],
                    appointmentNumber:doc.data()["appointmentNumber"],
                    clinicName:doc.data()["clinicName"],
                    patientId: doc.data()["patientId"],
                    patientAppointmentId:doc.data()["patientAppointmentId"],
                    doctorAppointmentId:doc.id
                  ),
                )
              );
          });
          return Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                const SizedBox(height:10),
                const Text("Pending Appointment",style: TextStyle(fontSize:17),),
                const SizedBox(height:20),
                waitingTile.isEmpty?const Center(child: Text("No Pending Appointment")):Column(
                  children:waitingTile
                ),
                const SizedBox(height:40),
                const Text("Booked Appointment",style: TextStyle(fontSize:17)),
                const SizedBox(height:20),
                confirmedTile.isEmpty?const Center(child: Text("No Appointment Booked")):Column(
                  children:confirmedTile
                ),
              ],
            ),
          );
        }
      );
    }

    SearchHospital(String key){
      return StreamBuilder(
        stream: doctorCollection.where("searchedText",isGreaterThanOrEqualTo: key).snapshots(),
        builder: (context,AsyncSnapshot  snapshot){
          if(!snapshot.hasData){
            return const Loading();
          }
          List<HospitalCard> allhospital = [];
          snapshot.data.docs.forEach((doc){
              allhospital.add(
                HospitalCard(
                  doctor: Doctor(
                    address: doc.data()["address"],
                    bio: doc.data()["bio"],
                    clinicName: doc.data()["clinicName"],
                    displayName: doc.data()["displayName"],
                    educationalQualification:
                        doc.data()["educationalQualification"],
                    email: doc.data()["email"],
                    fee: doc.data()["fee"],
                    paymentMethod: doc.data()["paymentMethod"],
                    photoURL: doc.data()["photoURL"],
                    timing: doc.data()["timing"],
                    uid: doc.id,
                  ),
                )
              );
          });
          if(allhospital.isEmpty){
            return Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(13.0),
                  child: Center(
                    child:Text(
                      "Look like there is no great match according to your search.",
                      style: TextStyle(fontSize: 18)
                    )
                  ),
                ),
                const Center(
                  child:Text(
                    "Other Hospital",
                    style: TextStyle(fontSize: 18)
                  )
                ),
                showAllHospitalCard()
              ],
            );
          }
          return Column(
            children: allhospital,
          );
        }
      );
    }
}
