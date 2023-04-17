import 'package:equatable/equatable.dart';

class Category extends Equatable {
  const Category({
    this.id,
    this.name,
    this.prompt,
    this.model,
  });

  final int? id;
  final String? name;
  final String? prompt;
  final String? model;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        prompt: json["prompt"],
        model: json["model"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "prompt": prompt,
        "model": model,
      };

  @override
  List<Object?> get props => [id, name, prompt, model];
}
