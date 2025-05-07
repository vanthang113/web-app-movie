import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:webfilm/models/movie.dart';

class MovieProvider extends ChangeNotifier {
  bool _isLoading = false;
  String _error = '';
  List<Movie> _movies = [];
  List<Movie> _featuredMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _latestMovies = [];
  int _page = 1;
  int _pages = 1;

  bool get isLoading => _isLoading;
  String get error => _error;
  List<Movie> get movies => _movies;
  List<Movie> get featuredMovies => _featuredMovies;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get latestMovies => _latestMovies;
  int get page => _page;
  int get pages => _pages;

  final String _baseUrl = 'http://127.0.0.1:8000/api'; 

  Future<void> fetchMovies({String? keyword, bool loadMore = false}) async {
    if (loadMore) {
      _page++;
    } else {
      _page = 1; // Reset page khi fetch mới
      _movies = []; // Xóa list cũ khi fetch mới (không phải load more)
      _error = ''; // Reset lỗi
    }

    // Chỉ set loading = true khi fetch trang đầu tiên hoặc fetch mới
    if (_page == 1) {
      _isLoading = true;
      notifyListeners(); // Thông báo loading state
    }

    try {
      final uri = Uri.parse('$_baseUrl/movies/').replace( // Đúng endpoint
        queryParameters: {
          if (keyword != null && keyword.isNotEmpty) 'search': keyword,
          'page': _page.toString(),
        },
      );

      print('Calling API URL (fetchMovies): $uri');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status (fetchMovies): ${response.statusCode}');
      // print('Response body (fetchMovies): ${response.body}'); // Tạm ẩn để log đỡ rối

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        
        if (data is Map<String, dynamic>) {
          // Ưu tiên key 'movies' nếu API trả về như vậy, sau đó mới đến 'results'
          List<dynamic> moviesData = data['movies'] ?? data['results'] ?? []; 
          
          List<Movie> fetchedMovies = moviesData
              .map((movieJson) => Movie.fromJson(movieJson))
              .toList();

          if (loadMore) {
            _movies.addAll(fetchedMovies); // Thêm vào list hiện tại
          } else {
            _movies = fetchedMovies; // Thay thế list cũ
          }
          
          _pages = data['pages'] ?? data['total_pages'] ?? 1; // Ưu tiên 'pages'
          
          // Phân loại phim (có thể chỉ cần làm khi fetch trang đầu)
          if (_page == 1) {
             _featuredMovies = _movies.where((movie) => movie.isFeatured).toList();
             // Top movies sẽ fetch riêng
             _latestMovies = _movies.where((movie) => 
               movie.releasedAt != null && 
               movie.releasedAt!.isAfter(DateTime.now().subtract(Duration(days: 30)))
             ).toList();
          }

          _error = ''; 
        } else {
          _error = 'Định dạng dữ liệu không hợp lệ';
        }
      } else {
        _error = 'Không thể tải danh sách phim (Mã lỗi: ${response.statusCode})';
      }
    } catch (e, stackTrace) { // Thêm stackTrace để debug
      _error = 'Lỗi khi tải dữ liệu: $e';
      print('Error in fetchMovies: $e');
      print('Stack trace: $stackTrace'); // In stack trace
      // Nếu lỗi xảy ra khi đang load more, giảm page lại
      if (loadMore && _page > 1) {
        _page--;
      }
    } finally {
      // Chỉ tắt loading khi fetch trang đầu tiên xong
       if (_page == 1) {
         _isLoading = false;
       }
      notifyListeners(); // Luôn thông báo kết quả cuối cùng
    }
  }

  // Fetch top movies (thường là danh sách cố định, không cần phân trang)
  Future<void> fetchTopMovies() async {
    // Có thể thêm biến loading riêng cho top movies nếu muốn
    try {
      final uri = Uri.parse('$_baseUrl/movies/top/'); // Đúng endpoint
      print('Calling API URL (fetchTopMovies): $uri');

      final response = await http.get(
        uri,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      );

      print('Response status (fetchTopMovies): ${response.statusCode}');
      // print('Response body (fetchTopMovies): ${response.body}');

      if (response.statusCode == 200) {
        var data = json.decode(response.body);
        
        // API /top/ thường trả về trực tiếp list, kiểm tra cả trường hợp có key 'results'/'movies'
        List<dynamic> moviesData;
        if (data is List) {
          moviesData = data;
        } else if (data is Map<String, dynamic>) {
          moviesData = data['results'] ?? data['movies'] ?? [];
        } else {
          moviesData = []; // Không đúng định dạng
        }

        // Kiểm tra kỹ trước khi map để tránh lỗi type
        if (moviesData.every((item) => item is Map<String, dynamic>)) {
           _popularMovies = moviesData
              .map((movieJson) => Movie.fromJson(movieJson as Map<String, dynamic>))
              .toList();
        } else {
           print("Error: Invalid data format in top movies response.");
           _popularMovies = []; // Hoặc giữ list cũ
        }
        // Không cần gọi notifyListeners() ở đây nếu fetchTopMovies được gọi cùng fetchMovies
        // và notifyListeners() cuối cùng trong fetchMovies đã đủ.
        // Tuy nhiên, nếu gọi riêng thì cần notifyListeners() ở đây.
        // Để an toàn, cứ gọi notifyListeners()
        notifyListeners(); 
      } else {
         print('Error fetching top movies: Status code ${response.statusCode}');
         // Có thể set _error ở đây nếu muốn hiển thị lỗi này
      }
    } catch (e, stackTrace) {
      print('Error fetching top movies: $e');
      print('Stack trace: $stackTrace');
      // Xử lý lỗi nếu cần, ví dụ set _error
    }
    // Không cần finally và notifyListeners ở đây nếu nó được gọi chung trong _loadData
  }

  // Reset the state when needed
  void resetState() {
    _movies = [];
    _featuredMovies = [];
    _popularMovies = [];
    _latestMovies = [];
    _page = 1;
    _pages = 1;
    _error = '';
    notifyListeners();
  }

  Future<bool> checkConnection() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl));
      print('Connection test status: ${response.statusCode}');
      print('Connection test body: ${response.body}');
      return response.statusCode == 200;
    } catch (e) {
      print('Connection test failed: $e');
      return false;
    }
  }
}
