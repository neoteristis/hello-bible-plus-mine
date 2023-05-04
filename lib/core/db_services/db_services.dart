import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../entities/token.dart';

abstract class DbService {
  Future saveToken(Token token);
  Future<String?> getToken();
  Future deleteToken();
}

class DbServiceImp implements DbService {
  final FlutterSecureStorage secureStorage;
  DbServiceImp({
    required this.secureStorage,
  });
  @override
  Future saveToken(Token token) async {
    await secureStorage.write(key: 'jwt', value: token.token);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'jwt');
  }

  @override
  Future deleteToken() async {
    await secureStorage.delete(key: 'jwt');
  }
}
