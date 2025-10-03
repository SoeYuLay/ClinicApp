import 'package:flutter_clinic_app/api/auth_services.dart';
import 'package:flutter_clinic_app/api/doctor_services.dart';
import 'package:flutter_clinic_app/models/doctor.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController {

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  var doctorsHomePage = <Doctor>[].obs;
  var allDoctors = <Doctor>[].obs;
  var doctorBySpeciality = <Doctor>[].obs;
  var searchDoctorList = <Doctor>[].obs;
  var favoriteDoctorList = <Doctor>[].obs;
  var savedDoctorList = <Doctor>[].obs;
  var doctor = Rxn<Doctor>();
  var isSaved = true.obs;

  // Pagination
  var page = 1;
  final int pageSize = 5;
  var hasMore = true.obs;

  // Booking selections
  Rx<DateTime> selectedDate = DateTime.now().obs;
  RxString selectedSlotKey = ''.obs;
  RxString selectedSlotLabel = ''.obs;

  var patientSelection = <bool>[true, false].obs;
  var newPatientCheck = false.obs;


  Future<void> fetchDoctors({required bool isHomePage}) async {
    isLoading.value = true;
    errorMessage.value = '';

    print(await AuthService().getToken());

    try {
      final result = await DoctorServices.fetchDoctorData(
        token: await AuthService().getToken(),
        isHomePage: isHomePage,
        page: page,
        pageSize: pageSize,
      );

      if(isHomePage){
        doctorsHomePage.assignAll(result);
      }else{
        if (page == 1) {
          allDoctors.assignAll(result);
        } else {
          allDoctors.addAll(result);
        }
      }

      hasMore.value = result.length >= pageSize;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDoctorByID(String doctorID) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await DoctorServices.fetchDoctorDataByID(
        accessToken: await AuthService().getToken(),
        doctorID: doctorID,
      );

      doctor.value = result;


    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDoctorBySpeciality({required String specialityID}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await DoctorServices.fetchDoctorDataBySpeciality(
        accessToken: await AuthService().getToken(),
        specialityID : specialityID,
      );

      doctorBySpeciality.assignAll(result);

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchDoctorBySearch({required String doctorName, required String date}) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await DoctorServices.fetchDoctorDataBySearch(
        accessToken: await AuthService().getToken(),
        doctorName : doctorName,
        date: date,
      );

      searchDoctorList.assignAll(result);

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchFavoriteDoctor() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await DoctorServices.fetchFavoriteDoctor(
        accessToken: await AuthService().getToken(),
      );

      favoriteDoctorList.assignAll(result);

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBookedDoctor() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await DoctorServices.fetchBookedDoctor(
          accessToken: await AuthService().getToken()
      );

      savedDoctorList.assignAll(result);

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> markAsFav(String doctorID) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await DoctorServices.markAsFav(
          accessToken: await AuthService().getToken(),
          doctorID: doctorID);
      return result;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> unmarkFromFav(String doctorID) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await DoctorServices.unmarkFromFav(
        accessToken: await AuthService().getToken(),
        doctorID: doctorID,
      );

      return result;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }


  void toggleFavorite() async {
    if (doctor.value == null) return;

    final current = doctor.value!;
    bool result = false;

    if (current.isFavorite) {
      result = await unmarkFromFav(current.doctorID);
    } else {
      result = await markAsFav(current.doctorID);
    }

    if (result) {
      doctor.update((d) {
        if (d != null) d.isFavorite = !d.isFavorite;
      });
    } else {
      Get.snackbar("Error", "Failed to update favorite status");
    }

  }

  void updatePatientSelection(int index) {
    for (int i = 0; i < patientSelection.length; i++) {
      patientSelection[i] = i == index;
    }
  }

  void loadMoreDoctors({required bool isHomePage}) {
    if (!hasMore.value) return;
    page++;
    fetchDoctors(isHomePage: isHomePage);
  }

  void resetDoctors({required bool isHomePage}) {
    page = 1;
    hasMore.value = true;
    fetchDoctors(isHomePage: isHomePage);
  }

  // void clearBookingSelections() {
  //   selectedDate.value = null;
  //   selectedSlot.value = '';
  //   patientSelection.assignAll([true, false]);
  //   newPatientCheck.value = false;
  //   patientNameController.value?.clear();
  //   noteController.value?.clear();
  // }
}

