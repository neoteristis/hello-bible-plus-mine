import 'package:equatable/equatable.dart';
import 'package:intl/intl.dart';

class NotificationTime extends Equatable {
  final String? id;
  final String? title;
  final DateTime? time;
  const NotificationTime({
    this.id,
    this.title,
    this.time,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        time,
      ];

  NotificationTime copyWith({
    String? id,
    String? title,
    DateTime? time,
  }) {
    return NotificationTime(
      id: id ?? this.id,
      title: title ?? this.title,
      time: time ?? this.time,
    );
  }

  Map<String, dynamic>? toJsonTime() {
    if (id != null && time != null) {
      return {
        id!: DateFormat('y-d-M HH:mm').format(time!),
      };
    }
    return null;
  }

  factory NotificationTime.fromJson(Map<String, dynamic> map) {
    return NotificationTime(
      id: map['_id'],
      title: map['title'],
      time: map['time'] != null ? DateTime.tryParse(map['time']) : null,
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
