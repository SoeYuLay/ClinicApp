import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/widgets/myDoctorListCard.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../utils/constants/app_colors.dart';

class MyDoctorScreen extends StatefulWidget {
  const MyDoctorScreen({super.key});

  @override
  State<MyDoctorScreen> createState() => _MyDoctorScreenState();
}

class _MyDoctorScreenState extends State<MyDoctorScreen> {
  bool isSaved = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  decoration: BoxDecoration(
                    color: AppColor.bgColor,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('My Doctor',
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade300),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ToggleSwitch(
                            minWidth: double.infinity,
                            cornerRadius: 20.0,
                            activeBgColor: [Colors.white],
                            activeFgColor: Colors.black,
                            inactiveBgColor: Colors.grey.shade300,
                            inactiveFgColor: Colors.grey.shade800,
                            initialLabelIndex: isSaved ? 1 : 0,
                            totalSwitches: 2,
                            labels: ['Booked', 'Saved'],
                            radiusStyle: true,
                            onToggle: (index) {
                              setState(() {
                                isSaved = (index == 1);
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                MyDoctorListCard(isSaved: isSaved)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
