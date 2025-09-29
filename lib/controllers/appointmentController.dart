import 'package:flutter_clinic_app/api/appointmentServices.dart';
import 'package:get/get.dart';

import '../api/auth_services.dart';

class AppointmentController extends GetxController{
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  static String accessToken = '';

  Future<Map<String, dynamic>> makeAppointment({
    required String doctorID,
    required String appointmentDate,
    required String appointmentSlot,
    required String appointmentNote,
    required String appointmentFor,
    required String phoneNumber,
    required bool newPatient,
    required String patientName
  }) async {
    isLoading.value = true;
    errorMessage.value = '';

    accessToken = await AuthService().getToken();
    print(accessToken);

    final result = await AppointmentServices.makeAppointment(
        token: accessToken,
        doctorID: doctorID,
        appointmentDate: appointmentDate,
        appointmentSlot: appointmentSlot,
        appointmentNote: appointmentNote,
        appointmentFor: appointmentFor,
        phoneNumber: phoneNumber,
        newPatient: newPatient,
        patientName: patientName
    );

    isLoading.value = false;

    final statusCode = result['statusCode'];
    final body = result['body'];

    if (statusCode == 200 || statusCode == 201 && body['success'] == true) {
      return result;
    } else {
      errorMessage.value = result['message'] ?? "Make Appointment failed";
      return result;
    }
  }

  // Future<Map<String, dynamic>> fetchAppointments() async {
  //   isLoading.value = true;
  //   errorMessage.value = '';
  //
  //   accessToken = await AuthService().getToken();
  //   print(accessToken);
  //
  //   final result = await AppointmentServices.fetchAppointments(token: accessToken);
  //
  //   isLoading.value = false;
  //
  //   final statusCode = result['statusCode'];
  //   final body = result['body'];
  //
  //   if (statusCode == 200 || statusCode == 201 && body['success'] == true) {
  //     return result;
  //   } else {
  //     errorMessage.value = result['message'] ?? "Make Appointment failed";
  //     return result;
  //   }
  // }
}