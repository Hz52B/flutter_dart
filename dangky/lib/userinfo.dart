import 'dart:convert';
import 'package:dangky/addressinfo.dart';

class UserInfo {
  String? name;
  String? email;
  String? phoneNumber;
  DateTime? birthDate;
  AddressInfo? address;
  
  UserInfo({
    this.name,
    this.email,
    this.phoneNumber,
    this.birthDate,
    this.address,
  });

  UserInfo copyWith({
    String? name,
    String? email,
    String? phoneNumber,
    DateTime? birthDate,
    AddressInfo? address,
  }) {
    return UserInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      birthDate: birthDate ?? this.birthDate,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'birthDate': birthDate != null ? birthDate!.toUtc().toIso8601String() : null, // Convert DateTime to ISO 8601 string
      'address': address?.toMap(),
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      name: map['name'] != null ? map['name'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      phoneNumber: map['phoneNumber'] != null ? map['phoneNumber'] as String : null,
      birthDate: map['birthDate'] != null ? DateTime.parse(map['birthDate'] as String) : null, // Parse ISO 8601 string to DateTime
      address: map['address'] != null ? AddressInfo.fromMap(map['address'] as Map<String,dynamic>) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserInfo.fromJson(String source) => UserInfo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserInfo(name: $name, email: $email, phoneNumber: $phoneNumber, birthDate: $birthDate, address: $address)';
  }

  @override
  bool operator ==(covariant UserInfo other) {
    if (identical(this, other)) return true;
  
    return 
      other.name == name &&
      other.email == email &&
      other.phoneNumber == phoneNumber &&
      other.birthDate == birthDate &&
      other.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      email.hashCode ^
      phoneNumber.hashCode ^
      birthDate.hashCode ^
      address.hashCode;
  }
}
