import 'dart:convert';

import 'package:flutter_clinic_app/models/userProfile.dart';
import 'package:http/http.dart'as http;

class ProfileServices{
  static const String baseUrl = "https://clinic-bk-production.up.railway.app";

  static Future<UserProfile> fetchProfileData({required String accessToken}) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/auth/profile"),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200){
        final decoded = jsonDecode(response.body);
        final userJsonData = decoded['data'];
        return UserProfile.fromJson(userJsonData);

      }else{
        throw Exception("Failed with status: ${response.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Error fetching specialties: $e");
    }
  }
}