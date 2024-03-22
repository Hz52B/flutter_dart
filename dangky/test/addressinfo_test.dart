import 'package:flutter_test/flutter_test.dart';
import 'package:dangky/addressinfo.dart';
import 'package:dangky/province.dart';
import 'package:dangky/district.dart';
import 'package:dangky/ward.dart';

void main() {
  group('AddressInfo', () {
    test('Kiểm tra phương thức fromMap', () {
      final data = {
        "province": {"id": "01", "name": "Hà Nội", "level": "Thành phố"},
        "district": {"id": "002", "name": "Hoàn Kiếm", "level": "Quận", "provinceId": "01"},
        "ward": {"id": "00079", "name": "Phường Tràng Tiền", "level": "Phường", "districtId": "002", "provinceId": "01"},
        "street": "Trần Quang Khải"
      };

      final addressInfo = AddressInfo.fromMap(data);
      expect(addressInfo.province?.id, equals('01'));
      expect(addressInfo.district?.id, equals('002'));
      expect(addressInfo.ward?.id, equals('00079'));
      expect(addressInfo.street, equals('Trần Quang Khải'));
    });

    test('Kiểm tra phương thức toMap', () {
      final province = Province(id: '01', name: 'Hà Nội', level: 'Thành phố');
      final district = District(id: '002', name: 'Hoàn Kiếm', level: 'Quận', provinceId: '01');
      final ward = Ward(id: '00079', name: 'Phường Tràng Tiền', level: 'Phường', districtId: '002', provinceId: '01');
      final addressInfo = AddressInfo(province: province, district: district, ward: ward, street: 'Trần Quang Khải');
      final data = addressInfo.toMap();
      expect(data['province']?['id'], equals('01'));
      expect(data['district']?['id'], equals('002'));
      expect(data['ward']?['id'], equals('00079'));
      expect(data['street'], equals('Trần Quang Khải'));
    });

    test('Kiểm tra phương thức toJson', () {
      final province = Province(id: '01', name: 'Hà Nội', level: 'Thành phố');
      final district = District(id: '002', name: 'Hoàn Kiếm', level: 'Quận', provinceId: '01');
      final ward = Ward(id: '00079', name: 'Phường Tràng Tiền', level: 'Phường', districtId: '002', provinceId: '01');
      final addressInfo = AddressInfo(province: province, district: district, ward: ward, street: 'Trần Quang Khải');
      final jsonString = addressInfo.toJson();
      const expectedJsonString = '{"province":{"id":"01","name":"Hà Nội","level":"Thành phố"},"district":{"id":"002","name":"Hoàn Kiếm","level":"Quận","provinceId":"01"},"ward":{"id":"00079","name":"Phường Tràng Tiền","level":"Phường","districtId":"002","provinceId":"01"},"street":"Trần Quang Khải"}';
      expect(jsonString, equals(expectedJsonString));
    });

    test('Kiểm tra tính đồng bộ của toán tử so sánh ==', () {
      final province = Province(id: '01', name: 'Hà Nội', level: 'Thành phố');
      final district = District(id: '002', name: 'Hoàn Kiếm', level: 'Quận', provinceId: '01');
      final ward = Ward(id: '00079', name: 'Phường Tràng Tiền', level: 'Phường', districtId: '002', provinceId: '01');
      final addressInfo1 = AddressInfo(province: province, district: district, ward: ward, street: 'Trần Quang Khải');
      final addressInfo2 = AddressInfo(province: province, district: district, ward: ward, street: 'Trần Quang Khải');
      final addressInfo3 = AddressInfo(province: province, district: district, ward: ward, street: 'Vạn Kiếp');
      expect(addressInfo1, equals(addressInfo2));
      expect(addressInfo1, isNot(equals(addressInfo3)));
    });

    test('Kiểm tra tính đồng bộ của hàm hashCode', () {
      final province = Province(id: '01', name: 'Hà Nội', level: 'Thành phố');
      final district = District(id: '002', name: 'Hoàn Kiếm', level: 'Quận', provinceId: '01');
      final ward = Ward(id: '00079', name: 'Phường Tràng Tiền', level: 'Phường', districtId: '002', provinceId: '01');
      final addressInfo1 = AddressInfo(province: province, district: district, ward: ward, street: 'Trần Quang Khải');
      final addressInfo2 = AddressInfo(province: province, district: district, ward: ward, street: 'Trần Quang Khải');
      expect(addressInfo1.hashCode, equals(addressInfo2.hashCode));
    });
  });
}
