import 'package:flutter/material.dart'; // Thư viện Flutter cơ bản cho việc tạo giao diện người dùng.
import 'package:NotesApp/data/firestore.dart'; // Import các phương thức liên quan đến Firestore từ file firestore.dart.

// Tạo một StatefulWidget tên là AddScreen.
class AddScreen extends StatefulWidget {
  const AddScreen({super.key});
  @override
  State<AddScreen> createState() => _AddScreenState();
}

// Tạo State cho AddScreen.
class _AddScreenState extends State<AddScreen> {
  final title = TextEditingController(); // Tạo một TextEditingController để quản lý văn bản trong TextField tiêu đề.
  final subtitle = TextEditingController(); // Tạo một TextEditingController để quản lý văn bản trong TextField nội dung.

  FocusNode _focusNode1 = FocusNode(); // Tạo FocusNode để quản lý trạng thái focus của TextField tiêu đề.
  FocusNode _focusNode2 = FocusNode(); // Tạo FocusNode để quản lý trạng thái focus của TextField nội dung.
  int indexx = 0; // Biến lưu chỉ số của hình ảnh được chọn.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 240, 240), // Màu nền của Scaffold.
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Canh giữa các widget con theo chiều dọc.
          children: [
            titleWidgets(), // Gọi hàm tạo widget cho tiêu đề.
            SizedBox(height: 20), // Khoảng cách giữa các widget.
            subtitleWidget(), // Gọi hàm tạo widget cho nội dung.
            SizedBox(height: 20),
            images(), // Gọi hàm tạo widget hiển thị danh sách hình ảnh.
            SizedBox(height: 20),
            button() // Gọi hàm tạo widget cho các nút bấm.
          ],
        ),
      ),
    );
  }

  // Hàm tạo widget cho các nút bấm.
  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround, // Canh đều khoảng cách giữa các nút bấm.
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 120, 233, 124), // Màu nền của nút.
            minimumSize: Size(170, 48), // Kích thước tối thiểu của nút.
          ),
          onPressed: () {
            Firestore_Datasource().AddNote(subtitle.text, title.text, indexx); // Thêm ghi chú vào Firestore.
            Navigator.pop(context); // Đóng màn hình hiện tại.
          },
          child: Text(
            'Thêm',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black), // Kiểu chữ của nút.
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize: Size(170, 48),
          ),
          onPressed: () {
            Navigator.pop(context); // Đóng màn hình hiện tại.
          },
          child: Text(
            'Hủy',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ],
    );
  }

  // Hàm tạo widget hiển thị danh sách hình ảnh.
  Container images() {
    return Container(
      height: 180, // Chiều cao của container chứa hình ảnh.
      child: ListView.builder(
        itemCount: 8, // Số lượng hình ảnh.
        scrollDirection: Axis.horizontal, // Cuộn theo chiều ngang.
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                indexx = index; // Cập nhật chỉ số của hình ảnh được chọn.
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0), // Khoảng cách giữa các hình ảnh.
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Bo góc của container hình ảnh.
                  border: Border.all(
                    width: 2,
                    color: indexx == index ? const Color.fromARGB(255, 120, 233, 124) : Colors.grey, // Đổi màu viền khi hình ảnh được chọn.
                  ),
                ),
                width: 140, // Chiều rộng của container hình ảnh.
                margin: EdgeInsets.all(8), // Khoảng cách giữa các container hình ảnh.
                child: Column(
                  children: [
                    Image.asset('images/${index}.jpg'), // Đường dẫn đến hình ảnh.
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Hàm tạo widget cho TextField tiêu đề.
  Widget titleWidgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15), // Khoảng cách padding hai bên.
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Màu nền của container.
          borderRadius: BorderRadius.circular(15), // Bo góc của container.
        ),
        child: TextField(
          controller: title, // Điều khiển TextField bằng controller.
          focusNode: _focusNode1, // Gán focusNode.
          style: TextStyle(fontSize: 18, color: Colors.black), // Kiểu chữ của văn bản.
          maxLength: 20, // Giới hạn số ký tự.
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), // Khoảng cách padding bên trong TextField.
            hintText: 'Tiêu đề', // Văn bản gợi ý.
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5), // Màu viền khi không được focus.
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 120, 233, 124), // Màu viền khi được focus.
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Hàm tạo widget cho TextField nội dung.
  Padding subtitleWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15), // Khoảng cách padding hai bên.
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Màu nền của container.
          borderRadius: BorderRadius.circular(15), // Bo góc của container.
        ),
        child: TextField(
          maxLines: 3, // Số dòng tối đa.
          controller: subtitle, // Điều khiển TextField bằng controller.
          focusNode: _focusNode2, // Gán focusNode.
          style: TextStyle(fontSize: 18, color: Colors.black), // Kiểu chữ của văn bản.
          maxLength: 80, // Giới hạn số ký tự.
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15), // Khoảng cách padding bên trong TextField.
            hintText: 'Nội dung', // Văn bản gợi ý.
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5), // Màu viền khi không được focus.
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 120, 233, 124), // Màu viền khi được focus.
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
