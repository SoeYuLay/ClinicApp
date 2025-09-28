import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/otp_controller.dart';
import 'package:flutter_clinic_app/screens/completeProfile_screen.dart';
import 'package:flutter_clinic_app/screens/createAccount_screen.dart';
import 'package:flutter_clinic_app/utils/constants/app_colors.dart';
import 'package:flutter_clinic_app/widgets/OTPInput.dart';
import 'package:get/get.dart';
import 'package:timer_button/timer_button.dart';

import '../controllers/registerController.dart';

class EmailOTPScreen extends StatefulWidget {
  const EmailOTPScreen({super.key});

  @override
  State<EmailOTPScreen> createState() => _EmailOTPScreenState();
}

class _EmailOTPScreenState extends State<EmailOTPScreen> {
  TextEditingController pin = TextEditingController();
  final registerController = Get.find<RegisterController>();
  final otpController = Get.put(OtpController());

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
                              backgroundColor: Colors.grey[300],
                              color: AppColor.primaryColor,
                            ),
                          )),
                    )
                  ],
                ),
                Divider(),
                Text(
                  'Enter OTP code',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                const SizedBox(height: 10),
                Text(
                  'To verify your email please enter OTP code we sent to your email', //<====== email = '******02@gmail.com'
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 50),
                OTPInput(pinController: pin),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Enter wrong number?',
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                    TextButton(
                      onPressed: () => pin.clear(),
                      child: Text(
                        'Re-enter',
                        style:
                            TextStyle(color: AppColor.primaryColor, fontSize: 15),
                      ),
                    )
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColor.primaryColor,
                          foregroundColor: AppColor.bgColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(40)))),
                      onPressed: otpController.isLoading.value ? null : () async {
                        final otp = pin.text.trim();
                        if(otp.isEmpty){
                          Get.snackbar('Error', 'Please enter OTP');
                          return;
                        }
          
                        final result = await otpController.verifyOTP(registerController.userEmail, otp);
          
                        if(result['success']){
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result['message'])),
                          );
                          registerController.nextPage();
                          Get.to(()=>CreateaccountScreen());
                        }else{
                          Get.snackbar(
                            'Error',
                            result['message'] ?? 'OTP Verification Failed',
                          );
                        }
                      },
          
                      child: otpController.isLoading.value
                          ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                          : const Text('Continue', style: TextStyle(fontSize: 18)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: double.infinity,
                  child: TimerButton(
                      label: "Resend code",
                      activeTextStyle: const TextStyle(
                        fontSize: 18,
                        color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold
                      ),
                      disabledTextStyle: const TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold
                      ),
                      onPressed: () async{
          
                        final result = await otpController.resendOTP(registerController.userEmail);
          
                        if(result['success']){
                          await registerController.sendOTP(registerController.userEmail);

                          Get.snackbar('Success', 'Resent OTP Successfully');

                        }else{
                          Get.snackbar(
                            'Error',
                            result['message'] ?? 'OTP Verification Failed',
                          );
                        }
                      },
                      timeOutInSeconds: 10,
                      buttonType: ButtonType.outlinedButton,
                      color: AppColor.primaryColor,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
