import 'package:equatable/equatable.dart';

import '../../../chat/domain/entities/category.dart';

class NotifByCategory extends Equatable {
  final bool? value;
  final Category category;

  const NotifByCategory({
    this.value,
    required this.category,
  });

  @override
  List<Object?> get props => [
        value,
        category,
      ];

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'category': category.id,
    };
  }

  factory NotifByCategory.fromJson(Map<String, dynamic> json) {
    print(json['value']);
    return NotifByCategory(
      value: json['value'],
      category: Category.fromJson(json['category']),
    );
  }

  NotifByCategory copyWith({
    bool? value,
    Category? category,
  }) {
    return NotifByCategory(
      value: value ?? this.value,
      category: category ?? this.category,
    );
  }
}
