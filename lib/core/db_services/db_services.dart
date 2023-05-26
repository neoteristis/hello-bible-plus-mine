import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';

import '../../features/user/data/models/box/user_box.dart';
import '../../features/user/domain/entities/user.dart';
import '../../objectbox.g.dart';
import '../entities/token.dart';

abstract class DbService {
  Future saveToken(Token token);
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future deleteToken();
  Future saveUser(User user);
  Future<User?> getUser();
  Future deleteUser();
}

class DbServiceImp implements DbService {
  final FlutterSecureStorage secureStorage;
  final Store store;
  final Box<UserBox> userBox;
  DbServiceImp({
    required this.secureStorage,
    required this.store,
    required this.userBox,
  });
  @override
  Future saveToken(Token token) async {
    await secureStorage.write(key: 'jwt', value: token.token);
    await secureStorage.write(key: 'jwt_refresh', value: token.refresh);
  }

  @override
  Future<String?> getToken() async {
    return await secureStorage.read(key: 'jwt');
  }

  @override
  Future deleteToken() async {
    await secureStorage.delete(key: 'jwt');
  }

  @override
  Future<User?> getUser() async {
    final users = userBox.getAll();
    Logger().w(users.length);
    if (users.isNotEmpty) {
      final user = users.first.toEntity();
      return user;
    }
    return null;
  }

  @override
  Future saveUser(User user) async {
    Logger().d('saving this user : $user');
    final userModel = UserBox.fromEntity(user);

    final findUserQuery =
        userBox.query(UserBox_.idString.equals(user.idString ?? '')).build();

    final existingUser = findUserQuery.find();

    if (existingUser.isEmpty) {
      userBox.put(userModel);
    }
  }

  @override
  Future deleteUser() async {
    userBox.removeAll();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await secureStorage.read(key: 'jwt_refresh');
  }
}
