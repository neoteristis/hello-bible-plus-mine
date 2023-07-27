import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/notif_by_category.dart';

abstract class NotificationRemoteDatasource {
  Future<List<NotificationTime>> getValueNotifByCategory();
  Future switchNotifValue(NotificationTime notif);
  Future changeNotifTime(NotificationTime notif);
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
  Future changeNotifTime(NotificationTime notif) async {
    try {
      final res = await baseRepo.patch(ApiConstants.registration(),
          body: notif.toJsonTime());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
