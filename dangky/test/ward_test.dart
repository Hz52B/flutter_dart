import 'package:flutter_test/flutter_test.dart';
import 'package:dangky/ward.dart';


void main() {
  group('Ward', () {
    test('Kiểm tra phương thức CopyWith', () {
      final ward = Ward(
        id: '00034', 
        name: 'Phường Thành Công', 
        level: 'Phường', 
        districtId: '001', 
        provinceId: '01'
      );
      final copiedWard = ward.copyWith(name: 'Cập nhật');
      expect(copiedWard.name, 'Cập nhật');
      expect(copiedWard.id, ward.id); 
    });

    test('Kiểm tra xem phương thức toMap có trả về một Map chứa các giá trị đúng hay không', () {
      final ward = Ward(
        id: '00034', 
        name: 'Phường Thành Công', 
        level: 'Phường', 
        districtId: '001', 
        provinceId: '01'
      );
      final map = ward.toMap();
      expect(map['id'], '00034');
      expect(map['name'], 'Phường Thành Công');
      expect(map['level'], 'Phường');
      expect(map['districtId'], '001');
      expect(map['provinceId'], '01');
    });

    test('Kiểm tra xem phương thức fromJson khởi tạo một đối tượng Ward từ một chuỗi JSON đúng cách hay không', () {
      const jsonString = '{"id": "00034", "name": "Phường Thành Công", "level": "Phường", "districtId": "001", "provinceId": "01"}';
      final ward = Ward.fromJson(jsonString);
      expect(ward.id, '00034');
      expect(ward.name, 'Phường Thành Công');
      expect(ward.level, 'Phường');
      expect(ward.districtId, '001');
      expect(ward.provinceId, '01');
    });

    test('Đảm bảo rằng phương thức toJson chuyển đổi một đối tượng Ward thành một chuỗi JSON đúng cách', () {
      final ward = Ward(
        id: '00034', 
        name: 'Phường Thành Công', 
        level: 'Phường', 
        districtId: '001', 
        provinceId: '01'
      );

      final jsonString = ward.toJson();
      expect(jsonString, '{"id":"00034","name":"Phường Thành Công","level":"Phường","districtId":"001","provinceId":"01"}');
    });

    test('Kiểm tra xem phương thức toString có trả về một chuỗi biểu diễn đúng của đối tượng Ward hay không', () {
      final ward = Ward(
        id: '00034', 
        name: 'Phường Thành Công', 
        level: 'Phường', 
        districtId: '001', 
        provinceId: '01'
      );
      final str = ward.toString();
      expect(str, 'Ward(id: 00034, name: Phường Thành Công, level: Phường, districtId: 001, provinceId: 01)');
    });

    test('So sánh 2 đối tượng giống nhau', () {
      final ward1 = Ward(
        id: '00034', 
        name: 'Phường Thành Công', 
        level: 'Phường', 
        districtId: '001', 
        provinceId: '01'
      );
      final ward2 = Ward(
        id: '00034', 
        name: 'Phường Thành Công', 
        level: 'Phường', 
        districtId: '001', 
        provinceId: '01'
      );
      final ward3 = Ward(
        id: '00037', 
        name: 'Phường Phúc Tân', 
        level: 'Phường', 
        districtId: '002', 
        provinceId: '01'
      );
      
      expect(ward1, equals(ward2));
      expect(ward1 == ward3, false);
    });

    test('đảm bảo rằng giá trị hash code của hai đối tượng Ward giống nhau nếu chúng giống nhau', () {
      final ward1 = Ward(
        id: '00034', 
        name: 'Phường Thành Công', 
        level: 'Phường', 
        districtId: '001', 
        provinceId: '01'
      );
      final ward2 = Ward(
        id: '00034', 
        name: 'Phường Thành Công', 
        level: 'Phường', 
        districtId: '001', 
        provinceId: '01'
      );
      
      expect(ward1.hashCode, equals(ward2.hashCode));
    });
  });
}
