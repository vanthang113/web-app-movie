import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/movie.dart';

class ApiService {
final String _baseUrl = 'http://127.0.0.1:8000/api'; 
  // Lấy danh sách phim
  Future<List<Movie>> getMovies({String? keyword, int page = 1}) async {
    try {
      final url = Uri.parse('$baseUrl?keyword=$keyword&page=$page');
      print('Calling API: $url'); // Debug log

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load movies');
      }
    } catch (e) {
      print('Error in getMovies: $e'); // Debug log
      throw Exception('Error: $e');
    }
  }

  // Lấy chi tiết phim
  Future<Movie> getMovieDetail(int id) async {
    try {
      final url = Uri.parse('$baseUrl$id/');
      print('Calling API: $url'); // Debug log

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return Movie.fromJson(data);
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      print('Error in getMovieDetail: $e'); // Debug log
      throw Exception('Error: $e');
    }
  }

  // Lấy danh sách phim top
  Future<List<Movie>> getTopMovies() async {
    try {
      final url = Uri.parse('${baseUrl}top/');
      print('Calling API: $url'); // Debug log

      final response = await http.get(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status: ${response.statusCode}'); // Debug log
      print('Response body: ${response.body}'); // Debug log

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final List<dynamic> results = data['results'];
        return results.map((json) => Movie.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load top movies');
      }
    } catch (e) {
      print('Error in getTopMovies: $e'); // Debug log
      throw Exception('Error: $e');
    }
  }
}
