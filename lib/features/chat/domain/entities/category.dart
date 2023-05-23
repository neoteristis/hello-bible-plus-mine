import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gpt/core/extension/string_extension.dart';

import 'entities.dart';

class Category extends Equatable {
  const Category({
    this.id,
    this.name,
    this.prompt,
    this.model,
    this.welcomePhrase,
    this.colorTheme,
    this.section,
  });

  final String? id;
  final String? name;
  final String? prompt;
  final String? model;
  final String? welcomePhrase;
  final Color? colorTheme;
  final Section? section;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['_id'],
        name: json['name'],
        prompt: json['prompt'],
        model: json['model'],
        welcomePhrase: json['welcomePhrase'],
        // section:
        //     json['section'] != null ? Section.fromJson(json['section']) : null,
        colorTheme: json['colorCode'] == null || json['colorCode'] == ''
            ? null
            : (json['colorCode'] as String).hexToColor,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'prompt': prompt,
        'model': model,
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
