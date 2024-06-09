import 'package:flutter/material.dart'; // Thư viện Flutter cơ bản cho việc tạo giao diện người dùng.
import 'package:NotesApp/screen/home.dart'; // Import màn hình chính từ file home.dart.
import 'package:NotesApp/screen/profile.dart'; // Import màn hình hồ sơ từ file profile.dart.
import 'package:curved_navigation_bar/curved_navigation_bar.dart'; // Import thư viện thanh điều hướng cong.

class BottomNav extends StatefulWidget {
  const BottomNav({super.key}); // Constructor cho BottomNav.

  @override
  State<BottomNav> createState() => _BottomNavState(); // Tạo State cho BottomNav.
}

class _BottomNavState extends State<BottomNav> {
  late List<Widget> pages; // Danh sách các trang sẽ được hiển thị.

  late Home_Screen HomePage; // Biến cho trang Home.
  late Profile profile; // Biến cho trang Profile.
  int tabIndex = 0; // Biến để lưu chỉ mục của trang hiện tại trong thanh điều hướng.

  @override
  void initState() {
    HomePage = Home_Screen(); // Khởi tạo trang Home.
    profile = Profile(); // Khởi tạo trang Profile.
    pages = [HomePage, profile]; // Đưa các trang vào danh sách pages.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        height: 65, // Chiều cao của thanh điều hướng.
        backgroundColor: Color.fromARGB(255, 241, 240, 240), // Màu nền của thanh điều hướng.
        color: Colors.black87, // Màu của thanh điều hướng.
        animationDuration: Duration(milliseconds: 500), // Thời gian của hiệu ứng chuyển đổi giữa các tab.
        onTap: (int index) {
          setState(() {
            tabIndex = index; // Cập nhật chỉ mục của trang hiện tại khi tab được chọn.
          });
        },
        items: [
          Icon(
            Icons.home_outlined, // Icon cho trang Home.
            color: Colors.white, // Màu sắc của icon.
          ),
          Icon(
            Icons.person_outline, // Icon cho trang Profile.
            color: Colors.white, // Màu sắc của icon.
          ),
        ],
      ),
      body: pages[tabIndex], // Hiển thị trang tương ứng với chỉ mục tab hiện tại.
    );
  }
}
