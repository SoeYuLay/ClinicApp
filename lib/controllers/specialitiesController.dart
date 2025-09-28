import 'package:flutter_clinic_app/api/specialities_services.dart';
import 'package:flutter_clinic_app/models/specialitiesModel.dart';
import 'package:get/get.dart';

class SpecialitiesController extends GetxController{

  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var specialities = <SpecialitiesModel>[].obs;

  Future<void> fetchSpecialities({required bool isHomePage}) async{
    isLoading.value = true;
    errorMessage.value = '';

    final result = await SpecialitiesServices.specialities(isHomePage: isHomePage);

    isLoading.value = false;
    specialities.assignAll(result);
  }
}