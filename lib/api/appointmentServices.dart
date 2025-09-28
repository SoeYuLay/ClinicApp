import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart'as http;

class AppointmentServices{
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
    required String patientName
  }) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/appointments"),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['doctorId'] = doctorID;
      request.fields['date'] = appointmentDate;
      request.fields['time'] = appointmentSlot;
      request.fields['note'] = appointmentNote;
      request.fields['appointmentFor'] = appointmentFor;
      request.fields['phoneNumber'] = phoneNumber;
      request.fields['newPatient'] = newPatient.toString();
      request.fields['patientName'] = patientName;

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      final data = jsonDecode(response.body);
      return {
        "statusCode": response.statusCode,
        "body": data,
      };
    } catch (e) {

      return {
        'success': false,
        'message': 'Error: $e',
      };
    }
  }
}