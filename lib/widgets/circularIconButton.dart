import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({super.key, required this.icon, required this.onPressed, required this.borderColor});

  final Icon icon;
  final VoidCallback onPressed;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: ShapeDecoration(
          color: AppColor.bgColor,
            shape: CircleBorder(
              side: BorderSide(
                color: borderColor
              )
            )),
        child: IconButton(
            onPressed: onPressed,
            icon: icon
        ),
      ),
    );
  }
}
