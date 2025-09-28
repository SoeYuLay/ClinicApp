import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AppointmentServices {
  static const String baseUrl = "https://clinic-bk-production.up.railway.app";
  final _storage = FlutterSecureStorage();

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
}
