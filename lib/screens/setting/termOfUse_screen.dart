import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import '../../utils/constants/app_colors.dart';
import '../../widgets/circularIconButton.dart';

class TermOfUseScreen extends StatelessWidget {
  const TermOfUseScreen({super.key});

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
                    const SizedBox(width: 95),
                    Center(
                      child: Text('Terms of use',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                    ),
                  ],
                ),
              ],
            ),
          ),)
    );
  }
}
