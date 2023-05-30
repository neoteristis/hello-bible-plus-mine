import 'package:equatable/equatable.dart';

class PaymentData extends Equatable {
  final String? paymentIntent;
  final String? ephemeralKey;
  final String? customerId;
  const PaymentData({
    this.paymentIntent,
    this.ephemeralKey,
    this.customerId,
  });
  @override
  List<Object?> get props => [
        paymentIntent,
        ephemeralKey,
        customerId,
      ];

  factory PaymentData.fromJson(Map<String, dynamic> json) {
    return PaymentData(
      paymentIntent: json['paymentIntent'],
      ephemeralKey: json['ephemeralKey'],
      customerId: json['customer'],
    );
  }
}
