// api_constants.dart
class ApiConstants {
  static const String categories = '/categories';
  static const String conversation = '/conversations';
  static String messages(String conversationId) => '/messages/$conversationId';
  static String answer(String conversationId) => '/messages/$conversationId';
  static String messages2(int? id) => '/chat/$id';
  // Add more API strings here

  // new api
  static const String registration = '/users';
  static const String categoriesBySection = '/categories_by_section';
}
