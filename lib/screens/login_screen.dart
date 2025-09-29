import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/bottomNavController.dart';
import 'package:flutter_clinic_app/controllers/signInController.dart';
import 'package:flutter_clinic_app/screens/emailRegister_screen.dart';
import 'package:get/get.dart';
import '../utils/constants/app_colors.dart';
import '../utils/constants/image_strings.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController pwdController = TextEditingController();
  final signInController = Get.put(SignInController());
  bool obscure = true;
  bool rmChecked = false;

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
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(height: 10,),
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          hintText: 'Enter email',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0))
                      )
                    ),
                    const SizedBox(height: 20),

                    TextField(
                      obscureText: obscure,
                        controller: pwdController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            hintText: 'Enter password',
                            fillColor: Colors.grey.shade300,
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.grey.shade100,
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                            ),
                          suffixIcon: IconButton(
                              onPressed: (){
                                setState(() {
                                  obscure = !obscure;
                                });
                              },
                              icon: obscure ? Icon(Icons.visibility_off) : Icon(Icons.remove_red_eye))
                        )
                    ),

                    Row(
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Row(
                            children: [
                              Checkbox(
                                  value: rmChecked,
                                  onChanged: (value) => setState(() {
                                    rmChecked = value!;
                                  }),
                                  shape: CircleBorder(),
                                side: BorderSide(
                                  color: Colors.grey.shade500,
                                  width: 1.5
                                ),
                                  ),
                              Text('Remember me',style: TextStyle(color: Colors.grey,fontSize: 16),)
                            ],
                          ),
                        ),

                        Spacer(),

                        Container(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot password?',
                              style: TextStyle(color: AppColor.primaryColor,fontSize: 16),
                            ),
                          ),
                        ),
                      ],
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
                        // onPressed: () async {
                        //   if(emailController.text.isEmpty || pwdController.text.isEmpty){
                        //     signInController.errorMessage.value =
                        //     "Credentials should not be empty";
                        //     return;
                        //   }
                        //   final result= await signInController.signIn(emailController.text.trim(), pwdController.text.trim());
                        //
                        //   if(result['success']){
                        //     // ScaffoldMessenger.of(context).showSnackBar(
                        //     //   SnackBar(content: Text(result['message'])),
                        //     // );
                        //
                        //     Get.to(() => BottomNavController());
                        //   }else{
                        //     Get.snackbar(
                        //       'Error',
                        //       result['message'] ?? 'Sign In failed. Please try again.',
                        //     );
                        //   }
                        // },
                          onPressed: () async {
                            if (emailController.text.isEmpty || pwdController.text.isEmpty) {
                              signInController.errorMessage.value = "Credentials should not be empty";
                              return;
                            }

                            final result = await signInController.signIn(
                              emailController.text.trim(),
                              pwdController.text.trim(),
                            );

                            if (result['success']) {
                              Get.to(() => BottomNavController());
                            } else {
                              Get.snackbar(
                                'Error',
                                result['message'] ?? 'Sign In failed. Please try again.',
                              );
                            }
                          },

                          child: Text('Go to Home',style: TextStyle(fontSize: 18)),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Didn\'t have an account',
                          style: TextStyle(color: Colors.grey,fontSize: 15),
                        ),
                        TextButton(
                          onPressed: () =>Get.to(()=>EmailRegisterScreen()),
                          child: Text(
                            'Register',
                            style: TextStyle(color: AppColor.primaryColor,fontSize: 15),
                          ),
                        )
                      ],
                    ),
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
