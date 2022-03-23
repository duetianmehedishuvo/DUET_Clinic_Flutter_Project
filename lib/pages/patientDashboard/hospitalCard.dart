import 'package:duet_clinic/model/user.dart';
import 'package:duet_clinic/pages/patientDashboard/hospitalProfile.dart';
import 'package:duet_clinic/services/testProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HospitalCard extends StatelessWidget {
  double pad = 70;
  Doctor? doctor;

  HospitalCard({Key? key, this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HospitalProfile(
                uid: doctor!.uid!,
                categoryName: Provider.of<TestProvider>(context, listen: false).selectCategory,
              ),
            ));
      },
      child: Card(
        margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(28.0, 15.0, 24.0, 15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                doctor!.clinicName!,
                style: TextStyle(
                  fontSize: 24.0,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: pad),
              GestureDetector(
                child: Text(
                  'Dr. ' + doctor!.displayName!,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.grey[600],
                  ),
                ),
              ),
              const SizedBox(
                height: 2.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
