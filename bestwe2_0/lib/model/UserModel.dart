import 'package:bestwe2_0/functions/functions.dart';

class Usermodel {
  final String? image;
  final String full_name;
  final String email;
  final String? password;
  final String? address;
  final int? mobile;
  final int? age;
  final String status;

  Usermodel({
    this.image,
    required this.full_name,
    required this.email,
    this.password,
    this.address,
    this.mobile,
    this.age,
    required this.status,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      // image: json['image'] as String?,
      image: json['image'] != null ? fixImageUrl(json['image']) : '',
      full_name: json['full_name'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] as String?,
      address: json['address'] as String?,
      mobile: json['mobile'] != null ? int.tryParse(json['mobile'].toString()) : null,
      age: json['age'] != null ? int.tryParse(json['age'].toString()) : null,
      status: json['status'] ?? 'inactive',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'image': image,
      'full_name': full_name,
      'email': email,
      'password': password,
      'address': address,
      'mobile': mobile,
      'age': age,
      'status': status,
    };

    // Remove all entries where value is null
    data.removeWhere((key, value) => value == null);

    return data;
  }

  /// ✅ Add this method
  Usermodel copyWith({
    String? image,
    String? full_name,
    String? email,
    String? password,
    String? address,
    int? mobile,
    int? age,
    String? status,
  }) {
    return Usermodel(
      image: image ?? this.image,
      full_name: full_name ?? this.full_name,
      email: email ?? this.email,
      password: password ?? this.password,
      address: address ?? this.address,
      mobile: mobile ?? this.mobile,
      age: age ?? this.age,
      status: status ?? this.status,
    );
  }
}