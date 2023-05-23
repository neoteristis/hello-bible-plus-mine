import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String? idString;
  final int? idInt;
  final String? lastName;
  final String? firstName;
  final String? email;
  final String? validationCode;
  final String? country;

  const User({
    this.idString,
    this.idInt,
    this.lastName,
    this.firstName,
    this.email,
    this.validationCode,
    this.country,
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
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      idString: json['id'],
      lastName: json['name'],
      firstName: json['firstname'],
      email: json['email'],
      country: json['country'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': lastName,
      'firstname': firstName,
      'email': email,
      'code': validationCode,
      'country': country,
    };
  }
}
