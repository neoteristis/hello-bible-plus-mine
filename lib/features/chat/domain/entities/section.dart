import 'package:equatable/equatable.dart';

class Section extends Equatable {
  final String? id;
  final String? name;

  const Section({
    this.id,
    this.name,
  });
  @override
  List<Object?> get props => [
        id,
        name,
      ];

  factory Section.fromJson(Map<String, dynamic> map) {
    return Section(
      id: map['_id'],
      name: map['name'],
    );
  }
}
