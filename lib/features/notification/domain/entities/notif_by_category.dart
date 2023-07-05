import 'package:equatable/equatable.dart';

class NotifByCategory extends Equatable {
  final String? id;
  final bool? value;
  final String? iconPath;
  final String? title;
  final String? time;
  const NotifByCategory({
    this.id,
    this.value,
    this.iconPath,
    this.title,
    this.time,
  });
  @override
  List<Object?> get props => [
        id,
        value,
        iconPath,
        title,
        time,
      ];

  NotifByCategory copyWith({
    String? id,
    bool? value,
    String? iconPath,
    String? title,
    String? time,
  }) {
    return NotifByCategory(
      id: id ?? this.id,
      value: value ?? this.value,
      iconPath: iconPath ?? this.iconPath,
      title: title ?? this.title,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic> toJsonTime() {
    return {
      'type': title == 'Verset du jour' ? 'dailyVerse' : 'encouraging',
      'time': time,
    };
  }

  factory NotifByCategory.fromJson(Map<String, dynamic> map) {
    return NotifByCategory(
      value: map['value'],
      iconPath: map['iconPath'],
      title: map['title'],
      time: map['time'],
    );
  }
}



// class NotifByCategory extends Equatable {
//   final bool? value;
//   final Category category;

//   const NotifByCategory({
//     this.value,
//     required this.category,
//   });

//   @override
//   List<Object?> get props => [
//         value,
//         category,
//       ];

//   Map<String, dynamic> toJson() {
//     return {
//       'value': value,
//       'category': category.id,
//     };
//   }

//   factory NotifByCategory.fromJson(Map<String, dynamic> json) {
//     return NotifByCategory(
//       value: json['value'],
//       category: Category.fromJson(json['category']),
//     );
//   }

//   NotifByCategory copyWith({
//     bool? value,
//     Category? category,
//   }) {
//     return NotifByCategory(
//       value: value ?? this.value,
//       category: category ?? this.category,
//     );
//   }
// }
