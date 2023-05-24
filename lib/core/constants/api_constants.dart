// api_constants.dart
import '../../features/chat/domain/usecases/fetch_historical_usecase.dart';

class ApiConstants {
  static const String categories = '/categories';
  static String conversation({String? conversationId}) {
    if (conversationId != null) {
      return '/conversations/$conversationId';
    }
    return '/conversations';
  }

  static String messages(String conversationId) => '/messages/$conversationId';
  static String answer(String conversationId) => '/messages/$conversationId';
  static String messages2(int? id) => '/chat/$id';
  // Add more API strings here

  // new api
  static const String registration = '/users';
  static const String categoriesBySection = '/categories_by_section';
  static String historical(PHistorical params) {
    String api = ApiConstants.conversation();
    String parameters =
        '?page=${params.pagination?.page ?? 1}&itemsPerPage=${params.pagination?.itemsPerPage ?? 10}&user=${params.uid}';
    return '$api$parameters';
  }
}
