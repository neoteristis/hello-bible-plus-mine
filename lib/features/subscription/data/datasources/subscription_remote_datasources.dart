import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/payment_intent_usecase.dart';

abstract class SubscriptionRemoteDatasources {
  Future<PaymentData> sendPayment(PPayment param);
  Future<bool> initPaymentSheet(PaymentData parm);
  Future<bool> presentPaymentSheet();
  Future<bool> confirmPaymentSheet();
}

class SubscriptionRemoteDatasourcesImp
    implements SubscriptionRemoteDatasources {
  final BaseRepository baseRepo;
  const SubscriptionRemoteDatasourcesImp(
    this.baseRepo,
  );
  @override
  Future<PaymentData> sendPayment(PPayment param) async {
    try {
      final res = await baseRepo.post(ApiConstants.payment,
          body: {'amount': 1000}, addToken: true);

      return PaymentData.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> initPaymentSheet(PaymentData parm) async {
    try {
      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          merchantDisplayName: 'Hello bible plus',
          customerId: parm.customerId,
          paymentIntentClientSecret: parm.paymentIntent,
          customerEphemeralKeySecret: parm.ephemeralKey,
        ),
      );
      return true;
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<bool> presentPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();
      return true;
    } on Exception catch (e) {
      if (e is StripeException) {
        throw ServerException(message: 'Error from Stripe : ${e.toString()}');
      } else {
        throw ServerException(message: e.toString());
      }
    }
  }

  @override
  Future<bool> confirmPaymentSheet() async {
    try {
      await Stripe.instance.confirmPaymentSheetPayment();
      return true;
    } on Exception catch (e) {
      if (e is StripeException) {
        throw ServerException(message: 'Error from Stripe : ${e.toString()}');
      } else {
        throw ServerException(message: e.toString());
      }
    }
  }
}
