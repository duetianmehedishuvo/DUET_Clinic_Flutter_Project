import 'package:duet_clinic/pages/doctorDashboard/doctorCounter.dart';
import 'package:duet_clinic/pages/doctorDashboard/doctorDashboard.dart';
import 'package:duet_clinic/pages/doctorDashboard/showbooking.dart';
import 'package:flutter/material.dart';

class DoctorBottom extends StatefulWidget {
  const DoctorBottom({Key? key}) : super(key: key);

  @override
  _DoctorBottomState createState() => _DoctorBottomState();
}

class _DoctorBottomState extends State<DoctorBottom> {
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
        children: const <Widget>[DoctorDashboard(), ShowBooking(), DoctorCounter()],
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
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              label: 'Home',),
          BottomNavigationBarItem(
              icon: Icon(Icons.notifications_active),
              label: 'Notifications'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_hospital),
              label: 'Counter',),
        ],
      ),
    );
  }
}
