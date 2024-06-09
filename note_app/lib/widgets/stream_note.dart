import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firestore từ Firebase
import 'package:flutter/material.dart'; // Import Flutter Material
import 'package:NotesApp/widgets/task_widgets.dart'; // Import widget Task_Widget từ ứng dụng
import '../data/firestore.dart'; // Import nguồn dữ liệu Firestore từ ứng dụng

// Định nghĩa lớp Stream_note kế thừa StatelessWidget
// ignore: must_be_immutable
class Stream_note extends StatelessWidget {
  bool done; // Biến boolean để kiểm tra trạng thái "done" của ghi chú

  // Hàm khởi tạo của lớp, nhận vào biến boolean done
  Stream_note(this.done, {super.key});

  @override
  Widget build(BuildContext context) {
    // Hàm build để xây dựng giao diện người dùng
    return StreamBuilder<QuerySnapshot>(
        stream: Firestore_Datasource().stream(done), // Lấy luồng dữ liệu từ Firestore dựa trên trạng thái "done"
        builder: (context, snapshot) {
          // Hàm builder để xử lý dữ liệu từ luồng
          if (!snapshot.hasData) {
            // Nếu chưa có dữ liệu (snapshot chưa hoàn thành)
            return CircularProgressIndicator(); // Hiển thị vòng quay tải dữ liệu
          }
          final noteslist = Firestore_Datasource().getNotes(snapshot); // Lấy danh sách ghi chú từ snapshot
          return ListView.builder(
            // Tạo một ListView để hiển thị danh sách ghi chú
            shrinkWrap: true, // Đặt shrinkWrap để danh sách không chiếm toàn bộ không gian
            itemBuilder: (context, index) {
              final note = noteslist[index]; // Lấy ghi chú tại vị trí index trong danh sách
              return Task_Widget(note); // Sử dụng widget Task_Widget để hiển thị ghi chú
            },
            itemCount: noteslist.length, // Đặt số lượng phần tử trong danh sách bằng độ dài của noteslist
          );
        });
  }
}
