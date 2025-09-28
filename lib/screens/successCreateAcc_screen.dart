import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/bottomNavController.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:get/get.dart';
class SuccessCreateAccount extends StatelessWidget {
  const SuccessCreateAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
        child: SafeArea(
          child: Column(
            children: [
          
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius:
                        const BorderRadius.all(Radius.circular(100.0)),
                        child: Image.asset('assets/images/rightClick.png',
                            width: 200, height: 200),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Success create account',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Book appointments, consult with specialists, and stay on top of your health goals with ease',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: AppColor.bgColor,
                      iconSize: 25,
                      iconColor: AppColor.bgColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      )
                  ),
                  onPressed: ()=>Get.to(()=>BottomNavController()),
                  child: Text('Continue',style: TextStyle(fontSize: 18)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
