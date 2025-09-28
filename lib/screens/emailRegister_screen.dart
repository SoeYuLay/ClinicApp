import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/screens/emailOTP_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:get/get.dart';

import '../controllers/registerController.dart';

class EmailRegisterScreen extends StatefulWidget {
  const EmailRegisterScreen({super.key});

  @override
  State<EmailRegisterScreen> createState() => _EmailRegisterScreenState();
}

class _EmailRegisterScreenState extends State<EmailRegisterScreen> {
  TextEditingController emailController = TextEditingController();
  final registerController = Get.find<RegisterController>();
  bool emailValidate = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          registerController.previousPage();
                          Get.back();
                        },
                        icon: Icon(
                          Icons.arrow_circle_left_outlined,
                          size: 35,
                        )),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: Obx(() => ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: registerController.progress / 4.0,
                              minHeight: 5,
                              color: AppColor.primaryColor,
                              backgroundColor: Colors.grey[300],
                            ),
                          )),
                    )
                  ],
                ),
                Divider(),
                Text(
                  'Enter your Email',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  'Please enter your email to get verification code to get continuing',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 30),
                Text(
                  'Email',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                TextField(
                    controller: emailController,
                    keyboardType: TextInputType.text,
                    decoration: InputDecoration(
                        hintText: 'Enter email',
                        errorText:
                            emailValidate == false ? 'Email cannot be empty' : null,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0)))),
                const SizedBox(height: 30),
                Obx(
                  () => registerController.isLoading.value
                      ? Center(child: CircularProgressIndicator())
                      : SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                foregroundColor: AppColor.bgColor,
                                iconSize: 25,
                                iconColor: AppColor.bgColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(40)))),
                            onPressed: () async {
                              if(emailController.text.isEmpty){
                                registerController.errorMessage.value =
                                "Email cannot be empty";
                                return;
                              }
                              final result= await registerController.sendOTP(emailController.text.trim());
            
                              if(result['success']){
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(content: Text(result['message'])),
                                // );
                                Get.to(() => EmailOTPScreen());
                              }else{
                                Get.snackbar(
                                  'Error',
                                  result['message'] ?? 'Registration failed. Please try again.',
                                );
                              }
                            },
                            child:
                                Text('Send me OTP', style: TextStyle(fontSize: 18)),
                          ),
                        ),
                ),
                Obx(() => Text(
                  registerController.errorMessage.value,
                  style: TextStyle(color: Colors.red),
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
