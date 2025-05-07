// class Movie {
//   final String id;
//   final String name;
//   final String? image;
//   final List<String>? genres;
//   final String description;
//   final DateTime? releasedAt;
//   final bool isMovie;
//   final String rating;
//   final int views;
//   final bool isFeatured;
//   final bool isPopular;

//   Movie({
//     required this.id,
//     required this.name,
//     required this.image,
//     required this.genres,
//     required this.description,
//     required this.rating,
//     required this.views,
//     this.isMovie = true,
//     this.releasedAt,
//     this.isFeatured = false,
//     this.isPopular = false,
//   });

//   /// ✅ Thêm getter này để sử dụng trong MovieCard
//   String? get imageUrl {
//     if (image != null && image!.isNotEmpty) {
//       return 'http://10.0.2.2:8000$image'; // 🔄 Đổi IP nếu chạy thật
//     }
//     return null;
//   }

//   factory Movie.fromJson(Map<String, dynamic> json) {
//     return Movie(
//       id: json['_id'] ?? '',
//       name: json['name'] ?? '',
//       image: json['image'],
//       genres: json['genres'] is List
//           ? List<String>.from(json['genres'])
//           : json['genres'] != null
//               ? [json['genres'].toString()]
//               : null,
//       description: json['description'] ?? '',
//       releasedAt: json['releasedAt'] != null
//           ? DateTime.tryParse(json['releasedAt'])
//           : null,
//       isMovie: json['isMovie'] ?? false,
//       rating: json['rating']?.toString() ?? '0.0',
//       views: json['views'] ?? 0,
//       isFeatured: json['isFeatured'] ?? false,
//       isPopular: json['isPopular'] ?? false,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       '_id': id,
//       'name': name,
//       'image': image,
//       'genres': genres,
//       'description': description,
//       'rating': rating,
//       'views': views,
//       'isMovie': isMovie,
//       'releasedAt': releasedAt?.toIso8601String(),
//       'isFeatured': isFeatured,
//       'isPopular': isPopular,
//     };
//   }
// }
class Movie {
  final String id;
  final String name;
  final String? image;
  final List<String>? genres;
  final String description;
  final DateTime? releasedAt;
  final bool isMovie;
  final String rating;
  final int views;
  final bool isFeatured;
  final bool isPopular;
  final String? trailerUrl; 

  Movie({
    required this.id,
    required this.name,
    required this.image,
    required this.genres,
    required this.description,
    required this.rating,
    required this.views,
    this.isMovie = true,
    this.releasedAt,
    this.isFeatured = false,
    this.isPopular = false,
    this.trailerUrl, 
  });

  String? get imageUrl {
    if (image != null && image!.isNotEmpty) {
      return 'http://127.0.0.1:8000$image';
    }
    return null;
  }

factory Movie.fromJson(Map<String, dynamic> json) {
  return Movie(
    id: json['_id'] ?? '',
    name: json['name'] ?? '',
    image: json['image'],
    genres: json['genres'] is List
        ? List<String>.from(json['genres'])
        : json['genres'] != null
            ? [json['genres'].toString()]
            : null,
    description: json['description'] ?? '',
    releasedAt: json['releasedAt'] != null
        ? DateTime.tryParse(json['releasedAt'])
        : null,
    isMovie: json['isMovie'] ?? false,
    rating: json['rating']?.toString() ?? '0.0',
    views: json['views'] ?? 0,
    isFeatured: json['is_featured'] ?? false,  // ✅ fix ở đây
    isPopular: json['is_popular'] ?? false,    // ✅ và ở đây
    trailerUrl: json['trailer_url'],
  );
}
 
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'image': image,
      'genres': genres,
      'description': description,
      'rating': rating,
      'views': views,
      'isMovie': isMovie,
      'releasedAt': releasedAt?.toIso8601String(),
      'isFeatured': isFeatured,
      'isPopular': isPopular,
      'trailer_url': trailerUrl, 
    };
  }
}

