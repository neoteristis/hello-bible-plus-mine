import '../../../../core/db_services/db_services.dart';
import '../../../../core/entities/token.dart';
import '../../../user/domain/entities/entities.dart';

abstract class ChatLocalDatasources {
  Future<User?> getUser();
  Future<Token> getToken();
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

  @override
  Future<Token> getToken() async {
    final String? token = await db.getToken();
    final String? refresh = await db.getRefreshToken();
    return Token(token: token, refresh: refresh);
  }
}
