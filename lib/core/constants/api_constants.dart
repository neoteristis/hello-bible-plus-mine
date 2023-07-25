// api_constants.dart
import '../../features/chat/domain/usecases/fetch_historical_usecase.dart';
import 'pagination_const.dart';

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

  static String stop(String id) => '$route/conversations/stop/$id';

  static String checkEmail(String email) => '$route/user_email?email=$email';

  static String messages(String conversationId) =>
      '$route/messages/$conversationId';
  static String answer(String conversationId, int? idMessage) {
    if (idMessage != null) {
      return '$route/messages/$conversationId?messageId=$idMessage';
    }
    return '$route/messages/$conversationId';
  }

  static String suggestions(String conversationId) =>
      '$route/conversations/generate_question/$conversationId';
  // Add more API strings here

  // new api
  static String registration({String? uid}) {
    if (uid == null) {
      return '$route/users';
    }
    return '$route/users/$uid';
  }

  static String categoryNotif = '$route/notification-time';

  static String me = '$route/me';

  static const String categoriesBySection = '$route/categories_by_section';
  static String historical(PHistorical params) {
    final String api = ApiConstants.conversation();
    final String parameters =
        '?page=${params.pagination?.page ?? 1}&itemsPerPage=${params.pagination?.itemsPerPage ?? itemNumber}&user=${params.uid}';
    return '$api$parameters';
  }

  static const String payment = '$route/users/create-subscription';

  static const String subscriptions = '$route/subscription-types';

  static String code(String code) => '$route/access-code/check/$code';

  static const String cancelSubscription = '$route/users/cancel-subscription';
}
