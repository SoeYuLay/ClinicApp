import 'dart:convert';
import 'package:flutter_clinic_app/models/appointment.dart';
import 'package:http/http.dart' as http;

class AppointmentServices {
  static const String baseUrl = "https://clinic-bk-production.up.railway.app";

  static Future<List<AppointmentResponse>> makeAppointment({
    required String token,
    required String doctorID,
    required String appointmentDate,
    required String appointmentSlot,
    required String appointmentNote,
    required String appointmentFor,
    required String phoneNumber,
    required bool newPatient,
    required String patientName,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/appointments");

      final headers = {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      };

      final body = jsonEncode({
        "doctorId": doctorID,
        "date": appointmentDate,
        "time": appointmentSlot,
        "note": appointmentNote,
        "appointmentFor": appointmentFor,
        "phoneNumber": phoneNumber,
        "newPatient": newPatient,
        "patientName": patientName,
      });

      final response = await http.post(url, headers: headers, body: body);

      if (response.statusCode == 200 || response.statusCode == 201){
        final decoded = jsonDecode(response.body);
        return [AppointmentResponse.fromJson(decoded['data'])];

      }else{
        throw Exception("Failed with status: ${response.statusCode}");
      }
      // return {
      //   "statusCode": response.statusCode,
      //   "body": data,
      // };
    } catch (e) {
      throw Exception("Error fetching appointment: $e");
    }
  }

  static Future<List<Appointment>> fetchAppointments({
    required String token,
  }) async {
    try {
      final url = Uri.parse("$baseUrl/appointments");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $token"
        },
      );

      if (response.statusCode == 200){
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data'];
        return data.map((json) => Appointment.fromJson(json)).toList();

      }else{
        throw Exception("Failed with status: ${response.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Error fetching specialties: $e");
    }
  }
}
