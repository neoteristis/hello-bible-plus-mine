import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? idString;
  final int? idInt;
  final String? lastName;
  final String? firstName;
  final String? username;
  final String? email;
  final String? validationCode;
  final String? country;
  final String? deviceToken;
  final String? password;
  final String? photo;

  const User({
    this.idString,
    this.idInt,
    this.lastName,
    this.firstName,
    this.email,
    this.validationCode,
    this.country,
    this.deviceToken,
    this.password,
    this.username,
    this.photo,
  });
  @override
  List<Object?> get props => [
        idInt,
        idString,
        lastName,
        firstName,
        email,
        validationCode,
        country,
        deviceToken,
        password,
        photo,
        username,
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idString: json['_id'],
      lastName: json['name'],
      firstName: json['firstname'],
      email: json['email'],
      country: json['country'],
      photo: json['photo'],
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': lastName,
      'firstname': firstName,
      'email': email,
      'username': username,
      // 'code': validationCode,
      'country': 'Madagascar',
      // 'deviceToken': deviceToken,
    };
  }

  Map<String, dynamic> toJson_1() {
    return {
      // 'name': lastName,
      // 'firstname': firstName,
      'email': email,
      // 'code': validationCode,
      'country': 'Madagascar',
      // 'deviceToken': deviceToken,
      'password': password,
    };
  }

  Map<String, dynamic> toJsonLogin() {
    return {
      // 'name': lastName,
      // 'firstname': firstName,
      'username': email,
      // 'code': validationCode,
      // 'deviceToken': deviceToken,
      'password': password,
    };
  }

  Map<String, dynamic> toJson_2() {
    return {
      'name': lastName,
      // 'photo': photo,
      // 'firstname': firstName,
      // 'email': email,
      // 'code': validationCode,
      // 'country': country,
      // 'deviceToken': deviceToken,
      // 'password': password,
    };
  }
}
