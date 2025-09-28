import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:iconsax/iconsax.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar(this.currentIndex,this.onTapped);

  int currentIndex;
  Function(int) onTapped;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.bgColor,
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 4)
        ],
      ),
      child: BottomNavigationBar(
              currentIndex: currentIndex,
              backgroundColor: Colors.transparent,
              type: BottomNavigationBarType.fixed,
              elevation: 0,
              selectedItemColor: AppColor.primaryColor,
              unselectedItemColor: Colors.grey,
              // showSelectedLabels: false,
              // showUnselectedLabels: false,
              iconSize: 30,
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.calendar_1), label: 'Book'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.medical_information_outlined), label: 'My Doctor'),
                BottomNavigationBarItem(
                    icon: Icon(Iconsax.user_square), label: 'Profile'),
              ],
              onTap: onTapped,
            ),
    );

  }
}

