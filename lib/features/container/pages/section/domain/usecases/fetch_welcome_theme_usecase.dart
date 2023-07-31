import 'package:dartz/dartz.dart';
import 'package:gpt/core/error/failure.dart';
import 'package:gpt/core/usecase/usecase.dart';
import 'package:gpt/features/chat/domain/entities/category_by_section.dart';
import 'package:gpt/features/container/pages/home/domain/repositories/home_repository.dart';

import '../entities/welcome_theme.dart';
import '../repositories/section_repository.dart';

class FetchWelcomeThemeUsecase
    implements Usecase<List<WelcomeTheme>, NoParams> {
  final SectionRepository repository;

  FetchWelcomeThemeUsecase(
    this.repository,
  );

  @override
  Future<Either<Failure, List<WelcomeTheme>>> call(NoParams _) async {
    return await repository.fetchWelcomeThemes();
  }
}
