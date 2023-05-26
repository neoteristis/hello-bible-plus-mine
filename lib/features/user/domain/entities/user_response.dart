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

  factory UserResponse.fromJson(Map<String, dynamic> map) {
    return UserResponse(
      user: User.fromJson(map),
      token: map['token'] != null
          ? Token(token: map['token'], refresh: map['refresh_token'])
          : null,
    );
  }
}
