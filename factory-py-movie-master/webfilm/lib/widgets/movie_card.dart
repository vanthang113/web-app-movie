import 'package:flutter/material.dart';
import '../models/movie.dart';

class MovieCard extends StatelessWidget {
  final Movie movie;
  final bool isFeatured; // ✅ Thêm biến này

  const MovieCard({
    super.key,
    required this.movie,
    this.isFeatured = false, 
  });

  @override
  Widget build(BuildContext context) {
    final double cardWidth = isFeatured ? 240 : 160;
    final double borderRadius = isFeatured ? 20 : 12;

    return InkWell(
      onTap: () {
        Navigator.pushNamed(
          context,
          '/movie-detail',
          arguments: movie,
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        elevation: isFeatured ? 8 : 4, // ✅ Đổ bóng mạnh hơn
        margin: const EdgeInsets.all(8),
        clipBehavior: Clip.antiAlias,
        child: SizedBox(
          width: cardWidth,
          child: AspectRatio(
            aspectRatio: 2 / 3,
            child: Image.network(
              'http://127.0.0.1:8000${movie.image}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.broken_image,
                size: 60,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
