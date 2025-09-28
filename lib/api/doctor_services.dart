import 'dart:convert';

import 'package:flutter_clinic_app/models/doctor.dart';
import 'package:http/http.dart' as http;

class DoctorServices {
  static const String baseUrl = "https://clinic-bk-production.up.railway.app";

  static Future<List<Doctor>> fetchDoctorData({
    required String token,
    required bool isHomePage,
    int page = 1,
    int pageSize = 5
}) async {
    try {
      final url = isHomePage
          ? Uri.parse("$baseUrl/doctors?isHomePage=true")
          : Uri.parse("$baseUrl/doctors?page=$page&pageSize=$pageSize");
          // : Uri.parse("$baseUrl/doctors");
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
        final List<dynamic> data = decoded['data']['data'];
        return data.map((json) => Doctor.fromJson(json)).toList();

      }else{
        throw Exception("Failed with status: ${response.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Error fetching specialties: $e");
    }
  }

  static Future<Doctor> fetchDoctorDataByID({
    required String accessToken,
    required String doctorID
  }) async {
    try {
      final response = await http.get(
        Uri.parse("$baseUrl/doctors/$doctorID"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200){
        final decoded = jsonDecode(response.body);
        final doctorDataJson = decoded['data'];
        return Doctor.fromJson(doctorDataJson);
      }else{
        throw Exception("Failed with status: ${response.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Error fetching specialties: $e");
    }
  }

}