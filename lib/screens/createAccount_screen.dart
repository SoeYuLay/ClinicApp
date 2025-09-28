import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/screens/completeProfile_screen.dart';
import 'package:get/get.dart';
import '../controllers/registerController.dart';
import '../utils/constants/app_colors.dart';

class CreateaccountScreen extends StatefulWidget {
  const CreateaccountScreen({super.key});

  @override
  State<CreateaccountScreen> createState() => _CreateaccountScreenState();
}

class _CreateaccountScreenState extends State<CreateaccountScreen> {
  bool obscure = true;
  bool uppercaseCheck = false;
  bool symbolCheck = false;
  bool numberCheck = false;
  bool pwdCountCheck = false;

  TextEditingController pwdController = TextEditingController();
  final registerController = Get.find<RegisterController>();
  final emailController = TextEditingController();
  int pwdStrength = 0;
  bool pwdValidate = true;

  @override
  void initState() {
    // TODO: implement initState
    pwdController.addListener(checkPasswordStrength);
    super.initState();
  }

  void checkPasswordStrength(){
    String password = pwdController.text;
    setState(() {
      pwdStrength = 0;

      if(RegExp(r'[A-Z]').hasMatch(password)){ //upper case
        uppercaseCheck = true;
        pwdStrength++;
      }else{
        uppercaseCheck = false;
      }
      if(RegExp(r'[0-9]').hasMatch(password)){ //number
        numberCheck = true;
        pwdStrength++;
      }else{
        numberCheck = false;
      }
      if(RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) { //symbol
        symbolCheck = true;
        pwdStrength++;
      }else{
        symbolCheck = false;
      }
      if(password.length >= 8){
        pwdCountCheck = true;
        pwdStrength++;
      }else{
        pwdCountCheck = false;
      }
    });
  }

  @override
  void dispose() {
    pwdController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: (){
                                registerController.previousPage();
                                Get.back();
                              },
                              icon: Icon(Icons.arrow_circle_left_outlined,size: 35,)),
                          const SizedBox(width: 10,),
                          Expanded(
                            child: Obx(()=> ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: registerController.progress/4.0,
                                minHeight: 5,
                                backgroundColor: Colors.grey[300],
                                color: AppColor.primaryColor,
                              ),
                            )),
                          )
                        ],
                      ),
                      Divider(),
                      Text('Create Account',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text('Create a strong password to keep your account safety',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text('Email',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 5),

                      GestureDetector(
                        child: TextField(
                            obscureText: obscure,
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                labelText: registerController.userEmail,
                                enabled: false,
                                fillColor: Colors.grey.shade800,
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.grey.shade500,
                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                            )
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Text('Password',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold
                        ),
                      ),
                      const SizedBox(height: 5),

                      GestureDetector(
                        child: TextField(
                            obscureText: obscure,
                            controller: pwdController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                hintText: 'Enter password',
                                errorText: pwdValidate == false ? 'Password cannot be Empty' : null,
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
                      ),
                      const SizedBox(height: 10),

                      Row(
                        children: [
                          Checkbox(
                            value: uppercaseCheck,
                            onChanged: null,
                            checkColor: Colors.white,
                            shape: CircleBorder(),
                            fillColor: MaterialStateProperty.resolveWith<Color>((states){
                              return uppercaseCheck ? Colors.greenAccent : Colors.red.shade200;
                            }),
                            side: BorderSide(
                                color: Colors.grey.shade500,
                                width: 1.5
                            ),
                          ),
                          Text('At least 1 uppercase',style: TextStyle(color: Colors.grey,fontSize: 16),)
                        ],
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: symbolCheck,
                            onChanged: (value) => setState(() {
                              symbolCheck = value!;
                            }),
                            shape: CircleBorder(),
                            fillColor: MaterialStateProperty.resolveWith<Color>((states){
                              return symbolCheck ? Colors.greenAccent : Colors.red.shade200;
                            }),
                            side: BorderSide(
                                color: Colors.grey.shade500,
                                width: 1.5
                            ),
                          ),
                          Text('Contain min 1 symbol',style: TextStyle(color: Colors.grey,fontSize: 16),)
                        ],
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: numberCheck,
                            onChanged: (value) => setState(() {
                              numberCheck = value!;
                            }),
                            fillColor: MaterialStateProperty.resolveWith<Color>((states){
                              return numberCheck ? Colors.greenAccent : Colors.red.shade200;
                            }),
                            shape: CircleBorder(),
                            side: BorderSide(
                                color: Colors.grey.shade500,
                                width: 1.5
                            ),
                          ),
                          Text('Contain min 1 number',style: TextStyle(color: Colors.grey,fontSize: 16),)
                        ],
                      ),

                      Row(
                        children: [
                          Checkbox(
                            value: pwdCountCheck,
                            onChanged: (value) => setState(() {
                              pwdCountCheck = value!;
                            }),
                            fillColor: MaterialStateProperty.resolveWith<Color>((states){
                              return pwdCountCheck ? Colors.greenAccent : Colors.red.shade200;
                            }),
                            shape: CircleBorder(),
                            side: BorderSide(
                                color: Colors.grey.shade500,
                                width: 1.5
                            ),
                          ),
                          Text('Minimal 8 character',style: TextStyle(color: Colors.grey,fontSize: 16),)
                        ],
                      ),

                      SizedBox(height: 30),

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
                          onPressed: registerController.isLoading.value ? null : () async {
                            final result = await registerController.setPassword(registerController.userEmail, pwdController.text);
                            final body = result['body'];
                            if(uppercaseCheck == true && numberCheck == true && symbolCheck == true && pwdCountCheck == true && pwdController.text.isNotEmpty) {

                              if (body['success']) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text(body['message'])
                                  ),
                                );
                                registerController.nextPage();
                                Get.to(() => CompleteProfileScreen());
                              } else {
                                Get.snackbar(
                                  'Error',
                                  body['message'] ?? 'Password set Failed',
                                );
                              }
                            }else{
                              Get.snackbar('Error', 'Please enter password again');
                            }
                          },

                          child: registerController.isLoading.value
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

                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}