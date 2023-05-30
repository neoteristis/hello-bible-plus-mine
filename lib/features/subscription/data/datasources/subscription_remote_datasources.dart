import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/entities.dart';
import '../../domain/usecases/payment_intent_usecase.dart';

abstract class SubscriptionRemoteDatasources {
  Future<PaymentData> sendPayment(PPayment param);
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
      final res =
          await baseRepo.post(ApiConstants.payment, body: param.toJson());

      return PaymentData.fromJson(res.data);
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
