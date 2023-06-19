import 'package:equatable/equatable.dart';

import 'entities.dart';

class CategoriesBySection extends Equatable {
  final String? id;
  final List<Category>? categories;
  final String sectionName;
  const CategoriesBySection({
    this.id,
    required this.categories,
    required this.sectionName,
  });
  @override
  List<Object?> get props => [
        id,
        categories,
        sectionName,
      ];

  factory CategoriesBySection.fromJson(Map<String, dynamic> json) {
    final categories = json['categories'];
    return CategoriesBySection(
      categories: categories != null
          ? categories.isNotEmpty
              ? List<Category>.from(
                  (categories as List).map(
                    (x) => Category.fromJson(x),
                  ),
                ).toList()
              : []
          : null,
      sectionName: json['sectionName'] ?? '',
      id: (categories as List).first['section'].first['_id'],
    );
  }
}
