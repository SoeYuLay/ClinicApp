import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/screens/booking_screen.dart';
import 'package:flutter_clinic_app/screens/home_screen.dart';
import 'package:flutter_clinic_app/screens/myDoctor_screen.dart';
import 'package:flutter_clinic_app/screens/profile_screen.dart';
import 'package:flutter_clinic_app/widgets/bottomNavBar.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({super.key});

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    HomeScreen(),
    BookingScreen(),
    MyDoctorScreen(),
    ProfileScreen()
  ];

  void _NavItemOnTap (int index){
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavBar(_selectedIndex,_NavItemOnTap),
    );
  }
}
