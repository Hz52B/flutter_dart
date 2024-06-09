// Import các thư viện cần thiết
import 'package:cloud_firestore/cloud_firestore.dart'; // Thư viện Cloud Firestore của Firebase
import 'package:firebase_auth/firebase_auth.dart'; // Thư viện Firebase Auth để xác thực người dùng
import 'package:flutter/material.dart'; // Thư viện Flutter để xây dựng giao diện người dùng
import 'package:NotesApp/model/notes_model.dart'; // Model ghi chú của ứng dụng
import 'package:uuid/uuid.dart'; // Thư viện để tạo UUID


// Định nghĩa lớp Firestore_Datasource để quản lý dữ liệu trên Firestore
class Firestore_Datasource {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Khởi tạo Firestore
  final FirebaseAuth _auth = FirebaseAuth.instance; // Khởi tạo FirebaseAuth

  // Hàm tạo người dùng mới trên Firestore
  Future<bool> CreateUser(String email) async {
    try {
      await _firestore
          .collection('users') // Chọn collection 'users'
          .doc(_auth.currentUser!.uid) // Chọn document có id của người dùng hiện tại
          .set({"id": _auth.currentUser!.uid, "email": email}); // Thiết lập dữ liệu cho document
      return true; // Trả về true nếu thành công
    } catch (e) {
      print(e); // In lỗi ra console
      return true; // Trả về true ngay cả khi có lỗi
    }
  }

  // Hàm thêm ghi chú mới
  Future<bool> AddNote(String subtitle, String title, int image) async {
    try {
      var uuid = Uuid().v4(); // Tạo một UUID mới cho ghi chú
      DateTime data = new DateTime.now(); // Lấy thời gian hiện tại
      await _firestore
          .collection('users') // Chọn collection 'users'
          .doc(_auth.currentUser!.uid) // Chọn document có id của người dùng hiện tại
          .collection('notes') // Chọn subcollection 'notes'
          .doc(uuid) // Chọn document với id là UUID vừa tạo
          .set({
        'id': uuid,
        'subtitle': subtitle,
        'isDon': false, // Ghi chú chưa hoàn thành
        'image': image,
        'time': '${data.day}/${data.month}/${data.year}', // Lưu thời gian tạo ghi chú
        'title': title,
      });
      return true; // Trả về true nếu thành công
    } catch (e) {
      print(e); // In lỗi ra console
      return true; // Trả về true ngay cả khi có lỗi
    }
  }

  // Hàm lấy danh sách ghi chú từ snapshot
  List getNotes(AsyncSnapshot snapshot) {
    try {
      final notesList = snapshot.data!.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return Note(
          data['id'],
          data['subtitle'],
          data['time'],
          data['image'],
          data['title'],
          data['isDon'],
        );
      }).toList();
      return notesList; // Trả về danh sách ghi chú
    } catch (e) {
      print(e); // In lỗi ra console
      return []; // Trả về danh sách rỗng nếu có lỗi
    }
  }

  // Hàm tạo stream để theo dõi ghi chú
  Stream<QuerySnapshot> stream(bool isDone) {
    return _firestore
        .collection('users') // Chọn collection 'users'
        .doc(_auth.currentUser!.uid) // Chọn document có id của người dùng hiện tại
        .collection('notes') // Chọn subcollection 'notes'
        .where('isDon', isEqualTo: isDone) // Lọc ghi chú theo trạng thái hoàn thành
        .snapshots(); // Trả về stream của các snapshot
  }

  // Hàm cập nhật trạng thái hoàn thành của ghi chú
  Future<bool> isdone(String uuid, bool isDon) async {
    try {
      await _firestore
          .collection('users') // Chọn collection 'users'
          .doc(_auth.currentUser!.uid) // Chọn document có id của người dùng hiện tại
          .collection('notes') // Chọn subcollection 'notes'
          .doc(uuid) // Chọn document với id là UUID của ghi chú
          .update({'isDon': isDon}); // Cập nhật trạng thái hoàn thành
      return true; // Trả về true nếu thành công
    } catch (e) {
      print(e); // In lỗi ra console
      return true; // Trả về true ngay cả khi có lỗi
    }
  }

  // Hàm cập nhật ghi chú
  Future<bool> Update_Note(
      String uuid, int image, String title, String subtitle) async {
    try {
      DateTime data = new DateTime.now(); // Lấy thời gian hiện tại
      await _firestore
          .collection('users') // Chọn collection 'users'
          .doc(_auth.currentUser!.uid) // Chọn document có id của người dùng hiện tại
          .collection('notes') // Chọn subcollection 'notes'
          .doc(uuid) // Chọn document với id là UUID của ghi chú
          .update({
        'time': '${data.day}/${data.month}/${data.year}', // Cập nhật thời gian
        'subtitle': subtitle,
        'title': title,
        'image': image,
      });
      return true; // Trả về true nếu thành công
    } catch (e) {
      print(e); // In lỗi ra console
      return true; // Trả về true ngay cả khi có lỗi
    }
  }

  // Hàm xóa ghi chú
  Future<bool> delet_note(String uuid) async {
    try {
      await _firestore
          .collection('users') // Chọn collection 'users'
          .doc(_auth.currentUser!.uid) // Chọn document có id của người dùng hiện tại
          .collection('notes') // Chọn subcollection 'notes'
          .doc(uuid) // Chọn document với id là UUID của ghi chú
          .delete(); // Xóa ghi chú
      return true; // Trả về true nếu thành công
    } catch (e) {
      print(e); // In lỗi ra console
      return true; // Trả về true ngay cả khi có lỗi
    }
  }
}
