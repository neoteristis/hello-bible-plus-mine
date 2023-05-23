import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/category_by_section.dart';
import '../repositories/chat_repository.dart';

class FetchCategoriesBySectionUsecase
    implements Usecase<List<CategoriesBySection>, NoParams> {
  final ChatRepository chatRepository;
  FetchCategoriesBySectionUsecase(
    this.chatRepository,
  );
  @override
  Future<Either<Failure, List<CategoriesBySection>>> call(NoParams _) async {
    return await chatRepository.fetchCategoriesBySection();
  }
}
