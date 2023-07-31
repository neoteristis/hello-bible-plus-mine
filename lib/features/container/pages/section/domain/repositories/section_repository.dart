import 'package:dartz/dartz.dart';

import '../../../../../../core/error/failure.dart';
import '../entities/welcome_theme.dart';

abstract class SectionRepository {
  Future<Either<Failure, List<WelcomeTheme>>> fetchWelcomeThemes();
}
