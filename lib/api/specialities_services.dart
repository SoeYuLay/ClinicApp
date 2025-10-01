import 'dart:convert';
import 'package:flutter_clinic_app/models/specialitiesModel.dart';
import 'package:http/http.dart' as http;

class SpecialitiesServices {
  static const String baseUrl = "https://clinic-bk-production.up.railway.app";

  static Future<List<SpecialitiesModel>> specialities({required String accessToken, required bool isHomePage}) async {
    try {
      final url = isHomePage ? Uri.parse("$baseUrl/specialties?isHomePage=true") : Uri.parse("$baseUrl/specialties");
      final response = await http.get(url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer $accessToken"
        },
      );

      if (response.statusCode == 200){
        final decoded = jsonDecode(response.body);
        final List<dynamic> data = decoded['data']['data'];
        return data.map((json)=>SpecialitiesModel.fromJson(json)).toList();

      }else{
        throw Exception("Failed with status: ${response.statusCode}");
      }
    }
    catch (e) {
      throw Exception("Error fetching specialties: $e");
    }
  }
}