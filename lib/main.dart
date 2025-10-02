import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/controllers/bottomNavController.dart';
import 'package:flutter_clinic_app/controllers/registerController.dart';
import 'package:flutter_clinic_app/screens/login_screen.dart';
import 'package:get/get.dart';

void main() {
  Get.put(RegisterController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: BottomNavController()
    );
  }
}

