import 'package:dartz/dartz.dart';

import 'package:gpt/core/error/failure.dart';

import '../../../../core/usecase/usecase.dart';
import '../entities/notif_by_category.dart';
import '../repositories/notification_repository.dart';

class ChangeNotifTimeUsecase implements Usecase<dynamic, NotificationTime> {
  final NotificationRepository repo;

  ChangeNotifTimeUsecase(this.repo);
  @override
  Future<Either<Failure, dynamic>> call(params) async {
    return await repo.changeNotifTime(params);
  }
}
