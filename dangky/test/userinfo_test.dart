import 'package:flutter_test/flutter_test.dart';
import 'package:dangky/userinfo.dart';

//import 'package:dangky/userinfo.dart';
import 'package:dangky/addressinfo.dart';
import 'package:dangky/province.dart';
import 'package:dangky/district.dart';
import 'package:dangky/ward.dart';

void main() {
  UserInfo? userInfo;
  Province province1 = Province(
    id: "01",
    name: "Hà Nội",
    level: "Thành phố",
  );
  District district1 = District(
    id: "002",
    name: "Hoàn Kiếm",
    level: "Quận",
    provinceId: "01",
  );
  Ward ward1 = Ward(
    id: "00079",
    name: "Phường Tràng Tiền",
    level: "Phường",
    districtId: "002",
    provinceId: "01",
  );
  AddressInfo? addressInfo = AddressInfo(
    province: province1,
    district: district1,
    ward: ward1,
    street: "Trần Quang Khải",
  );
  group('UserInfo', () {
    test('Tạo đối tượng UserInfo', () {
        userInfo = UserInfo(
        name: "TAD",
        email: "tanre43@gmail.com",
        phoneNumber: "0358447169",
        birthDate: DateTime.utc(2003, 10, 28),
        address: addressInfo,
      );
      expect(userInfo?.name, equals("TAD"));
      expect(userInfo?.email, equals("tanre43@gmail.com"));
      expect(userInfo?.phoneNumber, equals("0358447169"));
      expect(userInfo?.birthDate, equals(DateTime.utc(2003, 10, 28)));
      expect(userInfo?.address, equals(addressInfo));
    });

    test('Kiểm tra phương thức toMap', () {
      final addressInfo = AddressInfo(
        province: Province(id: '01', name: 'Hà Nội', level: 'Thành phố'),
        district: District(id: '002', name: 'Hoàn Kiếm', level: 'Quận', provinceId: '01'),
        ward: Ward(id: '00079', name: 'Phường Tràng Tiền', level: 'Phường', districtId: '002', provinceId: '01'),
        street: 'Trần Quang Khải',
      );
      final userInfo = UserInfo(
        name: 'TAD',
        email: 'tanre43@gmail.com',
        phoneNumber: '0358447169',
        birthDate: DateTime.utc(2003, 10, 28),
        address: addressInfo,
      );
      final data = userInfo.toMap();
      expect(data['name'], equals('TAD'));
      expect(data['email'], equals('tanre43@gmail.com'));
      expect(data['phoneNumber'], equals('0358447169'));
      expect(data['birthDate'], equals(DateTime.utc(2003, 10, 28))); 
      expect(data['address'], isNotNull);
      expect(data['address']['province']?['id'], equals('01'));
      expect(data['address']['district']?['id'], equals('002'));
      expect(data['address']['ward']?['id'], equals('00079'));
      expect(data['address']['street'], equals('Trần Quang Khải'));
    });

    test('Kiểm tra tính đồng bộ của hàm hashCode', () {
      final addressInfo = AddressInfo(
        province: Province(id: '01', name: 'Hà Nội', level: 'Thành phố'),
        district: District(id: '002', name: 'Hoàn Kiếm', level: 'Quận', provinceId: '01'),
        ward: Ward(id: '00079', name: 'Phường Tràng Tiền', level: 'Phường', districtId: '002', provinceId: '01'),
        street: 'Trần Quang Khải',
      );
      final userInfo1 = UserInfo(
        name: 'TAD',
        email: 'tanre43@gmail.com',
        phoneNumber: '0358447169',
        birthDate: DateTime.utc(2003, 10, 28),
        address: addressInfo,
      );
      final userInfo2 = UserInfo(
        name: 'TAD',
        email: 'tanre43@gmail.com',
        phoneNumber: '0358447169',
        birthDate: DateTime.utc(2003, 10, 28),
        address: addressInfo,
      );
      expect(userInfo1.hashCode, equals(userInfo2.hashCode));
    });
  });
}
