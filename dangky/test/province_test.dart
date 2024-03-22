import 'package:flutter_test/flutter_test.dart';
import 'package:dangky/province.dart';

void main() {
  group('Province', () {
    test('Tạo đối tượng Province', () {
      final province = Province(
        id: '00019',
        name: 'Phường Điện Biên',
        level: 'Phường',
      );

      expect(province.id, '00019');
      expect(province.name, 'Phường Điện Biên');
      expect(province.level, 'Phường');
    });

    test('Chuyển đổi Province sang JSON', () {
      final province = Province(
        id: '00019',
        name: 'Phường Điện Biên',
        level: 'Phường',
      );

      final jsonMap = province.toMap();

      expect(jsonMap['id'], '00019');
      expect(jsonMap['name'], 'Phường Điện Biên');
      expect(jsonMap['level'], 'Phường');

      final jsonString = province.toJson();
      expect(jsonString,
          '{"id":"00019","name":"Phường Điện Biên","level":"Phường"}');
    });

    test('Chuyển đổi JSON sang Province', () {
      const jsonString = '{"id":"00019","name":"Phường Điện Biên","level":"Phường"}';
      final province = Province.fromJson(jsonString);

      expect(province.id, '00019');
      expect(province.name, 'Phường Điện Biên');
      expect(province.level, 'Phường');
    });

    test('Test phuương thức copyWith', () {
      final province = Province(
        id: '00019',
        name: 'Phường Điện Biên',
        level: 'Phường',
      );

      final updatedProvince = province.copyWith(name: 'Phường Điện Biên Updated');
      expect(updatedProvince.name, 'Phường Điện Biên Updated');
      expect(updatedProvince.id, province.id);
      expect(updatedProvince.level, province.level);
    });

    test('Test equality', () {
      final province1 = Province(
        id: '00019',
        name: 'Phường Điện Biên',
        level: 'Phường',
      );
      final province2 = Province(
        id: '00019',
        name: 'Phường Điện Biên',
        level: 'Phường',
      );

      expect(province1, province2);
    });
  });
}