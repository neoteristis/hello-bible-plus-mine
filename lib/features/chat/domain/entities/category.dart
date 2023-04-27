import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/core/extension/string_extension.dart';

class Category extends Equatable {
  const Category({
    this.id,
    this.name,
    this.prompt,
    this.model,
    this.welcomePhrase,
    this.colorTheme,
  });

  final int? id;
  final String? name;
  final String? prompt;
  final String? model;
  final String? welcomePhrase;
  final Color? colorTheme;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        prompt: json["prompt"],
        model: json["model"],
        welcomePhrase: json['welcomePhrase'],
        colorTheme: json['colorCode'] != null
            ? (json['colorCode'] as String).hexToColor
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "prompt": prompt,
        "model": model,
      };

  @override
  List<Object?> get props => [
        id,
        name,
        prompt,
        model,
        welcomePhrase,
        colorTheme,
      ];
}
