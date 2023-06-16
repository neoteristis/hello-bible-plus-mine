import 'package:image_picker/image_picker.dart';

import '../../../../core/db_services/db_services.dart';
import '../../../../core/entities/token.dart';
import '../../domain/entities/user.dart';

abstract class RegistrationLocalDatasources {
  Future<XFile?> getPicture(ImageSource source);
  Future saveUser(User user);
  Future saveToken(Token token);
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<User?> getUser();
  Future deleteAuth();
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
    await db.saveUser(user);
  }

  @override
  Future<String?> getToken() async {
    return await db.getToken();
  }

  @override
  Future<String?> getRefreshToken() async {
    return await db.getRefreshToken();
  }

  @override
  Future<User?> getUser() async {
    return await db.getUser();
  }

  @override
  Future deleteAuth() async {
    await db.deleteToken();
    await db.deleteUser();
  }

  @override
  Future<XFile?> getPicture(ImageSource source) async {
    try {
      final XFile? image = await ImagePicker().pickImage(source: source);
      return image;
    } catch (e) {
      return null;
    }
  }
}
