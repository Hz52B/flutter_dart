import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core để khởi tạo Firebase
import 'package:flutter/material.dart'; // Import Flutter Material để xây dựng giao diện người dùng
import 'package:NotesApp/auth/main_page.dart'; // Import Main_Page từ ứng dụng NotesApp
import 'package:NotesApp/firebase_options.dart'; // Import tùy chọn cấu hình Firebase từ ứng dụng

void main() async {
  // Hàm chính của ứng dụng
  WidgetsFlutterBinding.ensureInitialized(); 
  // Đảm bảo rằng các ràng buộc Flutter đã được khởi tạo trước khi gọi đến Firebase.initializeApp()

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ); 
  // Khởi tạo Firebase với các tùy chọn cấu hình cụ thể cho nền tảng hiện tại (iOS/Android/Web)

  runApp(const MyApp()); 
  // Chạy ứng dụng Flutter, khởi tạo với widget gốc là MyApp
}

class MyApp extends StatelessWidget {
  const MyApp({super.key}); 
  // Constructor mặc định cho MyApp, sử dụng từ khóa const để tạo một widget bất biến

  @override
  Widget build(BuildContext context) {
    // Phương thức build để tạo giao diện của ứng dụng
    return MaterialApp(
      debugShowCheckedModeBanner: false, 
      // Tắt banner chế độ debug ở góc trên cùng bên phải của ứng dụng

      home: Main_Page(), 
      // Đặt Main_Page làm trang chính của ứng dụng
    );
  }
}
