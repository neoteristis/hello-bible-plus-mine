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
  static const String editProfil = '/profile/edit-profile';
  static const String notifications = '/notif';
  static const String manageNotif = '/notif/manageNotif';
  static const String contactUs = '/contact-us';
  static const String about = '/about';
  static const String help = '/help';
  static const String conditions = '/usage-general-conditions';
}

enum GoTo {
  init,
  login,
  registration,
}
