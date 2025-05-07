// import 'package:flutter/material.dart';
// import '../models/movie.dart';
// import 'watch_movie_screen.dart';

// class MovieDetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

//     return Scaffold(
//       appBar: AppBar(title: Text(movie.name)),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(12),
//                 child: Image.network(
//                   'http://127.0.0.1:8000${movie.image}',
//                   fit: BoxFit.cover,
//                   width: double.infinity,
//                   height: 400,
//                   errorBuilder: (context, error, stackTrace) =>
//                       const Icon(Icons.broken_image, size: 60),
//                 ),
//               ),
//               const SizedBox(height: 16),
//               Text(
//                 movie.name,
//                 style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//               ),
//               const SizedBox(height: 8),
//               Text(
//                 movie.description ?? 'Không có mô tả phim',
//                 style: const TextStyle(fontSize: 16),
//               ),
//               const SizedBox(height: 32),
//               Center(
//                 child: ElevatedButton.icon(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => WatchMovieScreen(
//                           videoUrl: 'http://127.0.0.1:8000${movie.trailerUrl}',
//                         ),
//                       ),
//                     );
//                   },
//                   icon: const Icon(Icons.play_arrow),
//                   label: const Text("Xem phim"),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
//                     backgroundColor: Colors.deepPurple,
//                     foregroundColor: Colors.white,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../models/movie.dart';
import 'watch_movie_screen.dart';

class MovieDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          movie.name,
          style: const TextStyle(
            fontFamily: 'TimesNewRoman',
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  'http://127.0.0.1:8000${movie.image}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 400,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 60),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                movie.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'TimesNewRoman',
                ),
              ),
              const SizedBox(height: 8),
              Text(
                movie.description ?? 'Không có mô tả phim',
                style: const TextStyle(
                  fontSize: 16,
                  fontFamily: 'TimesNewRoman',
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WatchMovieScreen(
                          videoUrl: 'http://127.0.0.1:8000${movie.trailerUrl}',
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.play_arrow),
                  label: const Text(
                    "Xem phim",
                    style: TextStyle(
                      fontFamily: 'TimesNewRoman',
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    backgroundColor: Colors.deepPurple,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

