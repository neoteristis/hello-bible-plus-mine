import '../../../../core/base_repository/base_repository.dart';
import '../../domain/entities/entities.dart';

abstract class RegistrationRemoteDatasources {
  Future registration(User user);
}

class RegistrationRemoteDatasourcesImp
    implements RegistrationRemoteDatasources {
  final BaseRepository base;

  const RegistrationRemoteDatasourcesImp(this.base);
  @override
  Future registration(User user) async {
    // TODO: implement registration
    throw UnimplementedError();
  }
}
