import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/screens/emailRegister_screen.dart';
import 'package:flutter_clinic_app/screens/login_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/utils/constants/image_strings.dart';
import 'package:get/get.dart';
class GetStartedScreen extends StatefulWidget {
  const GetStartedScreen({super.key});

  @override
  State<GetStartedScreen> createState() => _GetStartedScreenState();
}

class _GetStartedScreenState extends State<GetStartedScreen> {
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   WidgetsBinding.instance.addPostFrameCallback((_){
  //     showBottomSheet(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
              child: Center(child: Image.asset(AppImages.getStartedImage1,))),
          Expanded(
            flex: 2,
            child: Container(
              decoration: BoxDecoration(
                color: AppColor.bgColor,
                borderRadius: BorderRadius.only(topRight: Radius.circular(20),topLeft: Radius.circular(20))
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Let\'s get started',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    const SizedBox(height: 20),
                    Text('Create account now or login if you already have account',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 17),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            foregroundColor: AppColor.bgColor,
                            iconSize: 25,
                            iconColor: AppColor.bgColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(40))
                            )
                        ),
                        onPressed: ()=>Get.to(()=>EmailRegisterScreen()),
                        icon: Icon(Icons.email_outlined),
                        label: Text('Continue with email',style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color: Colors.grey,fontSize: 15),
                        ),
                        TextButton(
                          onPressed: ()=>Get.to(()=>LoginScreen()),
                          child: Text(
                            'Login',
                            style: TextStyle(color: AppColor.primaryColor,fontSize: 15),

                          ),
                        )
                      ],
                    ),
                    // const SizedBox(height: 40,)
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}
