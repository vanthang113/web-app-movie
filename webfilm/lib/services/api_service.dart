import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences.dart';
import '../models/movie.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage.dart';

class ApiService {
  final Dio _dio = Dio();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();
  final String _baseUrl = 'http://192.168.1.20:8000/api'; // Django backend URL

  ApiService() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        final token = await _storage.read(key: 'token');
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(options);
      },
    ));
  }

  // Lấy danh sách phim
  Future<Map<String, dynamic>> getMovies({String? keyword, int page = 1}) async {
    try {
      print('Calling API URL (fetchMovies): $_baseUrl/movies/?page=$page');
      final response = await _dio.get(
        '$_baseUrl/movies/',
        queryParameters: {
          'page': page,
          if (keyword != null) 'search': keyword,
        },
      );
      print('Response status (fetchMovies): ${response.statusCode}');
      return response.data;
    } catch (e) {
      print('Error fetching movies: $e');
      throw Exception('Failed to load movies');
    }
  }

  // Lấy chi tiết phim
  Future<Movie> getMovieDetails(int id) async {
    try {
      final response = await _dio.get('$_baseUrl/movies/$id/');
      return Movie.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load movie details');
    }
  }

  // Lấy danh sách phim top
  Future<List<dynamic>> getTopMovies() async {
    try {
      print('Calling API URL (fetchTopMovies): $_baseUrl/movies/top/');
      final response = await _dio.get('$_baseUrl/movies/top/');
      print('Response status (fetchTopMovies): ${response.statusCode}');
      return response.data;
    } catch (e) {
      print('Error fetching top movies: $e');
      throw Exception('Failed to load top movies');
    }
  }

  // Đăng nhập
  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/auth/login/',
        data: {'email': email, 'password': password},
      );
      final token = response.data['token'];
      await _storage.write(key: 'token', value: token);
      return token;
    } catch (e) {
      throw Exception('Failed to login');
    }
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
  }

  Future<void> register(String name, String email, String password) async {
    try {
      await _dio.post(
        '$_baseUrl/auth/register/',
        data: {
          'name': name,
          'email': email,
          'password': password,
        },
      );
    } catch (e) {
      throw Exception('Failed to register');
    }
  }

  Future<List<Movie>> searchMovies(String query) async {
    try {
      final response = await _dio.get(
        '$_baseUrl/movies/search/',
        queryParameters: {'query': query},
      );
      return (response.data as List)
          .map((movie) => Movie.fromJson(movie))
          .toList();
    } catch (e) {
      throw Exception('Failed to search movies');
    }
  }
} 