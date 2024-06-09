import 'package:flutter/material.dart'; // Import Flutter Material
import 'package:NotesApp/data/firestore.dart'; // Import nguồn dữ liệu Firestore từ ứng dụng
import 'package:NotesApp/model/notes_model.dart'; // Import mô hình ghi chú từ ứng dụng
import 'package:NotesApp/screen/edit_screen.dart'; // Import màn hình chỉnh sửa từ ứng dụng

// ignore: must_be_immutable
class Task_Widget extends StatefulWidget {
  final Note _note; // Biến lưu trữ ghi chú
  Task_Widget(this._note, {super.key}); // Constructor nhận ghi chú làm tham số

  @override
  State<Task_Widget> createState() => _Task_WidgetState();
}

class _Task_WidgetState extends State<Task_Widget> {
  @override
  Widget build(BuildContext context) {
    bool isDone = widget._note.isDon; // Biến lưu trữ trạng thái hoàn thành của ghi chú
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10), // Đặt padding cho container
      child: Container(
        width: double.infinity,
        height: 160, // Chiều cao của container
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), // Bo tròn các góc container
          color: Colors.white, // Màu nền của container
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Màu bóng với độ mờ
              spreadRadius: 5, // Độ lan của bóng
              blurRadius: 7, // Độ mờ của bóng
              offset: Offset(0, 2), // Độ dịch chuyển của bóng
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10), // Padding cho phần nội dung bên trong
          child: Row(
            children: [
              // Hiển thị hình ảnh
              imageee(),
              SizedBox(width: 25), // Khoảng cách giữa hình ảnh và phần còn lại
              // Hiển thị tiêu đề và phụ đề
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái cho các phần tử con
                  children: [
                    SizedBox(height: 5), // Khoảng cách phía trên
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween, // Căn đều hai đầu cho các phần tử con
                      children: [
                        Text(
                          widget._note.title, // Tiêu đề của ghi chú
                          style: TextStyle(
                            fontSize: 18, // Kích thước chữ
                            fontWeight: FontWeight.bold, // Độ đậm chữ
                          ),
                        ),
                        Checkbox(
                          activeColor: Color.fromARGB(255, 120, 233, 124), // Màu khi checkbox được chọn
                          value: isDone, // Trạng thái checkbox
                          onChanged: (value) {
                            setState(() {
                              isDone = !isDone; // Thay đổi trạng thái checkbox
                            });
                            Firestore_Datasource()
                                .isdone(widget._note.id, isDone); // Cập nhật trạng thái ghi chú trong Firestore
                          },
                        )
                      ],
                    ),
                    Text(
                      widget._note.subtitle, // Phụ đề của ghi chú
                      style: TextStyle(
                          fontSize: 16, // Kích thước chữ
                          fontWeight: FontWeight.w400, // Độ đậm chữ
                          color: Colors.grey.shade400), // Màu chữ
                    ),
                    Spacer(), // Khoảng cách giữa các phần tử con
                    edit_time(), // Hiển thị thời gian và nút chỉnh sửa
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget để hiển thị thời gian và nút chỉnh sửa
  Widget edit_time() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10), // Padding cho thời gian và nút chỉnh sửa
      child: Row(
        children: [
          Container(
            width: 115,
            height: 28,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 120, 233, 124), // Màu nền
              borderRadius: BorderRadius.circular(18), // Bo tròn các góc
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 4,
              ),
              child: Row(
                children: [
                  Center(
                    child: Icon(
                      Icons.access_time, // Biểu tượng đồng hồ
                      color: Colors.white, // Màu biểu tượng
                      size: 20, // Kích thước biểu tượng
                    ),
                  ),
                  SizedBox(width: 10),
                  Center(
                    child: Text(
                      widget._note.time, // Thời gian của ghi chú
                      style: TextStyle(
                        color: Colors.white, // Màu chữ
                        fontSize: 14, // Kích thước chữ
                        fontWeight: FontWeight.bold, // Độ đậm chữ
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 20), // Khoảng cách giữa thời gian và nút chỉnh sửa
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => Edit_Screen(widget._note), // Điều hướng đến màn hình chỉnh sửa
              ));
            },
            child: Container(
              width: 90,
              height: 28,
              decoration: BoxDecoration(
                color: Color(0xffE2F6F1), // Màu nền nút chỉnh sửa
                borderRadius: BorderRadius.circular(18), // Bo tròn các góc
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Căn giữa các phần tử con
                  children: [
                    Center(
                      child: Icon(
                        Icons.edit, // Biểu tượng chỉnh sửa
                        color: Colors.black, // Màu biểu tượng
                        size: 20, // Kích thước biểu tượng
                      ),
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Text(
                        'Sửa', // Văn bản nút chỉnh sửa
                        style: TextStyle(
                          fontSize: 14, // Kích thước chữ
                          fontWeight: FontWeight.bold, // Độ đậm chữ
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(width: 20), // Khoảng cách giữa nút sửa và nút xóa
          GestureDetector(
            onTap: () {
              Firestore_Datasource().delet_note(widget._note.id); // Xóa ghi chú khỏi Firestore khi nút delete được ấn
            },
            child: Container(
              width: 90,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.red.shade100, // Màu nền nút xóa
                borderRadius: BorderRadius.circular(18), // Bo tròn các góc
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 4,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Căn giữa các phần tử con
                  children: [
                    Center(
                      child: Icon(
                        Icons.delete, // Biểu tượng xóa
                        color: Colors.black, // Màu biểu tượng
                        size: 20, // Kích thước biểu tượng
                      ),
                    ),
                    SizedBox(width: 10),
                    Center(
                      child: Text(
                        'Xóa', // Văn bản nút xóa
                        style: TextStyle(
                          fontSize: 14, // Kích thước chữ
                          fontWeight: FontWeight.bold, // Độ đậm chữ
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Widget để hiển thị hình ảnh
  Widget imageee() {
    return Container(
      height: 130,
      width: 100,
      decoration: BoxDecoration(
        color: Colors.white, // Màu nền của container hình ảnh
        image: DecorationImage(
          image: AssetImage('images/${widget._note.image}.jpg'), // Đường dẫn hình ảnh của ghi chú
          fit: BoxFit.cover, // Đặt hình ảnh vừa khít với container
        ),
      ),
    );
  }
}
