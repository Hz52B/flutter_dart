import 'package:flutter/material.dart';
import 'package:NotesApp/data/auth_data.dart'; // Import file chứa các hàm xác thực

// Định nghĩa màn hình đăng ký
class SignUp_Screen extends StatefulWidget {
  final VoidCallback show; // Hàm callback để chuyển đổi giữa màn hình đăng ký và đăng nhập
  SignUp_Screen(this.show, {super.key}); // Constructor cho phép truyền callback
  @override
  State<SignUp_Screen> createState() => _SignUp_ScreenState();
}

class _SignUp_ScreenState extends State<SignUp_Screen> {
  FocusNode _focusNode1 = FocusNode(); // FocusNode cho trường email
  FocusNode _focusNode2 = FocusNode(); // FocusNode cho trường password
  FocusNode _focusNode3 = FocusNode(); // FocusNode cho trường xác nhận password

  final email = TextEditingController(); // Controller cho trường email
  final password = TextEditingController(); // Controller cho trường password
  final PasswordConfirm = TextEditingController(); // Controller cho trường xác nhận password

  bool _isPasswordVisible = false; // Biến boolean để điều khiển hiển thị mật khẩu

  @override
  void initState() {
    super.initState();
    // Listener cho các FocusNode để cập nhật giao diện khi focus thay đổi
    _focusNode1.addListener(() {
      setState(() {});
    });
    _focusNode2.addListener(() {
      setState(() {});
    });
    _focusNode3.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20),
              image(), // Hiển thị hình ảnh trên cùng
              SizedBox(height: 50),
              textfield(email, _focusNode1, 'Email', Icons.email, false), // Trường nhập email
              SizedBox(height: 10),
              textfield(password, _focusNode2, 'Password', Icons.password, true), // Trường nhập password
              SizedBox(height: 10),
              textfield(PasswordConfirm, _focusNode3, 'PasswordConfirm', Icons.password, true), // Trường xác nhận password
              SizedBox(height: 8),
              account(), // Liên kết đến màn hình đăng nhập
              SizedBox(height: 20),
              SignUP_bottom(), // Nút đăng ký
            ],
          ),
        ),
      ),
    );
  }

  // Widget hiển thị liên kết đến màn hình đăng nhập
  Widget account() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            "Bạn đã có tài khoản?",
            style: TextStyle(color: Colors.grey[700], fontSize: 14),
          ),
          SizedBox(width: 5),
          GestureDetector(
            onTap: widget.show, // Khi nhấp vào sẽ gọi hàm callback để hiển thị màn hình đăng nhập
            child: Text(
              'Đăng nhập',
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

  // Widget nút đăng ký
  Widget SignUP_bottom() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: GestureDetector(
        onTap: () async {
          try {
            // Gọi hàm đăng ký từ AuthenticationRemote và chờ kết quả
            await AuthenticationRemote().register(email.text, password.text, PasswordConfirm.text);
            // Hiển thị thông báo thành công
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Đăng ký thành công')),
            );
          } catch (e) {
            // Hiển thị thông báo lỗi
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(e.toString())),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 120, 233, 124),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Đăng ký',
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

  // Widget tạo trường nhập liệu
  Widget textfield(TextEditingController _controller, FocusNode _focusNode,
      String typeName, IconData iconss, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: TextField(
          controller: _controller, // Điều khiển nội dung của trường nhập liệu
          focusNode: _focusNode, // Điều khiển trạng thái focus của trường nhập liệu
          obscureText: isPassword ? !_isPasswordVisible : false, // Ẩn/hiện mật khẩu
          style: TextStyle(fontSize: 18, color: Colors.black),
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
                        _isPasswordVisible = !_isPasswordVisible; // Chuyển đổi trạng thái hiển thị mật khẩu
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

  // Widget hiển thị hình ảnh
  Widget image() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        width: double.infinity,
        height: 300,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 240, 240),
          image: DecorationImage(
            image: AssetImage('images/lgg.png'),
            fit: BoxFit.fitWidth,
          ),
        ),
      ),
    );
  }
}
