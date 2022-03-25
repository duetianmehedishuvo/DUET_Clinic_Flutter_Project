import 'package:duet_clinic/pages/patientDashboard/notification.dart';
import 'package:duet_clinic/pages/patientDashboard/patientDashboard.dart';
import 'package:duet_clinic/pages/patientDashboard/patientInfo.dart';
import 'package:flutter/material.dart';

class Patientbottonbar extends StatefulWidget {
  const Patientbottonbar({Key? key}) : super(key: key);

  @override
  _PatientbottonbarState createState() => _PatientbottonbarState();
}

class _PatientbottonbarState extends State<Patientbottonbar> {
  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int pageIndex) {
    setState(() => {
          this.pageIndex = pageIndex,
        });
  }

  onTap(int pageIndex) {
    pageController.animateToPage(
      pageIndex,
      duration: const Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: const <Widget>[PatientDashboard(), ShowNotification(), PatientInfo()],
        controller: pageController,
        onPageChanged: onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        unselectedItemColor: Colors.grey[700],
        selectedItemColor: Colors.teal,
        onTap: onTap,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.notifications_active), label: 'Notifications'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: 'User'),
        ],
      ),
    );
  }
}
