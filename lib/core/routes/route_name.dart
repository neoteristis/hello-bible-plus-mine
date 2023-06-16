class RouteName {
  static const String login = 'Login';
  static const String logged = 'Logged';
  static const String splash = 'Splash';
  static const String landing = '/landing';
  static const String home = '/';
  // static const String registration = '/registration';
  static const String email = '/email';
  static const String password = '/email/password';
  static const String newPassword = '/email/newPassword';
  static const String namePicture = '/email/namePicture';
  static const String registrationFailed = '/failed';
  static const String historical = '/historical';
  static const String subscribe = '/subscribe';
  static const String subscription = '/registration/subscription';
}

enum GoTo {
  init,
  login,
  registration,
}
