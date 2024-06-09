// Import thư viện Firebase Auth để sử dụng chức năng xác thực người dùng
import 'package:firebase_auth/firebase_auth.dart';


// Import file firestore.dart từ thư mục data để sử dụng các hàm liên quan đến Firestore
import 'package:NotesApp/data/firestore.dart';

// Định nghĩa một lớp trừu tượng (abstract class) AuthenticationDatasource
// Lớp này chứa các phương thức mà các lớp con cần phải triển khai
abstract class AuthenticationDatasource {
  // Phương thức đăng ký người dùng mới, nhận vào email, mật khẩu và mật khẩu xác nhận
  Future<void> register(String email, String password, String passwordConfirm);
  
  // Phương thức đăng nhập người dùng, nhận vào email và mật khẩu
  Future<bool> login(String email, String password);
}

// Định nghĩa lớp AuthenticationRemote triển khai (implement) từ AuthenticationDatasource
class AuthenticationRemote implements AuthenticationDatasource {
  // Triển khai phương thức đăng nhập
  @override
  Future<bool> login(String email, String password) async {
    try {
      // Sử dụng FirebaseAuth để đăng nhập với email và mật khẩu
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      return true;  // Trả về true nếu đăng nhập thành công
    } on FirebaseAuthException catch (e) {
      // Bắt các ngoại lệ (exceptions) liên quan đến FirebaseAuth
      if (e.code == 'user-not-found') {
        return false;  // Trả về false nếu không tìm thấy người dùng
      } else if (e.code == 'wrong-password') {
        return false;  // Trả về false nếu mật khẩu sai
      } else {
        return false;  // Trả về false cho các lỗi khác
      }
    }
  }

  // Triển khai phương thức đăng ký
  @override
  Future<void> register(String email, String password, String passwordConfirm) async {
    // Kiểm tra xem mật khẩu xác nhận có khớp với mật khẩu không
    if (passwordConfirm == password) {
      try {
        // Sử dụng FirebaseAuth để tạo người dùng mới với email và mật khẩu
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email.trim(), password: password.trim())
            .then((value) {
          // Sau khi tạo người dùng thành công, gọi hàm CreateUser trong Firestore_Datasource để tạo thông tin người dùng trong Firestore
          Firestore_Datasource().CreateUser(email);
        });
      } on FirebaseAuthException catch (e) {
        // Bắt các ngoại lệ liên quan đến FirebaseAuth
        if (e.code == 'email-already-in-use') {
          throw Exception('Email đã được sử dụng.');  // Ném ngoại lệ nếu email đã được sử dụng
        } else if (e.code == 'weak-password') {
          throw Exception('Mật khẩu quá yếu.');  // Ném ngoại lệ nếu mật khẩu quá yếu
        } else {
          throw Exception('Đã xảy ra lỗi. Vui lòng thử lại.');  // Ném ngoại lệ cho các lỗi khác
        }
      }
    } else {
      throw Exception('Mật khẩu xác nhận không khớp.');  // Ném ngoại lệ nếu mật khẩu xác nhận không khớp
    }
  }
}
