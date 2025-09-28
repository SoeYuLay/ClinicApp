import 'package:flutter_clinic_app/api/auth_services.dart';
import 'package:get/get.dart';

class OtpController extends GetxController{
  var isLoading = false.obs;
  var errorMessage = ''.obs;

  Future<dynamic> verifyOTP(String email, String otp) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await AuthService.verifyOTP(email: email, token: otp);

    if(result['success']){
      return result;
    }else{
      errorMessage.value = result['message'] ?? "OTP Verification Failed. Please try again.";
      return result;
    }
}
  Future<dynamic> resendOTP(String email) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await AuthService.resendOTP(email: email);

    if(result['success']){
      return result;
    }else{
      errorMessage.value = result['message'] ?? "OTP Verification Failed. Please try again.";
      return result;
    }
  }
}