import 'package:equatable/equatable.dart';

class SubscriptionType extends Equatable {
  final String? id;
  final double? unitAmount;
  final String? currency;
  final String? interval;
  final int? intervalCount;
  final Product? product;

  const SubscriptionType({
    this.id,
    this.unitAmount,
    this.currency,
    this.interval,
    this.intervalCount,
    this.product,
  });

  @override
  List<Object?> get props => [
        id,
        unitAmount,
        currency,
        interval,
        intervalCount,
        product,
      ];

  factory SubscriptionType.fromJson(Map<String, dynamic> json) {
    return SubscriptionType(
      id: json['_id'],
      unitAmount: (json['unitAmount'])?.toDouble(),
      currency: json['currency'],
      interval: json['interval'],
      intervalCount: json['intervalCount'],
      product:
          json['product'] != null ? Product.fromJson(json['product']) : null,
    );
  }
}

class Product extends Equatable {
  final String? id;
  final String? name;
  const Product({
    this.id,
    this.name,
  });

  @override
  List<Object?> get props => [id, name];

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'],
      name: json['name'],
    );
  }
}
