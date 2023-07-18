import 'dart:convert';

import 'package:equatable/equatable.dart';

class UserSubscription extends Equatable {
  final DateTime? date;
  final DateTime? expiration;
  final bool? status;
  final String? type;
  const UserSubscription({
    this.date,
    this.expiration,
    this.status,
    this.type,
  });
  @override
  List<Object?> get props => [
        date,
        expiration,
        status,
        type,
      ];

  UserSubscription copyWith({
    DateTime? date,
    DateTime? expiration,
    bool? status,
    String? type,
  }) {
    return UserSubscription(
      date: date ?? this.date,
      expiration: expiration ?? this.expiration,
      status: status ?? this.status,
      type: type ?? this.type,
    );
  }

  factory UserSubscription.fromJson(Map<String, dynamic> map) {
    return UserSubscription(
      date: map['date'] != null
          ? DateTime.tryParse(map['date'])?.toLocal()
          : null,
      expiration: map['expiration'] != null
          ? DateTime.tryParse(map['expiration'])?.toLocal()
          : null,
      status: map['status'],
      type: map['type'],
    );
  }
}
