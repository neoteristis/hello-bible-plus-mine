// api_constants.dart
import '../../features/chat/domain/usecases/fetch_historical_usecase.dart';

const route = '/api';

class ApiConstants {
  static const String login = '$route/auth/login';
  static const String categories = '$route/categories';
  static String conversation({String? conversationId}) {
    if (conversationId != null) {
      return '$route/conversations/$conversationId';
    }
    return '$route/conversations';
  }

  static String checkEmail(String email) => '$route/user_email?email=$email';

  static String messages(String conversationId) =>
      '$route/messages/$conversationId';
  static String answer(String conversationId) =>
      '$route/messages/$conversationId';
  // Add more API strings here

  // new api
  static String registration({String? uid}) {
    if (uid == null) {
      return '$route/users';
    }
    return '$route/users/$uid';
  }

  static const String categoriesBySection = '$route/categories_by_section';
  static String historical(PHistorical params) {
    final String api = ApiConstants.conversation();
    final String parameters =
        '$route?page=${params.pagination?.page ?? 1}&itemsPerPage=${params.pagination?.itemsPerPage ?? 10}&user=${params.uid}';
    return '$api$parameters';
  }

  static const String payment = '$route/users/create-subscription';

  static const String subscriptions = '$route/subscription-types';

  static String code(String code) => '$route/access-code/check/$code';

  static const String cancelSubscription = '$route/users/cancel-subscription';
}
