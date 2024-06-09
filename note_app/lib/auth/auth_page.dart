import 'package:flutter/material.dart'; // Thư viện Flutter cơ bản cho việc tạo giao diện người dùng.
import 'package:NotesApp/screen/signup.dart'; // Import màn hình đăng ký từ file signup.dart.
import 'package:NotesApp/screen/login.dart'; // Import màn hình đăng nhập từ file login.dart.

// Tạo một StatefulWidget tên là Auth_Page.
class Auth_Page extends StatefulWidget {
  Auth_Page({super.key}); // Constructor cho Auth_Page.
  
  @override
  State<Auth_Page> createState() => _Auth_PageState(); // Tạo State cho Auth_Page.
}

// Tạo State cho Auth_Page.
class _Auth_PageState extends State<Auth_Page> {
  bool a = true; // Biến boolean để xác định màn hình hiện tại là đăng nhập hay đăng ký.

  // Hàm chuyển đổi giữa màn hình đăng nhập và đăng ký.
  void to() {
    setState(() {
      a = !a; // Đảo ngược giá trị của biến a.
    });
  }

  @override
  Widget build(BuildContext context) {
    // Kiểm tra giá trị của biến a để quyết định màn hình nào sẽ được hiển thị.
    if (a) {
      return LogIN_Screen(to); // Nếu a là true, hiển thị màn hình đăng nhập và truyền hàm to.
    } else {
      return SignUp_Screen(to); // Nếu a là false, hiển thị màn hình đăng ký và truyền hàm to.
    }
  }
}
