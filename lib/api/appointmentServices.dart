import 'dart:convert';
import 'package:flutter_clinic_app/models/appointments.dart';
import 'package:http/http.dart' as http;

class AppointmentServices {
  static const String baseUrl = "https://clinic-bk-production.up.railway.app";

  static Future<Map<String, dynamic>> makeAppointment({
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

      final data = jsonDecode(response.body);

      return {
        "statusCode": response.statusCode,
        "body": data,
      };
    } catch (e) {
      return {
        "success": false,
        "message": "Error: $e",
      };
    }
  }

  static Future<List<Appointments>> fetchAppointments({
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
        return data.map((json) => Appointments.fromJson(json)).toList();

      }else{
        throw Exception("Failed with status: ${response.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Error fetching specialties: $e");
    }
  }
}
