import 'package:flutter/material.dart';
import 'package:NotesApp/data/firestore.dart'; // Import tập tin thao tác với Firestore
import 'package:NotesApp/model/notes_model.dart'; // Import mô hình dữ liệu của ghi chú

// Lớp StatefulWidget cho màn hình chỉnh sửa ghi chú
// ignore: must_be_immutable
class Edit_Screen extends StatefulWidget {
  Note _note; // Biến lưu trữ ghi chú được chỉnh sửa
  Edit_Screen(this._note, {super.key}); // Constructor nhận ghi chú cần chỉnh sửa
  @override
  State<Edit_Screen> createState() => _Edit_ScreenState();
}

class _Edit_ScreenState extends State<Edit_Screen> {
  TextEditingController? title; // Controller cho trường nhập tiêu đề
  TextEditingController? subtitle; // Controller cho trường nhập nội dung

  FocusNode _focusNode1 = FocusNode(); // FocusNode cho tiêu đề
  FocusNode _focusNode2 = FocusNode(); // FocusNode cho nội dung
  int indexx = 0; // Biến lưu trữ chỉ mục của hình ảnh được chọn

  @override
  void initState() {
    super.initState();
    // Khởi tạo giá trị cho controller từ đối tượng ghi chú
    title = TextEditingController(text: widget._note.title);
    subtitle = TextEditingController(text: widget._note.subtitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 241, 240, 240), // Màu nền của Scaffold
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            title_widgets(), // Widget cho trường nhập tiêu đề
            SizedBox(height: 20), // Khoảng cách giữa các widget
            subtite_wedgite(), // Widget cho trường nhập nội dung
            SizedBox(height: 20), // Khoảng cách giữa các widget
            imagess(), // Widget hiển thị danh sách hình ảnh có thể chọn
            SizedBox(height: 20), // Khoảng cách giữa các widget
            button() // Widget cho các nút bấm Lưu và Hủy
          ],
        ),
      ),
    );
  }

  // Widget cho các nút bấm Lưu và Hủy
  Widget button() {
    return Row(
      // Sắp xếp các nút ngang nhau với khoảng cách đều nhau
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        // Tạo nút "Lưu"
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 120, 233, 124), // Màu nền của nút là màu xanh tùy chỉnh
            minimumSize: Size(170, 48), // Kích thước tối thiểu của nút
          ),
          onPressed: () {
            // Hàm lưu ghi chú đã chỉnh sửa
            Firestore_Datasource().Update_Note(
                widget._note.id, indexx, title!.text, subtitle!.text);
            Navigator.pop(context); // Đóng cửa sổ hiện tại
          },
          child: Text('Lưu', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        // Tạo nút "Hủy"
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red, // Màu nền của nút là màu đỏ
            minimumSize: Size(170, 48), // Kích thước tối thiểu của nút
          ),
          onPressed: () {
            Navigator.pop(context); // Thoát khỏi màn hình hiện tại
          },
          child: Text('Hủy', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
      ],
    );
  }

  // Widget hiển thị danh sách hình ảnh có thể chọn
  Container imagess() {
    return Container(
      height: 180, // Chiều cao của container chứa hình ảnh
      child: ListView.builder(
        itemCount: 4, // Số lượng hình ảnh
        scrollDirection: Axis.horizontal, // Cuộn theo chiều ngang
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              setState(() {
                indexx = index; // Cập nhật chỉ mục khi chọn hình ảnh
              });
            },
            child: Padding(
              padding: EdgeInsets.only(left: index == 0 ? 7 : 0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10), // Bo góc cho container
                  border: Border.all(
                    width: 2,
                    color: indexx == index ? Color.fromARGB(255, 120, 233, 124) : Colors.grey, // Đổi màu viền khi chọn hình ảnh
                  ),
                ),
                width: 140, // Chiều rộng của mỗi container chứa hình ảnh
                margin: EdgeInsets.all(8), // Khoảng cách xung quanh mỗi container
                child: Column(
                  children: [
                    Image.asset('images/${index}.jpg'), // Hiển thị hình ảnh
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Widget cho nhập tiêu đề
  Widget title_widgets() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Màu nền của container
          borderRadius: BorderRadius.circular(15), // Bo góc cho container
        ),
        child: TextField(
          controller: title,
          focusNode: _focusNode1,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              hintText: 'Tiêu đề', // Văn bản gợi ý
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color(0xffc5c5c5), // Màu viền khi không được chọn
                  width: 2.0,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  color: Color.fromARGB(255, 120, 233, 124), // Màu viền khi được chọn
                  width: 2.0,
                ),
              )),
        ),
      ),
    );
  }

  // Widget cho nhập nội dung
  Padding subtite_wedgite() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Màu nền của container
          borderRadius: BorderRadius.circular(15), // Bo góc cho container
        ),
        child: TextField(
          maxLines: 3, // Số dòng tối đa
          controller: subtitle,
          focusNode: _focusNode2,
          style: TextStyle(fontSize: 18, color: Colors.black),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            hintText: 'Nội dung', // Văn bản gợi ý
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color(0xffc5c5c5), // Màu viền khi không được chọn
                width: 2.0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 120, 233, 124), // Màu viền khi được chọn
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
