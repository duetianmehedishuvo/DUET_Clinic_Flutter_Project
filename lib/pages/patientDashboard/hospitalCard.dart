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
                  uid: doctor!.uid!, categoryName: Provider.of<TestProvider>(context, listen: false).selectCategory),
            ));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20,left: 16,right: 16),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(80), child: Image.network(doctor!.photoURL!, width: 50, height: 50))),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dr. ' + doctor!.displayName!, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(Provider.of<TestProvider>(context,listen: false).selectCategory, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text('clinic: ${doctor!.clinicName!}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Card buildCard() {
    return Card(
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
    );
  }
}

class HospitalCard2 extends StatelessWidget {
  double pad = 70;
  ShortDoctor? doctor;

  HospitalCard2({Key? key, this.doctor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HospitalProfile(uid: doctor!.uId!, categoryName: doctor!.categoryName!)));
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(80), child: Image.network(doctor!.image!, width: 50, height: 50))),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Dr. ' + doctor!.name!, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 2),
                  Text(doctor!.categoryName!, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text('clinic: ${doctor!.clinicName!}', style: const TextStyle(fontSize: 17, fontWeight: FontWeight.normal)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
