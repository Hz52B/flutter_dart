Hướng dẫn cài đặt và chạy ứng dụng NotesApp
Đây là hướng dẫn cài đặt và chạy ứng dụng NotesApp trên thiết bị của bạn.

Yêu cầu hệ thống
Trước khi cài đặt, hãy đảm bảo rằng máy tính của bạn đáp ứng các yêu cầu hệ thống sau:

Flutter SDK được cài đặt và được thiết lập môi trường (xem hướng dẫn cài đặt tại trang chủ của Flutter)
Một trình biên dịch mã như Android Studio hoặc Visual Studio Code

##Cài đặt
Bước 1: Clone repository từ GitHub về máy tính của bạn:
git clone https://github.com/Hz52B/flutter_dart/tree/main/note_app

Bước 2: Giải nén rồi tiến hành mở sau đó cập nhật các dependencies bằng lệnh:
flutter pub get

##Chạy ứng dụng
Sau khi đã cài đặt, bạn có thể chạy ứng dụng trên thiết bị mô phỏng hoặc thiết bị thật. Dưới đây là các bước:

Chạy trên máy ảo (emulator)
Bước 1: Mở trình biên dịch mã của bạn (Android Studio, Visual Studio Code, etc.).

Bước 2: Mở một thiết bị mô phỏng hoặc tạo một thiết bị mô phỏng mới.

Bước 3: Chạy lệnh sau trong thư mục của dự án:
flutter run
Ứng dụng sẽ tự động cài đặt và chạy trên máy ảo của bạn.

Chạy trên thiết bị thật
Bước 1: Kết nối thiết bị của bạn với máy tính sử dụng cáp USB.

Bước 2: Mở chế độ gỡ lỗi USB trên thiết bị của bạn.

Bước 3: Chạy lệnh sau trong thư mục của dự án:
flutter run
Ứng dụng sẽ được cài đặt và chạy trên thiết bị của bạn.