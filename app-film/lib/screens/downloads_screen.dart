import 'package:flutter/material.dart';
import 'package:webfilm/screens/home_screen.dart';  // Nhập màn hình home nếu cần điều hướng về trang chủ

class DownloadsScreen extends StatelessWidget {
  const DownloadsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tải xuống'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.download_done,
              size: 100,
              color: Colors.grey[700],
            ),
            const SizedBox(height: 16),
            Text(
              'Chưa có phim nào được tải xuống',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Điều hướng đến màn hình chính khi nhấn nút
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text('Khám phá phim'),
            ),
          ],
        ),
      ),
    );
  }
}
