import 'package:flutter_clinic_app/api/profile_services.dart';
import 'package:flutter_clinic_app/models/userProfile.dart';
import 'package:get/get.dart';

import '../api/auth_services.dart';

class ProfileController {
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var userDetail = Rxn<UserProfile>();

  Future<void> fetchUserData() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await ProfileServices.fetchProfileData(accessToken: await AuthService().getToken());

      userDetail.value = result;

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}