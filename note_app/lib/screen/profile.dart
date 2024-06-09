// Import các thư viện cần thiết
import 'package:flutter/material.dart';
import 'package:NotesApp/screen/login.dart'; // Import màn hình đăng nhập
import 'package:firebase_auth/firebase_auth.dart'; // Import thư viện Firebase Auth để xác thực người dùng

// Định nghĩa màn hình Profile
class Profile extends StatefulWidget {
  const Profile({super.key});
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String email = '';

  @override
  void initState() {
    super.initState();
    _getUserEmail(); // Lấy email người dùng khi khởi tạo
  }

  // Hàm lấy email của người dùng hiện tại từ Firebase
  void _getUserEmail() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        email = user.email ?? 'No email'; // Cập nhật email vào biến state
      });
    }
  }

  // Hàm chuyển hướng đến màn hình đăng nhập (hiện tại chỉ in ra log)
  void _showLoginScreen() {
    print('Navigating to login screen');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 241, 240, 240),
        title: Center(
          child: Text(
            "Profile",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      backgroundColor: Color.fromARGB(255, 241, 240, 240),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị avatar của người dùng
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('images/avatar.png'), // Đường dẫn tới hình ảnh avatar
                  radius: 50, // Kích thước avatar
                ),
              ],
            ),
            SizedBox(height: 20),
            // Hiển thị email của người dùng
            Card(
              color: Colors.white,
              shadowColor: Colors.amber[300],
              surfaceTintColor: Colors.white,
              elevation: 4.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.email, color: Color.fromARGB(255, 120, 233, 124)),
                title: Text(
                  'Email',
                  style: TextStyle(fontSize: 20),
                ),
                subtitle: Text(
                  email,
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Nút đăng xuất
            Card(
              color: Colors.white,
              shadowColor: Colors.amber[300],
              surfaceTintColor: Colors.white,
              elevation: 4.0,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: ListTile(
                leading: Icon(Icons.exit_to_app, color: Color.fromARGB(255, 120, 233, 124)),
                title: Text(
                  'Sign Out',
                  style: TextStyle(fontSize: 20),
                ),
                onTap: () async {
                  await FirebaseAuth.instance.signOut(); // Thực hiện đăng xuất
                  print('User signed out');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LogIN_Screen(_showLoginScreen)), // Chuyển hướng đến màn hình đăng nhập
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
