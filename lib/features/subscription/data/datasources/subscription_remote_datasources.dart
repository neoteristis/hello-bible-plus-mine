import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/models/message_response.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/payment_intent_usecase.dart';

abstract class SubscriptionRemoteDatasources {
  Future<PaymentData> sendPayment(SubscriptionType param);
  Future<bool> initPaymentSheet(PaymentData parm);
  Future<bool> presentPaymentSheet();
  Future<bool> confirmPaymentSheet();
  Future<List<SubscriptionType>> getSubscriptionsType();
  // Future updateSubscription(
  //     {required String subscriptionId, required String uid});
  Future<MessageResponse> checkCode(String code);
  Future cancelSubscription();
}

class SubscriptionRemoteDatasourcesImp
    implements SubscriptionRemoteDatasources {
  final BaseRepository baseRepo;
  const SubscriptionRemoteDatasourcesImp(
    this.baseRepo,
  );
  @override
  Future<PaymentData> sendPayment(SubscriptionType param) async {
    try {
      final res = await baseRepo.post(
        ApiConstants.payment,
        addToken: true,
        body: {'price': param.stripePriceId},
      );
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
          googlePay: const PaymentSheetGooglePay(
            merchantCountryCode: 'MG',
            currencyCode: 'MGA',
            testEnv: true,
          ),
          applePay: const PaymentSheetApplePay(
            merchantCountryCode: 'US',
          ),
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

  @override
  Future<List<SubscriptionType>> getSubscriptionsType() async {
    try {
      final res = await baseRepo.get(ApiConstants.subscriptions);
      return (res.data as List)
          .map((m) => SubscriptionType.fromJson(m))
          .toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  // @override
  // Future updateSubscription({
  //   required String subscriptionId,
  //   required String uid,
  // }) async {
  //   try {
  //     await baseRepo.patch(
  //       ApiConstants.registration(uid: uid),
  //       body: {'subscriptionType': subscriptionId},
  //       addToken: true,
  //     );
  //     return true;
  //   } catch (e) {
  //     print(e.toString());
  //     throw ServerException(message: e.toString());
  //   }
  // }

  @override
  Future<MessageResponse> checkCode(String code) async {
    try {
      final res = await baseRepo.get(
        ApiConstants.code(code),
      );
      return MessageResponse.fromJson(res.data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      final res = e.response;
      final message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();
      if (e.response?.statusCode == 404) {
        throw NotFoundException();
      } else {
        throw ServerException(message: message);
      }
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future cancelSubscription() async {
    try {
      final res = await baseRepo.post(
        ApiConstants.cancelSubscription,
      );
      return MessageResponse.fromJson(res.data);
    } on DioError catch (e) {
      if (kDebugMode) {
        print(e);
      }
      final res = e.response;
      final message = res?.data != null
          ? MessageResponse.fromJson(res?.data).message
          : e.toString();
      throw ServerException(message: message);
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
