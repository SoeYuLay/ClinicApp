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


//For Future Builder
// Future<List<Doctor>> fetchDoctorsHomePage({required bool isHomePage}) async {
//   try {
//     final response = await DoctorServices.fetchDoctorData(token: accessToken, isHomePage: isHomePage);
//
//     return response;
//   } catch (e) {
//     throw Exception("Failed to fetch doctors: $e");
//   }
// }
//
// Future<List<Doctor>> fetchAllDoctors({
//   required bool isHomePage,
// }) async {
//   final result = await DoctorServices.fetchDoctorData(
//     token: accessToken,
//     isHomePage: isHomePage,
//     page: page,
//     pageSize: pageSize,
//   );
//
//   hasMore.value = result.length == pageSize;
//
//   // Append new doctors
//   if (page == 1) {
//     doctors.value = result; // reset on first page
//   } else {
//     doctors.addAll(result);
//   }
//
//   return doctors;
// }
//
// void loadMore(bool isHomePage) {
//   if (!hasMore.value) return;
//   page++;
//   fetchAllDoctors(isHomePage: isHomePage);
// }
//
// void resetAndFetch(bool isHomePage) {
//   page= 1;
//   hasMore.value = true;
//   fetchAllDoctors(isHomePage: isHomePage);
// }
//
//
// Future<Doctor> fetchDoctorByID(String doctorID) async {
//   await Future.delayed(Duration(seconds: 1));
//   final doctors = await DoctorServices.fetchDoctorDataByID(accessToken: accessToken, doctorID: doctorID);
//   return doctors;
// }
