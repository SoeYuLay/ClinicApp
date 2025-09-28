import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/onBoardingController.dart';
import 'package:flutter_clinic_app/models/onBoard.dart';
import 'package:flutter_clinic_app/screens/emailOTP_screen.dart';
import 'package:flutter_clinic_app/screens/emailRegister_screen.dart';
import 'package:flutter_clinic_app/screens/getStarted_screen.dart';
import 'package:flutter_clinic_app/screens/login_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:get/get.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final oBData = Get.put<OnBoardingController>(OnBoardingController());


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
                child: Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                          oBData.onBoardData.length,
                          (index)=> AnimatedContainer(
                              duration: const Duration(milliseconds: 300),
                              height: 5,
                            width: 70,
                            decoration: BoxDecoration(
                              color: oBData.currentPage.value == index
                                  ? AppColor.primaryColor
                                  : Colors.grey[400],
                              borderRadius: BorderRadius.circular(5)
                            ),
                          ))
                    )
                ),
            ),
            Expanded(
              flex: 6,
              child: PageView.builder(
                itemCount: oBData.onBoardData.length,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index){
                    oBData.currentPage.value = index;
                  },
                  itemBuilder: (context,index){
                  return Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(oBData.onBoardData[index].title,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),),
                        Image.asset(oBData.onBoardData[index].image,width: 350,height: 350,),
                      const SizedBox(height: 40),
                      ],
                    ),
                  );
                  }),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: AppColor.bgColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      )
                  ),
                  onPressed: ()=> Get.to(()=> GetStartedScreen()),
                  child: Text('Create An Account',style: TextStyle(fontSize: 18))),
            ),
            SizedBox(height: 20,),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 0,
                      backgroundColor: AppColor.bgColor,
                      side: BorderSide(
                          color: Colors.grey.shade300
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(40))
                      )
                  ),
                  onPressed: () => Get.to(()=> GetStartedScreen()),
                  child: Text('Login',style: TextStyle(fontSize: 18,color: Colors.black))),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
