import 'package:flutter_clinic_app/api/specialities_services.dart';
import 'package:flutter_clinic_app/models/specialitiesModel.dart';
import 'package:get/get.dart';

class SpecialitiesController extends GetxController {
  var isLoading = false.obs;
  var specialitiesHomePage = <SpecialitiesModel>[].obs;
  var allSpecialities = <SpecialitiesModel>[].obs;

  Future<void> fetchSpecialities({required bool isHomePage}) async {
    isLoading.value = true;
    final result = await SpecialitiesServices.specialities(isHomePage: isHomePage);
    isHomePage ? specialitiesHomePage.assignAll(result) : allSpecialities.assignAll(result);
    isLoading.value = false;
  }
}
