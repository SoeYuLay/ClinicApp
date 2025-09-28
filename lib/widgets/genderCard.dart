import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/models/gender.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';

class GenderCard extends StatelessWidget {
  GenderCard({super.key,required this.gender});
  Gender gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 180,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(
            color: AppColor.primaryColor
          )
        ),

        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                gender.iconData,
                color: gender.isSelected ? AppColor.primaryColor : Colors.black,
                size: 30
              ),
              const SizedBox(width: 5,),
              Text(
                  gender.type,
                style: TextStyle(
                  color: gender.isSelected ? AppColor.primaryColor : Colors.black,
                  fontSize: 18
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
