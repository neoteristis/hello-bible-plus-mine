import 'package:equatable/equatable.dart';

class Token extends Equatable {
  final String token;
  final String refresh;

  const Token({
    required this.token,
    required this.refresh,
  });

  @override
  List<Object?> get props => [
        token,
        refresh,
      ];

  factory Token.fromJson(Map<String, dynamic> map) {
    return Token(
      token: map['token'] ?? '',
      refresh: map['refresh'] ?? '',
    );
  }
}
