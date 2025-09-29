import 'package:flutter_clinic_app/api/appointmentServices.dart';
import 'package:flutter_clinic_app/models/appointment.dart';
import 'package:get/get.dart';

import '../api/auth_services.dart';

class AppointmentController extends GetxController{
  var isLoading = false.obs;
  var errorMessage = ''.obs;
  static String accessToken = '';
  var appointmentsList = <Appointment>[].obs;
  var appointmentResponse = Rxn<AppointmentResponse>();
  var appointment = Rxn<Appointment>();
  var appointmentDetail = Rxn<Appointment>();

  Future<void> makeAppointment({
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
    appointmentResponse.value = result;
  }

  Future<void> fetchAppointments() async {
    isLoading.value = true;
    errorMessage.value = '';

    accessToken = await AuthService().getToken();

    final result = await AppointmentServices.fetchAppointments(token: accessToken);

    isLoading.value = false;
    appointmentsList.assignAll(result);
  }

  Future<void> fetchAppointmentByID(String appointmentID) async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final result = await AppointmentServices.fetchAppointmentByID(
          accessToken: accessToken,
          appointmentID: appointmentID);

      appointmentDetail.value = result;

    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }
}