import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:webfilm/providers/auth_provider.dart';
import 'package:webfilm/providers/movie_provider.dart';
import 'package:webfilm/screens/main_screen.dart';
import 'package:webfilm/screens/login_screen.dart';
import 'package:webfilm/screens/register_screen.dart';
import 'package:webfilm/screens/movie_detail_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WebFilm',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          fontFamily: 'TimesNewRoman',
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const MainScreen(),
          '/login': (context) => const LoginScreen(),
          '/register': (context) => const RegisterScreen(),
          '/movie-detail': (context) => MovieDetailScreen(),
        },
      ),
    );
  }
}
