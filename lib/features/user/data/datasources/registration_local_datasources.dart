import '../../../../core/db_services/db_services.dart';
import '../../../../core/entities/token.dart';
import '../../domain/entities/user.dart';

abstract class RegistrationLocalDatasources {
  Future saveUser(User user);
  Future saveToken(Token token);
  Future<String?> getToken();
}

class RegistrationLocalDatasourcesImp implements RegistrationLocalDatasources {
  final DbService db;
  RegistrationLocalDatasourcesImp(
    this.db,
  );
  @override
  Future saveToken(Token token) async {
    await db.saveToken(token);
  }

  @override
  Future saveUser(User user) async {
    throw UnimplementedError();
  }

  @override
  Future<String?> getToken() async {
    return await db.getToken();
  }
}
