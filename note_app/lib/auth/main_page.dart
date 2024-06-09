import 'package:firebase_auth/firebase_auth.dart'; // Thư viện Firebase Authentication cho việc xác thực người dùng.
import 'package:flutter/material.dart'; // Thư viện Flutter cơ bản cho việc tạo giao diện người dùng.
import 'package:NotesApp/auth/auth_page.dart'; // Import trang xác thực từ file auth_page.dart.
// import 'package:NotesApp/screen/home.dart'; // Đoạn này bị chú thích, có thể là màn hình chính không được sử dụng.
import 'package:NotesApp/screen/bottomnav.dart'; // Import màn hình điều hướng từ file bottomnav.dart.

// Tạo một StatelessWidget tên là Main_Page.
class Main_Page extends StatelessWidget {
  const Main_Page({super.key}); // Constructor cho Main_Page.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), // Lắng nghe thay đổi trạng thái xác thực từ Firebase.
        builder: (context, snapshot) {
          if (snapshot.hasData) { // Nếu có dữ liệu (người dùng đã đăng nhập).
            return BottomNav(); // Hiển thị màn hình điều hướng BottomNav.
          } else { // Nếu không có dữ liệu (người dùng chưa đăng nhập).
            return Auth_Page(); // Hiển thị trang xác thực Auth_Page.
          }
        },
      ),
    );
  }
}
