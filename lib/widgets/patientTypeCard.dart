import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class PatientTypeCard extends StatelessWidget {
  const PatientTypeCard({super.key, required this.isSelected, required this.patientType});
  final bool isSelected;
  final String patientType;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      margin: EdgeInsets.symmetric(horizontal: 6, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isSelected ? AppColor.primaryColor : Colors.grey.shade500,
        ),
        color: isSelected ? Color(0xFFEBEEFA) : Colors.white,
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(patientType,style: TextStyle(fontSize: 18))
          ],
        ),
      ),
    );
  }
}
