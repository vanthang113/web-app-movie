import 'package:flutter/material.dart';
import 'package:webfilm/screens/login_screen.dart';  

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tài khoản'),
        backgroundColor: Colors.transparent,
        elevation: 0, 
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage('https://via.placeholder.com/100'),
          ),
          const SizedBox(height: 16),
          const Text(
            'Người dùng',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 32),
          _buildMenuItem(
            icon: Icons.favorite_outline,
            title: 'Phim yêu thích',
            onTap: () {
              // TODO: Điều hướng tới màn hình yêu thích
            },
          ),
          _buildMenuItem(
            icon: Icons.history,
            title: 'Lịch sử xem',
            onTap: () {
              // TODO: Điều hướng tới màn hình lịch sử xem
            },
          ),
          _buildMenuItem(
            icon: Icons.settings_outlined,
            title: 'Cài đặt',
            onTap: () {
              // TODO: Điều hướng tới màn hình cài đặt
            },
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // Điều hướng tới màn hình đăng nhập khi đăng xuất
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text('Đăng xuất'),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}
