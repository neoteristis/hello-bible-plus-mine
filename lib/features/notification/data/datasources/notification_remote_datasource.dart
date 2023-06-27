import '../../../../core/base_repository/base_repository.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/error/exception.dart';
import '../../domain/entities/notif_by_category.dart';

abstract class NotificationRemoteDatasource {
  Future<List<NotifByCategory>> getValueNotifByCategory();
  Future switchNotifValue(NotifByCategory notif);
}

class NotificationRemoteDatasourceImp implements NotificationRemoteDatasource {
  final BaseRepository baseRepo;
  NotificationRemoteDatasourceImp(
    this.baseRepo,
  );
  @override
  Future<List<NotifByCategory>> getValueNotifByCategory() async {
    try {
      final res = await baseRepo.get(ApiConstants.categoryNotif);
      return (res.data as List)
          .map((m) => NotifByCategory.fromJson(m))
          .toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future switchNotifValue(NotifByCategory notif) async {
    try {
      final res =
          await baseRepo.post(ApiConstants.categoryNotif, body: notif.toJson());
      return res.data;
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
