import 'package:equatable/equatable.dart';

import '../../../../core/entities/token.dart';
import 'user.dart';

class UserResponse extends Equatable {
  final User? user;
  final Token? token;
  const UserResponse({
    this.user,
    this.token,
  });
  @override
  List<Object?> get props => [
        user,
        token,
      ];

  factory UserResponse.fromMap(Map<String, dynamic> map) {
    return UserResponse(
      user: map['user'] != null ? User.fromJson(map['user']) : null,
      token: map['token'] != null ? Token.fromJson(map['token']) : null,
    );
  }
}
