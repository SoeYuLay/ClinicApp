import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_clinic_app/api/auth_services.dart';
import 'package:flutter_clinic_app/screens/successCreateAcc_screen.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  String userEmail = '';
  RxInt currentPage = 1.obs; //(1 to 4 pages)

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final dobController = TextEditingController();
  final addressController = TextEditingController();

  void nextPage() {
    if (currentPage < 4) currentPage++;
  }

  void previousPage() {
    if (currentPage > 1) currentPage--;
  }

  double get progress => currentPage.value.toDouble();

  Future<Map<String, dynamic>> sendOTP(String email) async{
    isLoading.value = true;
    errorMessage.value = '';
    final result = await AuthService.sendOTP(email: email);
    isLoading.value = false;
    if(result['success']){
      userEmail = email;
      return result;
    }else{
      errorMessage.value = result['message'] ?? "Registration failed. Please try again.";
      return result;
    }
  }

  Future<Map<String, dynamic>> setPassword(String email,String password) async{
    isLoading.value = true;
    errorMessage.value = '';

    final result = await AuthService.setPassword(email: email, password: password);
    isLoading.value = false;

    final body = result['body'];
    final statusCode = result['statusCode'];


    if(statusCode == 201 && body['success'] == true){
      final token = body['data']['session']['access_token'];
      await AuthService().saveToken(token);
      return result;
    }else{
      errorMessage.value = result['message'] ?? "Password set successfully";
      return result;
    }
  }

  Future<Map<String, dynamic>> completeProfile({
    required String firstName,
    required String lastName,
    required String address,
    required String dob,
    required String gender,
    required File profilePic,
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    final token = await AuthService().getToken();

    final result = await AuthService.completeProfile(
      token: token!,
      firstName: firstName,
      lastName: lastName,
      dateOfBirth: dob,
      address: address,
      gender: gender,
      profilePic: profilePic,
    );

    isLoading.value = false;

    final statusCode = result['statusCode'];
    final body = result['body'];
    print("Token: $token");
    print("FirstName: $firstName");
    print("LastName: $lastName");
    print("DOB: $dob");
    print("Address: $address");
    print("gender: $gender");
    print("profilePic: $profilePic");

    if (statusCode == 200 || statusCode == 201 && body['success'] == true) {
      return result;
    } else {
      errorMessage.value = result['message'] ?? "Complete Profile failed";
      return result;
    }
  }


}