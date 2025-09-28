import 'package:flutter/material.dart';

import '../utils/constants/app_colors.dart';

class ChipCard extends StatelessWidget {
  const ChipCard({super.key, required this.labelText, required this.fontsize, required this.circularSize,this.isAvailable=true,this.isSelected=false});
  final String labelText;
  final double fontsize;
  final double circularSize;
  final bool isAvailable;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(labelText,
          style: TextStyle(
              fontSize: fontsize,
              color: isAvailable ? (isSelected ? AppColor.primaryColor : Colors.black) : Colors.grey)),
      padding: EdgeInsets.symmetric(
          horizontal: 2),
      backgroundColor: isAvailable ? (isSelected ? Color(0xFFEBEEFA) : AppColor.bgColor) : Colors.grey.shade100,
      // backgroundColor: isAvailable ? AppColor.bgColor : Colors.grey.shade100,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(circularSize),
        side: BorderSide(color: isAvailable ? (isSelected ? AppColor.primaryColor : Colors.grey) : Colors.grey)
      ),
    );
  }
}
