class RouteName {
  static const String login = 'Login';
  static const String logged = 'Logged';
  static const String splash = 'Splash';
  static const String landing = '/landing';
  static const String home = '/';
  static const String registration = '/registration';
  static const String email = '/registration/email';
  static const String password = '/registration/email/password';
  static const String newPassword = '/registration/email/newPassword';
  static const String namePicture = '/registration/email/namePicture';
  static const String registrationFailed = '/failed';
  static const String historical = '/historical';
  static const String subscribe = '/subscribe';
  static const String subscription = '/registration/subscription';
  static const String profile = '/profile';
}

enum GoTo {
  init,
  login,
  registration,
}
