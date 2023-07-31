import 'package:dartz/dartz.dart';
import 'package:gpt/core/error/failure.dart';
import 'package:gpt/features/container/pages/section/domain/entities/welcome_theme.dart';
import 'package:gpt/features/container/pages/section/domain/repositories/section_repository.dart';

import '../../../../../../core/error/exception.dart';
import '../../../../../../core/network/network_info.dart';
import '../datasources/section_remote_data_source.dart';

class SectionRepositoryImpl extends SectionRepository {
  final SectionRemoteDataSource remote;
  final NetworkInfo networkInfo;

  SectionRepositoryImpl({
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<WelcomeTheme>>> fetchWelcomeThemes() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.fetchWelcomeThemes();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }
}
