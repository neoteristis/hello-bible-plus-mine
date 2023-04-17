import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/category.dart';
import '../repositories/chat_repository.dart';

class FetchCategoriesUsecase implements Usecase<List<Category>, NoParams> {
  final ChatRepository chatRepository;
  FetchCategoriesUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, List<Category>>> call(NoParams _) async {
    return await chatRepository.fetchCategories();
  }
}
