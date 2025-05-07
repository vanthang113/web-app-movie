// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../widgets/movie_card.dart';
// import 'package:webfilm/models/movie.dart';
// import 'package:webfilm/providers/movie_provider.dart';
// import 'package:webfilm/providers/auth_provider.dart';
// import 'list_movie_screen.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _loadData();
//     });
//   }

//   Future<void> _loadData({bool refresh = false}) async {
//     try {
//       final movieProvider = context.read<MovieProvider>();
//       if (!refresh || movieProvider.popularMovies.isEmpty) {
//         await Future.wait<void>([
//           movieProvider.fetchMovies(),
//           movieProvider.fetchTopMovies(),
//         ]);
//       } else {
//         await movieProvider.fetchMovies();
//       }
//     } catch (e) {
//       debugPrint('Error loading data: $e');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('WebFILM'),
//         actions: [
//           authProvider.isAuthenticated
//               ? Padding(
//                   padding: const EdgeInsets.only(right: 12),
//                   child: Row(
//                     children: [
//                       CircleAvatar(
//                         backgroundColor: Colors.deepPurple,
//                         child: Text(
//                           authProvider.userEmail.isNotEmpty
//                               ? authProvider.userEmail[0].toUpperCase()
//                               : '?',
//                           style: const TextStyle(color: Colors.white),
//                         ),
//                       ),
//                       const SizedBox(width: 8),
//                       PopupMenuButton<String>(
//                         onSelected: (value) {
//                           if (value == 'logout') {
//                             authProvider.logout();
//                           }
//                         },
//                         itemBuilder: (context) => [
//                           PopupMenuItem<String>(
//                             value: 'logout',
//                             child: Row(
//                               children: const [
//                                 Icon(Icons.logout, size: 20),
//                                 SizedBox(width: 8),
//                                 Text('Đăng xuất'),
//                               ],
//                             ),
//                           ),
//                         ],
//                         child: Text(
//                           authProvider.userEmail,
//                           style: const TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )
//               : Padding(
//                   padding: const EdgeInsets.only(right: 12),
//                   child: ElevatedButton(
//                     onPressed: () {
//                       Navigator.pushNamed(context, '/login');
//                     },
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.deepPurple,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: const Text('Đăng nhập'),
//                   ),
//                 ),
//         ],
//       ),
//       body: Consumer<MovieProvider>(
//         builder: (context, movieProvider, child) {
//           if (movieProvider.isLoading) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           if (movieProvider.error.isNotEmpty) {
//             return Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                     child: Text(
//                       'Lỗi: ${movieProvider.error}',
//                       style: const TextStyle(color: Colors.red),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => _loadData(),
//                     child: const Text('Thử lại'),
//                   ),
//                 ],
//               ),
//             );
//           }

//           final featuredRandom = (List<Movie>.from(movieProvider.featuredMovies)..shuffle()).take(5).toList();

//           return RefreshIndicator(
//             onRefresh: () => _loadData(refresh: true),
//             child: CustomScrollView(
//               slivers: [
//                 SliverAppBar(
//                   floating: true,
//                   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                   title: const Text(
//                     'Nổi bật',
//                     style: TextStyle(
//                       fontSize: 24,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 SliverToBoxAdapter(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       _buildFeaturedSection(featuredRandom),
//                       _buildMovieSection(
//                         title: 'Phim Phổ Biến',
//                         movies: movieProvider.popularMovies,
//                       ),
//                       _buildMovieSection(
//                         title: 'Phim Mới Nhất',
//                         movies: movieProvider.latestMovies,
//                       ),
//                       Align(
//                         alignment: Alignment.center,
//                         child: ConstrainedBox(
//                           constraints: const BoxConstraints(maxWidth: 1200),
//                           child: Padding(
//                             padding: const EdgeInsets.all(16),
//                             child: ElevatedButton(
//                               onPressed: () {
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => const ListMovieScreen(),
//                                   ),
//                                 );
//                               },
//                               child: const Text('Xem tất cả phim'),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildFeaturedSection(List<Movie> movies) {
//     return Align(
//       alignment: Alignment.center,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 1200),
//         child: Container(
//           height: 500,
//           margin: const EdgeInsets.all(16),
//           child: movies.isEmpty
//               ? Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey[800],
//                     borderRadius: BorderRadius.circular(16),
//                   ),
//                   child: const Center(child: Text('Chưa có phim nổi bật')),
//                 )
//               : PageView.builder(
//                   controller: PageController(viewportFraction: 0.8),
//                   itemCount: movies.length,
//                   itemBuilder: (context, index) {
//                     final movie = movies[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 8),
//                       child: MovieCard(
//                         movie: movie,
//                         isFeatured: true,
//                       ),
//                     );
//                   },
//                 ),
//         ),
//       ),
//     );
//   }

//   Widget _buildMovieSection({
//     required String title,
//     required List<Movie> movies,
//   }) {
//     return Align(
//       alignment: Alignment.center,
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 1200),
//         child: Padding(
//           padding: const EdgeInsets.all(16),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 title,
//                 style: const TextStyle(
//                   fontSize: 20,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               if (movies.isEmpty)
//                 const Center(child: Text('Không có phim nào'))
//               else
//                 SizedBox(
//                   height: 300,
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     itemCount: movies.length,
//                     itemBuilder: (context, index) {
//                       final movie = movies[index];
//                       return MovieCard(movie: movie);
//                     },
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/movie_card.dart';
import 'package:webfilm/models/movie.dart';
import 'package:webfilm/providers/movie_provider.dart';
import 'package:webfilm/providers/auth_provider.dart';
import 'list_movie_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData({bool refresh = false}) async {
    try {
      final movieProvider = context.read<MovieProvider>();
      if (!refresh || movieProvider.popularMovies.isEmpty) {
        await Future.wait<void>([
          movieProvider.fetchMovies(),
          movieProvider.fetchTopMovies(),
        ]);
      } else {
        await movieProvider.fetchMovies();
      }
    } catch (e) {
      debugPrint('Error loading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: const Text('🎬 WebFILM'),
        centerTitle: true,
        actions: [
          authProvider.isAuthenticated
              ? Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Text(
                          authProvider.userEmail.isNotEmpty
                              ? authProvider.userEmail[0].toUpperCase()
                              : '?',
                          style: const TextStyle(color: Colors.deepPurple),
                        ),
                      ),
                      const SizedBox(width: 8),
                      PopupMenuButton<String>(
                        onSelected: (value) {
                          if (value == 'logout') {
                            authProvider.logout();
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem<String>(
                            value: 'logout',
                            child: Row(
                              children: [
                                Icon(Icons.logout, size: 20),
                                SizedBox(width: 8),
                                Text('Đăng xuất'),
                              ],
                            ),
                          ),
                        ],
                        child: Text(
                          authProvider.userEmail,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.only(right: 16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.deepPurple,
                    ),
                    child: const Text('Đăng nhập'),
                  ),
                ),
        ],
      ),
      body: Consumer<MovieProvider>(
        builder: (context, movieProvider, child) {
          if (movieProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (movieProvider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '❗ Lỗi: ${movieProvider.error}',
                    style: const TextStyle(color: Colors.red, fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _loadData(),
                    child: const Text('Thử lại'),
                  ),
                ],
              ),
            );
          }

          final featuredRandom = (List<Movie>.from(movieProvider.featuredMovies)..shuffle()).take(5).toList();

          return RefreshIndicator(
            onRefresh: () => _loadData(refresh: true),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: _buildFeaturedSection(featuredRandom),
                ),
                SliverToBoxAdapter(
                  child: _buildMovieSection(
                    title: '🔥 Phim Phổ Biến',
                    movies: movieProvider.popularMovies,
                  ),
                ),
                SliverToBoxAdapter(
                  child: _buildMovieSection(
                    title: '🆕 Phim Mới Nhất',
                    movies: movieProvider.latestMovies,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: ElevatedButton.icon(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ListMovieScreen(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.list),
                        label: const Text('Xem tất cả phim'),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                          backgroundColor: Colors.deepPurple,
                          foregroundColor: Colors.white,
                          textStyle: const TextStyle(fontSize: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildFeaturedSection(List<Movie> movies) {
    return Container(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        children: [
          const Text(
            '⭐ Phim Nổi Bật',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 400,
            child: movies.isEmpty
                ? Container(
                    margin: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Center(child: Text('Chưa có phim nổi bật')),
                  )
                : PageView.builder(
                    controller: PageController(viewportFraction: 0.85),
                    itemCount: movies.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: MovieCard(
                          movie: movies[index],
                          isFeatured: true,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildMovieSection({
    required String title,
    required List<Movie> movies,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          movies.isEmpty
              ? const Center(child: Text('Không có phim nào'))
              : SizedBox(
                  height: 280,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: movies.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return MovieCard(movie: movies[index]);
                    },
                  ),
                ),
        ],
      ),
    );
  }
}
