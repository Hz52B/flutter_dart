import 'package:flutter_test/flutter_test.dart';
import 'package:dangky/district.dart';

void main() {
  group('District', () {
    test('Taọ đối tượng District', () {
      final district = District(
        id: '00013',
        name: 'Phường Quán Thánh',
        level: 'Phường',
        provinceId: '01',
      );
      expect(district, isNotNull);
    });

    test('Tất cả các trường thông tin là NULL', () {
      final district = District(
        id: null,
        name: null,
        level: null,
        provinceId: null,
      );
      expect(district, isNotNull);
    });

    test('Trường hợp trường id có giá trị NULL', () {
      final district = District(
        id: null,
        name: 'Phường Quán Thánh',
        level: 'Phường',
        provinceId: '01',
      );
      expect(district, isNotNull);
    });

    test('Trường hợp trường name có giá trị NULL', () {
      final district = District(
        id: '00013',
        name: null,
        level: 'Phường',
        provinceId: '01',
      );
      expect(district, isNotNull);
    });

    test('Trường hợp trường level có giá trị NULL', () {
      final district = District(
        id: '00013',
        name: 'Phường Quán Thánh',
        level: null,
        provinceId: '01',
      );
      expect(district, isNotNull);
    });

    test('Trường hợp trường provinceId có giá trị NULL', () {
      final district = District(
        id: '00013',
        name: 'Phường Quán Thánh',
        level: 'Phường',
        provinceId: null,
      );
      expect(district, isNotNull);
    });

  test('o sánh bằng 2 trường dữ liệu giống nhau', () {
      final district1 = District(
        id: '00013',
        name: 'Phường Quán Thánh',
        level: 'Phường',
        provinceId: '01',
      );
      final district2 = District(
        id: '00013',
        name: 'Phường Quán Thánh',
        level: 'Phường',
        provinceId: '01',
      );
      expect(district1, equals(district2));
    });

    test('So sánh bằng 2 trường dữ liệu khác nhau', () {
      final district1 = District(
        id: '00013',
        name: 'Phường Quán Thánh',
        level: 'Phường',
        provinceId: '01',
      );
      final district2 = District(
        id: '00016',
        name: 'Phường Ngọc Hà',
        level: 'Phường',
        provinceId: '01',
      );
      expect(district1, isNot(equals(district2)));
    });
  });
}
