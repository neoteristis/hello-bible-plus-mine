// api_constants.dart
import '../../features/chat/domain/usecases/fetch_historical_usecase.dart';

class ApiConstants {
  static const String login = '/auth/login';
  static const String categories = '/categories';
  static String conversation({String? conversationId}) {
    if (conversationId != null) {
      return '/conversations/$conversationId';
    }
    return '/conversations';
  }

  static String checkEmail(String email) => '/user_email?email=$email';

  static String messages(String conversationId) => '/messages/$conversationId';
  static String answer(String conversationId) => '/messages/$conversationId';
  // Add more API strings here

  // new api
  static String registration({String? uid}) {
    if (uid == null) {
      return '/users';
    }
    return '/users/$uid';
  }

  static const String categoriesBySection = '/categories_by_section';
  static String historical(PHistorical params) {
    final String api = ApiConstants.conversation();
    final String parameters =
        '?page=${params.pagination?.page ?? 1}&itemsPerPage=${params.pagination?.itemsPerPage ?? 10}&user=${params.uid}';
    return '$api$parameters';
  }

  static const String payment = '/users/create-subscription';

  static const String subscriptions = '/subscription-types';

  static String code(String code) => '/access-code/check/$code';

  static const String cancelSubscription = '/users/cancel-subscription';
}
