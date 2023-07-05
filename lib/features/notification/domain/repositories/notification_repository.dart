import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/notif_by_category.dart';

abstract class NotificationRepository {
  Future<Either<Failure, List<NotifByCategory>>> getValueNotifByCategory();
  Future<Either<Failure, dynamic>> switchNotifValue(NotifByCategory notif);
  Future<Either<Failure, dynamic>> changeNotifTime(NotifByCategory notif);
}
