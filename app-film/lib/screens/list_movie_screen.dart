import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webfilm/models/movie.dart';  
import 'package:webfilm/widgets/movie_card.dart';
import 'package:webfilm/providers/movie_provider.dart';

class ListMovieScreen extends StatelessWidget {
  const ListMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var movieProvider = Provider.of<MovieProvider>(context); // Get movie data

    return Scaffold(
      appBar: AppBar(
        title: const Text('Danh sách Phim'),
      ),
      body: movieProvider.isLoading
          ? const Center(child: CircularProgressIndicator()) // Hiển thị loading khi đang tải dữ liệu
          : CustomScrollView(
              slivers: [
                SliverAppBar(
                  floating: true,
                  backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                  title: const Text(
                    'Phim Phổ Biến',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Phim phổ biến
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phim Phổ Biến',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Hiển thị danh sách phim phổ biến
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movieProvider.movies.length, // Lấy số lượng phim từ provider
                                itemBuilder: (context, index) {
                                  final movie = movieProvider.movies[index];
                                  return Container(
                                    width: 140,
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: MovieCard(movie: movie),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Phim mới nhất
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Phim Mới Nhất',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Hiển thị danh sách phim mới nhất
                            SizedBox(
                              height: 200,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: movieProvider.movies.length,
                                itemBuilder: (context, index) {
                                  final movie = movieProvider.movies[index];
                                  return Container(
                                    width: 140,
                                    margin: const EdgeInsets.only(right: 16),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[800],
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: MovieCard(movie: movie),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}