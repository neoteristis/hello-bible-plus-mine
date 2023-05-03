import '../../../../core/entities/token.dart';
import '../../domain/entities/user.dart';

abstract class RegistrationLocalDatasources {
  Future saveUser(User user);
  Future saveToken(Token token);
}

class RegistrationLocalDatasourcesImp implements RegistrationLocalDatasources {
  @override
  Future saveToken(Token token) async {
    throw UnimplementedError();
  }

  @override
  Future saveUser(User user) async {
    throw UnimplementedError();
  }
}
