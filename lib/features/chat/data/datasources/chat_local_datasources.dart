import '../../../../core/db_services/db_services.dart';
import '../../../user/domain/entities/entities.dart';

abstract class ChatLocalDatasources {
  Future<User?> getUser();
}

class ChatLocalDatasourcesImp implements ChatLocalDatasources {
  final DbService db;
  ChatLocalDatasourcesImp({
    required this.db,
  });
  @override
  Future<User?> getUser() async {
    return await db.getUser();
  }
}
