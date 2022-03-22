import 'package:duet_clinic/pages/role.dart';
import 'package:duet_clinic/services/auth.dart';
import 'package:flutter/material.dart';

class PatientInfo extends StatelessWidget {
  const PatientInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(backgroundColor:Colors.teal,title:const Text("Profile")),
        body:ListView(
            children: [
              Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 20),
                    child:  CircleAvatar(
                        backgroundImage: NetworkImage(currentUser.photoURL),
                        radius: 50,
                      ),
                    ),
                  ),
               const SizedBox(height: 25),
              Center(
                  child: Text(
                    currentUser.displayName,
                    style: const TextStyle(
                      fontSize: 18,
                      letterSpacing: 2,
                    ),
              )),
              const SizedBox(height: 10),
              Center(
                child: Text(currentUser.email,
                    style: const TextStyle(
                      fontFamily: 'Futura',
                      color: Colors.black45,
                      fontSize: 15,
                      letterSpacing: 1,
                    )),
              ),
              const SizedBox(height:20),
              Center(
                child:RaisedButton(
                  child: const Text("Log Out",style: TextStyle(fontSize:16,color:Colors.white),),
                  onPressed: (){
                    // Navigator.pop(context);
                    AuthServices().signOutGoogle();
                  },
                  color: Colors.teal,
                )
              )
            ]
        )
    );     
  }
}