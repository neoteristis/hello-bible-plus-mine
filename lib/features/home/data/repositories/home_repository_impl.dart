import 'package:dartz/dartz.dart';
import 'package:gpt/core/error/exception.dart';
import 'package:gpt/core/error/failure.dart';
import 'package:gpt/core/network/network_info.dart';
import 'package:gpt/features/chat/domain/entities/category.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';
import 'package:gpt/features/home/data/datasources/home_remote_data_source.dart';
import 'package:gpt/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {

  final HomeRemoteDataSource remote;
  final NetworkInfo networkInfo;

	HomeRepositoryImpl({
    required this.remote,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<Category>>> fetchCategories() async {
    if (await networkInfo.isConnected) {
      try {
        final res = await remote.fetchCategories();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }
  }

  @override
  Future<Either<Failure, List<CategoriesBySection>>> fetchCategoriesBySection() async {

    if (await networkInfo.isConnected) {
      try {
        final res = await remote.fetchCategoriesBySection();
        return Right(res);
      } on ServerException catch (e) {
        return Left(ServerFailure(info: e.message));
      }
    } else {
      return const Left(NoConnexionFailure());
    }

  }

}
