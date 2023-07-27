import 'package:dartz/dartz.dart';
import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/notification/domain/entities/notif_by_category.dart';

import '../../../../core/usecase/usecase.dart';
import '../repositories/notification_repository.dart';

class FetchNotificationValuesByCatecoryUsecase
    implements Usecase<List<NotificationTime>, NoParams> {
  final NotificationRepository repo;

  const FetchNotificationValuesByCatecoryUsecase(this.repo);
  @override
  Future<Either<Failure, List<NotificationTime>>> call(NoParams _) async {
    return await repo.getValueNotifByCategory();
  }
}
