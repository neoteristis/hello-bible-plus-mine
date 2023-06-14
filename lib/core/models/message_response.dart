import 'package:equatable/equatable.dart';

class MessageResponse extends Equatable {
  final int statusCode;
  final String message;
  final String error;
  const MessageResponse({
    required this.statusCode,
    required this.message,
    required this.error,
  });

  @override
  List<Object?> get props => [
        statusCode,
        message,
        error,
      ];

  factory MessageResponse.fromJson(Map<String, dynamic> map) {
    return MessageResponse(
      statusCode: map['statusCode']?.toInt() ?? 0,
      message: map['message'] == null
          ? ''
          : (map['message'] is List && (map['message'] as List).isNotEmpty)
              ? (map['message'] as List).first
              : map['message'],
      error: map['error'] ?? '',
    );
  }
}
