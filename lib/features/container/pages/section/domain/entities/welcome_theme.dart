import 'package:equatable/equatable.dart';

import '../../../../../chat/domain/entities/category.dart';

class WelcomeTheme extends Equatable {
  final String? converstionId;
  final Category? category;
  final String? message;

  const WelcomeTheme({
    this.converstionId,
    this.category,
    this.message,
  });

  @override
  List<Object?> get props => [
        converstionId,
        category,
        message,
      ];

  factory WelcomeTheme.fromJson(Map<String, dynamic> map) {
    return WelcomeTheme(
      converstionId: map['conversationId'],
      category:
          map['category'] != null ? Category.fromJson(map['category']) : null,
      message: map['message'],
    );
  }
}
