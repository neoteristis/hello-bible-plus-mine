import 'package:gpt/core/base_repository/base_repository.dart';
import 'package:gpt/core/constants/api_constants.dart';
import 'package:gpt/core/db_services/db_services.dart';
import 'package:gpt/injections.dart';

Future setToken(String? token) async {
  final user = await getIt<DbService>().getUser();
  final id = user?.idString;
  if (id != null) {
    await getIt<BaseRepository>().patch(
      ApiConstants.registration(),
      body: {
        'deviceToken': token,
      },
    );
  }
}