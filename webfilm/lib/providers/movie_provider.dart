import 'package:flutter/foundation.dart';
import '../models/movie.dart';
import '../services/api_service.dart';

class MovieProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Movie> _movies = [];
  List<Movie> _topMovies = [];
  bool _isLoading = false;
  String _error = '';
  List<Movie> _featuredMovies = [];
  List<Movie> _popularMovies = [];
  List<Movie> _latestMovies = [];
  int _page = 1;
  int _pages = 1;

  List<Movie> get movies => _movies;
  List<Movie> get topMovies => _topMovies;
  bool get isLoading => _isLoading;
  String get error => _error;
  List<Movie> get featuredMovies => _featuredMovies;
  List<Movie> get popularMovies => _popularMovies;
  List<Movie> get latestMovies => _latestMovies;
  int get page => _page;
  int get pages => _pages;

  Future<void> fetchMovies({String? keyword}) async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final response = await _apiService.getMovies(page: _page, keyword: keyword);
      _movies = response['results'].map<Movie>((json) => Movie.fromJson(json)).toList();
      _page = response['page'];
      _pages = response['total_pages'];
      
      _featuredMovies = _movies.take(5).toList();
      _popularMovies = _movies;
      _latestMovies = _movies;
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTopMovies() async {
    try {
      _isLoading = true;
      _error = '';
      notifyListeners();

      final response = await _apiService.getTopMovies();
      _topMovies = response.map<Movie>((json) => Movie.fromJson(json)).toList();
      
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      _isLoading = false;
      _error = e.toString();
      notifyListeners();
    }
  }

  Future<void> refreshMovies() async {
    _page = 1;
    await fetchMovies();
  }

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
}