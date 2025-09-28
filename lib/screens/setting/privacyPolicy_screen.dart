import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';
import '../../widgets/circularIconButton.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircularIconButton(
                      icon: Icon(
                        Iconsax.arrow_left,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      borderColor: Colors.grey.shade400),
                  const SizedBox(width:  95),
                  Center(
                    child: Text('Privacy policy',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
