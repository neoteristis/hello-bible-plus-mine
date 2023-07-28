import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/helper/log.dart';
import '../../domain/entities/notif_by_category.dart';

abstract class NotificationRemoteDatasource {
  Future<List<NotificationTime>> getValueNotifByCategory();
  Future switchNotifValue(NotificationTime notif);
  Future changeNotifTime(List<NotificationTime> notif);
}

class NotificationRemoteDatasourceImp implements NotificationRemoteDatasource {
  final BaseRepository baseRepo;
  NotificationRemoteDatasourceImp(
    this.baseRepo,
  );
  @override
  Future<List<NotificationTime>> getValueNotifByCategory() async {
    try {
      final res = await baseRepo.get(ApiConstants.categoryNotif);
      return (res.data as List)
          .map((m) => NotificationTime.fromJson(m))
          .toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future switchNotifValue(NotificationTime notif) async {
    try {
      final res = await baseRepo.post(ApiConstants.categoryNotif,
          body: notif.toJsonTime());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future changeNotifTime(List<NotificationTime> notif) async {
    try {
      final objects = {};
      for (final no in notif) {
        final notif = no.toJsonTime();
        if (notif != null) {
          objects.addAll(notif);
        }
      }

      Log.info(objects);
      final res = await baseRepo.patch(
        ApiConstants.registration(),
        body: {'notificationTimes': objects},
      );
      return res.data;
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
