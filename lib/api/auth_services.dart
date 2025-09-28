import 'dart:convert';
import 'dart:io';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "https://clinic-bk-production.up.railway.app";
  final _storage = FlutterSecureStorage();

  static Future<Map<String, dynamic>> sendOTP({
    required String email,
}) async {
    try {
      final response = await http.post(
        Uri.parse("$baseUrl/auth/initiate-signup"),
          headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
        })
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 201){
        print(data["data"]["data"]["otp"]);
        return{
          'success': data['success'] ?? true,
          'message' : data['message'] ?? "Registration OTP sent successfully to your email. Please verify to complete registration."
        };
      }else{
        return{
          'success': false,
          'message': data['message'] ?? "Registration failed. Please try again."
        };
      }
    }
    catch (e) {
      return{
        'success': false,
        'message': "Error in registerUser: $e"
      };
    }
  }

  static Future<Map<String,dynamic>> verifyOTP ({
    required String email,
    required String token
}) async {
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/auth/verify-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "token": token,
          "type": "signup"
        })
      );
      final data = jsonDecode(response.body);

      if(response.statusCode == 201){
        return {
          'success' : data['success'] ?? true,
        'message': data['message'] ?? 'OTP verification successful',
        };
      }else{
        return{
          'success': false,
          'message': data['message'] ?? 'Unknown error occurred',
        };
      }
    }
    catch (e) {
      return{
        'success': false,
        'message': "Error verifying OTP: $e",
      };
    }
  }

  static Future<Map<String,dynamic>> resendOTP ({
    required String email,
}) async {
    try{
      final response = await http.post(
        Uri.parse('$baseUrl/auth/resend-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email
        })
      );
      final data = jsonDecode(response.body);

      if(response.statusCode == 201){
        return{
          "success": data['success'] ?? true,
          "message": data['message'] ?? "OTP resent successfully. Please check your email."
        };
      }else{
        print('here error');
        return{
          "success": false,
          "message": data['message']['error'] ?? 'Unknown error occurred'
        };
      }
    }catch(e){
      return{
        'success': false,
        'message': "Error resending OTP: $e",
      };
    }
  }

  static Future<Map<String, dynamic>> setPassword({
    required String email,
    required String password
  }) async {
    try {
      final response = await http.post(
          Uri.parse("$baseUrl/auth/set-password"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password
          })
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 201){
        return{
        //   'success': data['success'] ?? true,
        // 'message' : data['message'] ?? "Password set successfully"
          'statusCode': response.statusCode,
          'body': data,
        };
      }else{
        return{
          'success': false,
          'message': data['message'] ?? "Password set failed. Please try again."
        };
      }
    }
    catch (e) {
      return {
        // 'success': false,
        // 'message': "Error in registerUser: $e"
        'statusCode': 500,
        'body': {
          'success': false,
          'message': "Error in setPassword: $e",
        }
      };
    }
  }

  static Future<Map<String, dynamic>> completeProfile({
    required String firstName,
    required String lastName,
    required String dateOfBirth,
    required String address,
    required String gender,
    required String token,
    required File profilePic,
  }) async {
    try {
      var request = http.MultipartRequest(
        "POST",
        Uri.parse("$baseUrl/user/info"),
      );

      request.headers['Authorization'] = 'Bearer $token';

      request.fields['firstName'] = firstName;
      request.fields['lastName'] = lastName;
      request.fields['dateOfBirth'] = dateOfBirth;
      request.fields['address'] = address;
      request.fields['gender'] = gender;

      // if (profilePic != null) {
      //   request.files.add(await http.MultipartFile.fromBytes(
      //     'profilePic',
      //     await profilePic.readAsBytes(),
      //     filename: profilePic.path.split("/").last,
      //   ));
      // }
      request.files.add(await http.MultipartFile.fromPath('profilePic', profilePic.path));


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


  Future<Map<String, dynamic>> getUserProfile() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    return jsonDecode(response.body);
  }

  Future<void> saveToken(String token) async {
    await _storage.write(key: 'accessToken', value: token);
  }

  Future<String> getToken() async {
    return await _storage.read(key: 'accessToken') ?? '';
  }

  static Future<Map<String, dynamic>> signIn({
    required String email,
    required String password
  }) async {
    try {
      final response = await http.post(
          Uri.parse("$baseUrl/auth/signin"),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode({
            "email": email,
            "password": password
          })
      );
      final data = jsonDecode(response.body);

      if (response.statusCode == 201){
        return{
          'success': data['success'] ?? true,
          'message' : data['message'] ?? "Sign In Successfully"
        };
      }else{
        return{
          'success': false,
          'message': data['message'] ?? "Sign In failed. Please try again."
        };
      }
    }
    catch (e) {
      return{
        'success': false,
        'message': "Error in registerUser: $e"
      };
    }
  }
}