// Import thư viện Flutter và các tập tin cần thiết
import 'package:flutter/material.dart';
import 'package:NotesApp/data/auth_data.dart'; // Import tập tin thao tác với dữ liệu xác thực
import 'package:NotesApp/auth/main_page.dart'; // Import màn hình chính sau khi đăng nhập

// Định nghĩa màn hình đăng nhập
class LogIN_Screen extends StatefulWidget {
  final VoidCallback show; // Hàm callback để hiển thị màn hình đăng ký
  LogIN_Screen(this.show, {super.key});

  @override
  State<LogIN_Screen> createState() => _LogIN_ScreenState();
}

class _LogIN_ScreenState extends State<LogIN_Screen> {
  // Khai báo FocusNode cho các trường nhập liệu
  FocusNode _focusNode1 = FocusNode();
  FocusNode _focusNode2 = FocusNode();

  // Khai báo các TextEditingController để điều khiển nội dung của các trường nhập liệu
  final email = TextEditingController();
  final password = TextEditingController();

  bool _isPasswordVisible = false; // Biến để điều khiển hiển thị mật khẩu

  @override
  void initState() {
    super.initState();
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Màu nền của Scaffold
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              image(), // Hiển thị hình ảnh
              SizedBox(height: 50),
              textfield(email, _focusNode1, 'Email', Icons.email, false), // Trường nhập email
              SizedBox(height: 10),
              textfield(password, _focusNode2, 'Password', Icons.password, true), // Trường nhập mật khẩu
              SizedBox(height: 8),
              account(), // Liên kết đến màn hình đăng ký
              SizedBox(height: 20),
              Login_button(context), // Nút đăng nhập
            ],
          ),
        ),
      ),
    );
  }

  // Widget cho phần liên kết đến màn hình đăng ký
  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Bạn không có tài khoản?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show, // Khi nhấp vào sẽ gọi hàm callback show để hiển thị màn hình đăng ký
            child: Text(
              'Đăng ký',
              style: TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget cho nút đăng nhập
  Widget Login_button(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async {
          // Gọi hàm đăng nhập và chờ kết quả
          bool loginSuccess = await AuthenticationRemote().login(email.text, password.text);
          if (loginSuccess) {
            // Chuyển hướng đến màn hình chính nếu đăng nhập thành công
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Main_Page()),
            );
          } else {
            // Hiển thị thông báo lỗi nếu đăng nhập thất bại
            String errorMessage = email.text.isEmpty || password.text.isEmpty
                ? 'Vui lòng nhập email và mật khẩu'
                : 'Email hoặc mật khẩu không chính xác';
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(errorMessage)),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 120, 233, 124), // Màu nền của nút đăng nhập
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Đăng nhập',
            style: TextStyle(
              color: Colors.white,
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  // Widget cho trường nhập liệu
  Widget textfield(TextEditingController _controller, FocusNode _focusNode, String typeName, IconData iconss, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _controller, // Điều khiển nội dung trường nhập liệu
          focusNode: _focusNode, // Điều khiển trạng thái focus của trường nhập liệu
          style: TextStyle(fontSize: 18, color: Colors.black),
          obscureText: isPassword ? !_isPasswordVisible : false, // Điều khiển hiển thị mật khẩu
          decoration: InputDecoration(
            prefixIcon: Icon(
              iconss,
              color: _focusNode.hasFocus ? Color.fromARGB(255, 120, 233, 124) : Color(0xffc5c5c5), // Màu của icon tùy theo trạng thái focus
            ),
            suffixIcon: isPassword
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off, // Icon cho việc hiển thị mật khẩu
                      color: _focusNode.hasFocus ? Color.fromARGB(255, 120, 233, 124) : Color(0xffc5c5c5),
                    ),
                    onPressed: () {
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible; // Thay đổi trạng thái hiển thị mật khẩu
                      });
                    },
                  )
                : null,
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: typeName, // Placeholder cho trường nhập liệu
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5),
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 120, 233, 124),
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget cho phần hiển thị hình ảnh
  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 240, 240),
          image: DecorationImage(
            image: AssetImage('images/lgg.png'), // Hiển thị hình ảnh từ asset
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
