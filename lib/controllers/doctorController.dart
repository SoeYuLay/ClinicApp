import 'package:flutter_clinic_app/api/auth_services.dart';
import 'package:flutter_clinic_app/api/doctor_services.dart';
import 'package:flutter_clinic_app/models/doctor.dart';
import 'package:get/get.dart';

class DoctorController extends GetxController{
  // static String accessToken = '';
  static String accessToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6InRlc3QzOUBnbWFpbC5jb20iLCJzdWIiOiJjbWczNjJycnowMDAwcDgwdzAzdHp1MW5vIiwiaWF0IjoxNzU5MDMxNzQ3LCJleHAiOjE3NTkwNzE3NDd9.gQO0KeLWTTk9ozmmybVsuff9QE8tWrIJ1X40D7j3rBk';

  //For Obx
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  var doctors = <Doctor>[].obs;
  var doctor = Rxn<Doctor>();
  var page = 1;
  final int pageSize = 5;
  var hasMore = true.obs;

  var newPatientCheck = false.obs;

  // Fetch all doctors
  Future<void> fetchDoctors({required bool isHomePage}) async {
    isLoading.value = true;
    errorMessage.value = '';
    accessToken = await AuthService().getToken();

    try {
      final result = await DoctorServices.fetchDoctorData(
        token: accessToken,
        isHomePage: isHomePage,
        page: page,
        pageSize: pageSize,
      );

      doctors.assignAll(result);
      hasMore.value = result.length >= pageSize;
    } catch (e) {
      errorMessage.value = e.toString();
    }

    isLoading.value = false;
  }

  // Fetch single doctor by ID
  Future<void> fetchDoctorByIDs(String doctorID) async {
    isLoading.value = true;
    errorMessage.value = '';

    final result = await DoctorServices.fetchDoctorDataByID(
      accessToken: accessToken,
      doctorID: doctorID,
    );
    doctor.value = result;

    isLoading.value = false;
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
}