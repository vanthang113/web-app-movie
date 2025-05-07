// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:webfilm/providers/movie_provider.dart';
// import 'package:webfilm/providers/auth_provider.dart';
// import 'package:webfilm/screens/home_screen.dart';
// import 'package:webfilm/screens/search_screen.dart';
// import 'package:webfilm/screens/downloads_screen.dart';
// import 'package:webfilm/screens/profile_screen.dart';
// import 'package:webfilm/screens/movie_detail_screen.dart'; 

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;

//   final List<Widget> _screens = [
//     const HomeScreen(),
//     const SearchScreen(),
//     const DownloadsScreen(),
//     const ProfileScreen(),
//   ];

//   @override
//   void initState() {
//     super.initState();
//     // Lấy dữ liệu từ MovieProvider khi MainScreen được khởi tạo
//     Provider.of<MovieProvider>(context, listen: false).fetchMovies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     // Lấy thông tin từ MovieProvider và AuthProvider nếu cần
//     var movieProvider = Provider.of<MovieProvider>(context);
//     var authProvider = Provider.of<AuthProvider>(context);

//     return Scaffold(
//       body: _screens[_currentIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) => setState(() => _currentIndex = index),
//         type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home_outlined),
//             activeIcon: Icon(Icons.home),
//             label: 'Trang chủ',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.search_outlined),
//             activeIcon: Icon(Icons.search),
//             label: 'Tìm kiếm',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.download_outlined),
//             activeIcon: Icon(Icons.download),
//             label: 'Tải xuống',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.person_outline),
//             activeIcon: Icon(Icons.person),
//             label: 'Cá nhân',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webfilm/providers/movie_provider.dart';
import 'package:webfilm/providers/auth_provider.dart';
import 'package:webfilm/screens/home_screen.dart';
import 'package:webfilm/screens/search_screen.dart';
import 'package:webfilm/screens/downloads_screen.dart';
import 'package:webfilm/screens/profile_screen.dart';
import 'package:webfilm/screens/movie_detail_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const SearchScreen(),
    const DownloadsScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Gọi fetchMovies sau khi build xong widget tree
    Future.microtask(() {
      Provider.of<MovieProvider>(context, listen: false).fetchMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Lấy thông tin từ MovieProvider và AuthProvider
    var movieProvider = Provider.of<MovieProvider>(context);
    var authProvider = Provider.of<AuthProvider>(context);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Trang chủ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search_outlined),
            activeIcon: Icon(Icons.search),
            label: 'Tìm kiếm',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.download_outlined),
            activeIcon: Icon(Icons.download),
            label: 'Tải xuống',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Cá nhân',
          ),
        ],
      ),
    );
  }
}
