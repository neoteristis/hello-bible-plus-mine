import '../../domain/entities/welcome_theme.dart';

abstract class SectionRemoteDataSource {
  Future<List<WelcomeTheme>> fetchWelcomeThemes();
}
