// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:webfilm/models/movie.dart';
// import 'dart:convert';

// class AuthProvider extends ChangeNotifier {
//   bool _isAuthenticated = false;
//   String _token = '';
//   String _error = '';
//   String _userEmail = '';  // Lưu trữ email người dùng

//   bool get isAuthenticated => _isAuthenticated;
//   String get token => _token;
//   String get error => _error;
//   String get userEmail => _userEmail;  // Getter để lấy email người dùng

//   // URL của backend Django
// final String _baseUrl = 'http://127.0.0.1:8000/api';

//   // Đăng nhập
//   Future<bool> login(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$_baseUrl/login/'),
//         body: json.encode({
//           'email': email,
//           'password': password,
//         }),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 200) {
//         // Parse JSON response and extract token
//         var data = json.decode(response.body);
//         _isAuthenticated = true;
//         _token = data['token'];  // Giả sử backend trả về token
//         _userEmail = email;  // Lưu trữ email người dùng khi đăng nhập thành công
//         notifyListeners();
//         return true;  // Đăng nhập thành công
//       } else {
//         // Nếu login không thành công, lưu lại lỗi
//         _error = 'Đăng nhập không thành công';
//         notifyListeners();
//         return false;  // Đăng nhập không thành công
//       }
//     } catch (e) {
//       _error = e.toString();  // Lỗi từ backend hoặc mạng
//       notifyListeners();
//       return false;  // Đăng nhập thất bại do lỗi
//     }
//   }

//   // Đăng ký
//   Future<bool> register(String email, String password) async {
//     try {
//       final response = await http.post(
//         Uri.parse('$_baseUrl/register/'),
//         body: json.encode({
//           'email': email,
//           'password': password,
//         }),
//         headers: {'Content-Type': 'application/json'},
//       );

//       if (response.statusCode == 201) {
//         // Parse JSON response and extract token
//         var data = json.decode(response.body);
//         _isAuthenticated = true;
//         _token = data['token'];  // Giả sử backend trả về token
//         _userEmail = email;  // Lưu trữ email người dùng khi đăng ký thành công
//         notifyListeners();
//         return true;  // Đăng ký thành công
//       } else {
//         // Nếu đăng ký không thành công, lưu lại lỗi
//         _error = 'Đăng ký không thành công';
//         notifyListeners();
//         return false;  // Đăng ký không thành công
//       }
//     } catch (e) {
//       _error = e.toString();  // Lỗi từ backend hoặc mạng
//       notifyListeners();
//       return false;  // Đăng ký thất bại do lỗi
//     }
//   }

//   // Đăng xuất
//   void logout() {
//     _isAuthenticated = false;
//     _token = '';
//     _userEmail = '';  // Xóa thông tin người dùng khi đăng xuất
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AuthProvider extends ChangeNotifier {
  bool _isAuthenticated = false;
  String _token = '';
  String _error = '';
  String _userEmail = '';

  bool get isAuthenticated => _isAuthenticated;
  String get token => _token;
  String get error => _error;
  String get userEmail => _userEmail;

  final String _baseUrl = 'http://127.0.0.1:8000/api/users';

  static AuthProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<AuthProvider>(context, listen: listen);

  /// ✅ Sửa lại login: dùng username thay vì email
  Future<bool> login(String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login/'),
        body: json.encode({
          'username': email, //Django JWT yêu cầu trường 'username'
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        _isAuthenticated = true;
        _token = data['access']; // Token JWT từ Django
        _userEmail = email;
        notifyListeners();
        return true;
      } else {
        _error = 'Đăng nhập không thành công';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// ✅ Hàm đăng ký: đã thêm 'name'
  Future<bool> register(String email, String password, String name) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/register/'),
        body: json.encode({
          'email': email,
          'password': password,
          'name': name,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        var data = json.decode(response.body);
        _isAuthenticated = true;
        _token = data['token'];
        _userEmail = email;
        notifyListeners();
        return true;
      } else {
        _error = 'Đăng ký không thành công';
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }

  void logout() {
    _isAuthenticated = false;
    _token = '';
    _userEmail = '';
    notifyListeners();
  }
}
