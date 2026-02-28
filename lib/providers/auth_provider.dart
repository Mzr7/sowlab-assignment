import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthProvider extends ChangeNotifier {

  /// ✅ Correct Base URL
  final String baseUrl = "https://sowlab.com/assignment";

  final FlutterSecureStorage _storage =
      const FlutterSecureStorage();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  /// =========================
  /// USER DATA
  /// =========================

  String? _fullName;
  String? _email;
  String? _phoneNumber;
  String? _password;

  File? _registrationProof;
  String? _resetToken;

  Map<String, List<String>> businessHours = {};

  /// =========================
  /// SETTERS
  /// =========================

  void setFullName(String name) {
    _fullName = name;
  }

  void setEmail(String email) {
    _email = email;
  }

  void setPhoneNumber(String phone) {
    _phoneNumber = phone;
  }

  void setPassword(String password) {
    _password = password;
  }

  void setRegistrationProof(File file) {
    _registrationProof = file;
    notifyListeners();
  }

  void setResetToken(String token) {
    _resetToken = token;
  }

  /// =========================
  /// LOGIN
  /// =========================

 Future<bool> login({
  required String email,
  required String password,
}) async {

  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {

    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "email": email,
        "password": password,
        "role": "farmer",
        "device_token": "dummy_device_token",
        "type": "email",
        "social_id": ""
      }),
    );

    final data = jsonDecode(response.body);

    print("LOGIN RESPONSE: $data");

    _isLoading = false;
    notifyListeners();

    if (response.statusCode == 200 ||
        response.statusCode == 401) {

      if (data["success"] == "true") {

        await _storage.write(
          key: "auth_token",
          value: data["token"],
        );

        return true;

      } else {

        _errorMessage = data["message"];
        notifyListeners();
        return false;
      }
    }

    _errorMessage = "Unexpected server error";
    return false;

  } catch (e) {
    _isLoading = false;
    _errorMessage = "Network error";
    notifyListeners();
    return false;
  }
}
  /// =========================
  /// CHECK LOGIN STATUS
  /// =========================

  Future<bool> checkLoginStatus() async {
    String? token =
        await _storage.read(key: "auth_token");
    return token != null;
  }

  /// =========================
  /// LOGOUT
  /// =========================

  Future<void> logout() async {
    await _storage.delete(key: "auth_token");
  }

  /// =========================
  /// FORGOT PASSWORD
  /// =========================

  Future<bool> forgotPassword(String mobile) async {

  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/user/forgot-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "mobile": mobile,
      }),
    );

    final data = jsonDecode(response.body);

    print("FORGOT PASSWORD RESPONSE: $data");

    _isLoading = false;
    notifyListeners();

    if (response.statusCode == 200) {

      if (data["success"] == "true") {
        return true;
      } else {
        _errorMessage = data["message"];
        notifyListeners();
        return false;
      }
    }

    _errorMessage = "Unexpected server error";
    return false;

  } catch (e) {
    _isLoading = false;
    _errorMessage = "Network error. Please try again.";
    notifyListeners();
    return false;
  }
}

  /// =========================
  /// VERIFY OTP (DEMO MODE)
  /// =========================

  Future<bool> verifyOtp(String otp) async {

  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/user/verify-otp'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "otp": otp,
      }),
    );

    final data = jsonDecode(response.body);

    print("VERIFY OTP RESPONSE: $data");

    _isLoading = false;
    notifyListeners();

    if (response.statusCode == 200 ||
        response.statusCode == 401) {

      if (data["success"] == "true") {

        // Save reset token from API
        _resetToken = data["token"];

        return true;

      } else {
        _errorMessage = data["message"];
        notifyListeners();
        return false;
      }
    }

    _errorMessage = "Unexpected server error";
    return false;

  } catch (e) {
    _isLoading = false;
    _errorMessage = "Network error. Please try again.";
    notifyListeners();
    return false;
  }
}

  /// =========================
  /// RESET PASSWORD
  /// =========================

  Future<bool> resetPassword(
  String password,
  String confirmPassword,
) async {

  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  try {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "token": _resetToken,
        "password": password,
        "cpassword": confirmPassword,
      }),
    );

    final data = jsonDecode(response.body);

    print("RESET PASSWORD RESPONSE: $data");

    _isLoading = false;
    notifyListeners();

    if (data["success"] == "true") {

      // Optional: clear reset token
      _resetToken = null;

      return true;

    } else {
      _errorMessage = data["message"];
      return false;
    }

  } catch (e) {
    _isLoading = false;
    _errorMessage = "Network error. Please try again.";
    notifyListeners();
    return false;
  }
}

  /// =========================
  /// TOGGLE BUSINESS HOURS
  /// =========================

  void toggleBusinessHour(
      String day, String slot) {

    businessHours.putIfAbsent(day, () => []);

    if (businessHours[day]!.contains(slot)) {
      businessHours[day]!.remove(slot);
    } else {
      businessHours[day]!.add(slot);
    }

    notifyListeners();
  }

  /// =========================
  /// REGISTER USER (Still Demo Mode)
  /// =========================

  Future<bool> registerUser() async {

    _isLoading = true;
    notifyListeners();

    await Future.delayed(
        const Duration(seconds: 2));

    print("REGISTER CALLED");
    print("Name: $_fullName");
    print("Email: $_email");
    print("Phone: $_phoneNumber");
    print("Password: $_password");
    print("Proof file: ${_registrationProof?.path}");
    print("Business Hours: $businessHours");

    _isLoading = false;
    notifyListeners();

    return true;
  }
}