// api_constants.dart
class ApiConstants {
  static const String categories = '/categories';
  static const String conversation = '/conversations';
  static String messages(bool streamMessage) =>
      '/messages?withoutSendMessage=$streamMessage';
  static String answer(int id) => '/response_message?message_id=$id';
  static String messages2(int? id) => '/chat/$id';
  // Add more API strings here

  // new api
  static const String registration = '/users';
}
