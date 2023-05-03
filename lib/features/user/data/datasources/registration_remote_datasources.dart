import '../../domain/entities/entities.dart';

abstract class RegistrationRemoteDatasources {
  Future registration(User user);
}

class RegistrationRemoteDatasourcesImp
    implements RegistrationRemoteDatasources {
  @override
  Future registration(User user) async {
    // TODO: implement registration
    throw UnimplementedError();
  }
}
