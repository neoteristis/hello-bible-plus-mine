import 'package:gpt/features/container/pages/section/data/datasources/section_remote_data_source.dart';
import 'package:gpt/features/container/pages/section/domain/entities/welcome_theme.dart';

import '../../../../../../core/base_repository/base_repository.dart';
import '../../../../../../core/constants/api_constants.dart';
import '../../../../../../core/error/exception.dart';
import '../../../../../../core/helper/log.dart';

class SectionRemoteDataSourceImpl extends SectionRemoteDataSource {
  final BaseRepository baseRepo;
  SectionRemoteDataSourceImpl(
    this.baseRepo,
  );

  @override
  Future<List<WelcomeTheme>> fetchWelcomeThemes() async {
    try {
      final res = await baseRepo.get(ApiConstants.welcomeTheme, addToken: true);
      Log.info(res.data);

      return (res.data as List).map((m) => WelcomeTheme.fromJson(m)).toList();
    } catch (e) {
      print(e.toString());
      throw ServerException(message: e.toString());
    }
  }
}
