import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int? id;
  final String? lastName;
  final String? firstName;
  final String? email;
  final String? validationCode;
  final String? country;

  const User({
    this.id,
    this.lastName,
    this.firstName,
    this.email,
    this.validationCode,
    this.country,
  });
  @override
  List<Object?> get props => [
        id,
        lastName,
        firstName,
        email,
        validationCode,
        country,
      ];

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id']?.toInt(),
      lastName: json['lastName'],
      firstName: json['firstName'],
      email: json['email'],
      validationCode: json['validationCode'],
      country: json['country'],
    );
  }
}
