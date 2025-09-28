import 'package:flutter_clinic_app/api/auth_services.dart';
import 'package:get/get.dart';

class SignInController extends GetxController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  String userEmail = '';

  Future<Map<String, dynamic>> signIn(String email,String password) async{
    isLoading.value = true;
    errorMessage.value = '';
    final result = await AuthService.signIn(email: email, password: password);
    isLoading.value = false;
    if(result['success']){
      userEmail = email;
      return result;
    }else{
      errorMessage.value = result['message'] ?? "Sign In failed. Please try again.";
      return result;
    }
  }
}