import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

// Gửi yêu cầu đăng nhập
Future<String> login(String username, String password) async {
  final response = await http.post(
    Uri.parse('http://127.0.0.1:8000/api/token/'), // API của Django
    body: {
      'username': username,
      'password': password,
    },
  );

  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    return data['access']; // Trả về token JWT
  } else {
    throw Exception('Failed to login');
  }
}

// Lưu token vào shared preferences
Future<void> saveToken(String token) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString('jwt_token', token);
}

// Lấy token từ shared preferences
Future<String?> getToken() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('jwt_token');
}

// Xóa token khi đăng xuất
Future<void> logout() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('jwt_token');
}
