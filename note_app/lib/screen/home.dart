// Import thư viện Flutter và các màn hình, widget cần thiết
import 'package:flutter/material.dart';
import 'package:NotesApp/screen/add_note_screen.dart'; // Import màn hình thêm ghi chú
import 'package:NotesApp/widgets/stream_note.dart'; // Import widget hiển thị danh sách ghi chú từ Stream

// Định nghĩa một StatefulWidget để tạo màn hình chính của ứng dụng
class Home_Screen extends StatefulWidget {
  const Home_Screen({Key? key}) : super(key: key);

  @override
  State<Home_Screen> createState() => _Home_ScreenState();
}

// Biến toàn cục để điều khiển hiển thị FloatingActionButton
bool show = true; 

// Trạng thái của Home_Screen
class _Home_ScreenState extends State<Home_Screen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Số lượng tab
      child: Scaffold(
        backgroundColor: Color.fromARGB(255, 241, 240, 240), // Màu nền của Scaffold
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 241, 240, 240), // Màu nền của AppBar
          title: Row(
            children: [
              Text(
                "Notes",
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "App",
                style: TextStyle(
                  color: Colors.orange,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          bottom: TabBar(
            tabs: [
              Tab(
                child: Text(
                  "Chưa hoàn thành",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(Icons.assignment_outlined, color: Colors.red[400]),
              ),
              Tab(
                child: Text(
                  "Hoàn thành",
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                icon: Icon(Icons.assignment_turned_in, color: Colors.green[400]),
              ),
            ],
          ),
        ),
        floatingActionButton: Visibility(
          visible: show, // Điều khiển hiển thị FloatingActionButton
          child: FloatingActionButton(
            onPressed: () {
              // Điều hướng đến màn hình thêm ghi chú khi bấm vào nút
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddScreen(),
              ));
            },
            backgroundColor: Color.fromARGB(255, 120, 233, 124), // Màu nền của FloatingActionButton
            child: Icon(Icons.add, size: 30),
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stream_note(false), // Tab 1: Hiển thị danh sách ghi chú chưa hoàn thành
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Stream_note(true), // Tab 2: Hiển thị danh sách ghi chú đã hoàn thành
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
