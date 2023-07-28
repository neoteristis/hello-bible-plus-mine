import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/notif_by_category.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotificationTime>>> getValueNotifByCategory();
  Future<Either<Failure, dynamic>> switchNotifValue(NotificationTime notif);
  Future<Either<Failure, dynamic>> changeNotifTime(
      List<NotificationTime> notif);
}
