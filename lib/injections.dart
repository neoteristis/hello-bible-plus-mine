import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show PlatformDispatcher, kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:gpt/features/chat/domain/repositories/chat_repository.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc/chat_bloc.dart';
import 'package:gpt/features/container/pages/home/data/datasources/home_remote_data_source.dart';
import 'package:gpt/features/container/pages/home/data/datasources/home_remote_data_source_impl.dart';
import 'package:gpt/features/container/pages/home/domain/usecases/fetch_categories_usecase.dart';
import 'package:gpt/features/container/pages/home/presentation/bloc/home_bloc.dart';
import 'package:gpt/features/container/pages/section/domain/usecases/fetch_welcome_theme_usecase.dart';
import 'package:gpt/features/introduction/presentation/bloc/introduction_bloc.dart';
import 'package:gpt/features/notification/data/repositories/notification_repository_imp.dart';
import 'package:gpt/features/subscription/presentation/bloc/subscription_bloc.dart';
import 'package:gpt/features/user/data/datasources/datasources.dart';
import 'package:gpt/features/user/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:gpt/features/user/presentation/bloc/social_connect_bloc/social_connect_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';

import 'core/base_repository/base_repository.dart';
import 'core/base_repository/base_repository_imp.dart';
import 'core/bloc/obscure_text/obscure_text_cubit.dart';
import 'core/db_services/db_services.dart';
import 'core/dio_interceptors/interceptors.dart';
import 'core/helper/log.dart';
import 'core/helper/text_to_speech.dart';
import 'core/network/network_info.dart';
import 'core/theme/bloc/theme_bloc.dart';
import 'features/chat/data/datasources/chat_local_datasources.dart';
import 'features/chat/data/datasources/chat_remote_datasources.dart';
import 'features/chat/data/repositories/chat_repository_imp.dart';
import 'features/chat/domain/usecases/usecases.dart';
import 'features/chat/presentation/bloc/donation_bloc/donation_bloc.dart';
import 'features/chat/presentation/bloc/historical_bloc/historical_bloc.dart';
import 'features/contact_us/presentation/bloc/contact_us_bloc.dart';
import 'features/container/pages/home/data/repositories/home_repository_impl.dart';
import 'features/container/pages/home/domain/repositories/home_repository.dart';
import 'features/container/pages/home/domain/usecases/fetch_categories_by_section.dart';
import 'features/container/pages/section/data/datasources/section_remote_data_source.dart';
import 'features/container/pages/section/data/datasources/section_remote_data_source_impl.dart';
import 'features/container/pages/section/data/repositories/section_repository_impl.dart';
import 'features/container/pages/section/domain/repositories/section_repository.dart';
import 'features/container/pages/section/presentation/bloc/section_bloc.dart';
import 'features/notification/data/datasources/notification_remote_datasource.dart';
import 'features/notification/domain/repositories/notification_repository.dart';
import 'features/notification/domain/usecases/usecases.dart';
import 'features/notification/presentation/bloc/manage_notif/manage_notif_bloc.dart';
import 'features/notification/presentation/bloc/notification_bloc.dart';
import 'features/subscription/data/datasources/subscription_remote_datasources.dart';
import 'features/subscription/data/repositories/subscription_repository_imp.dart';
import 'features/subscription/domain/repositories/subscription_repository.dart';
import 'features/subscription/domain/usecases/usecases.dart';
import 'features/user/data/models/box/user_box.dart';
import 'features/user/data/repositories/registration_repository_imp.dart';
import 'features/user/domain/repositories/registration_repository.dart';
import 'features/user/domain/usecases/usecases.dart';
import 'features/user/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'features/user/presentation/bloc/profile_bloc/profile_bloc.dart';
import 'firebase_options.dart';
import 'objectbox.g.dart';

// import 'package:timezone/data/latest_all.dart' as tz;
// import 'package:timezone/timezone.dart' as tz;

final getIt = GetIt.instance;

Future<void> init() async {
  await dotenv.load(fileName: '.env');
  await external();
  dataSource();
  repository();
  usecase();
  bloc();
}

Future<void> dioHandling() async {
  final Dio dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
    ),
  );
  getIt.registerLazySingleton(() => dio);
  dio.interceptors
    ..add(LoggingInterceptors())
    ..add(
      AppInterceptors(
        baseRepo: getIt(),
        db: getIt(),
        dio: dio,
      ),
    );
}

Future external() async {
  final documentsDirectory = await getApplicationDocumentsDirectory();
  final databaseDirectory = p.join(documentsDirectory.path, 'hello_bible_plus');

  // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart

  getIt.registerLazySingleton<BaseRepository>(
      () => BaseRepositoryImp(dio: getIt()));
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  getIt.registerLazySingleton(() => internetConnectionChecker);

  final store = await openStore(directory: databaseDirectory);
  getIt.registerLazySingleton(() => store);
  getIt.registerLazySingleton(() => Box<UserBox>(getIt()));

  final SharedPreferences prefs = await SharedPreferences.getInstance();

  getIt.registerLazySingleton<SharedPreferences>(() => prefs);

  getIt.registerLazySingleton<DbService>(
    () => DbServiceImp(
      secureStorage: const FlutterSecureStorage(),
      store: getIt(),
      userBox: getIt(),
      sharedPreferences: getIt(),
    ),
  );
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(
      getIt(),
    ),
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  // Firebase
  // Set the background messaging handler early on, as a named top-level function
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if (!kIsWeb) {
    await setupFlutterNotifications();
  }
  final stripePublishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY_TEST'];
  if (stripePublishableKey != null) {
    Stripe.publishableKey = stripePublishableKey;
  }
  Stripe.merchantIdentifier = 'merchant.com.hello.bible.plus';
  Stripe.urlScheme = 'flutterstripe';
  await Stripe.instance.applySettings();
  final FlutterTts flutterTts = FlutterTts();
  flutterTts.setLanguage('fr');
  final TextToSpeech tts = TextToSpeech(tts: flutterTts);
  getIt.registerLazySingleton<TextToSpeech>(() => tts);
  await dioHandling();
}

void dataSource() {
  getIt.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(getIt()));
  getIt.registerLazySingleton<ChatRemoteDatasources>(
      () => ChatRemoteDatasourcesImp(getIt()));

  getIt.registerLazySingleton<ChatLocalDatasources>(
      () => ChatLocalDatasourcesImp(db: getIt()));

  getIt.registerLazySingleton<RegistrationRemoteDatasources>(
      () => RegistrationRemoteDatasourcesImp(getIt()));

  getIt.registerLazySingleton<RegistrationLocalDatasources>(
      () => RegistrationLocalDatasourcesImp(getIt()));

  getIt.registerLazySingleton<SubscriptionRemoteDatasources>(
      () => SubscriptionRemoteDatasourcesImp(getIt()));
  getIt.registerLazySingleton<NotificationRemoteDatasource>(
      () => NotificationRemoteDatasourceImp(getIt()));
  getIt.registerLazySingleton<SectionRemoteDataSource>(
      () => SectionRemoteDataSourceImpl(getIt()));
}

void repository() {
  // getIt.registerLazySingleton<ChatRemoteDatasources>(
  //     () => ChatRemoteDatasourcesImp(getIt()));
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImp(
        remote: getIt(), networkInfo: getIt(), local: getIt()),
  );

  getIt.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(
      remote: getIt(),
      networkInfo: getIt(),
    ),
  );

  getIt.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepositoryImp(
      remote: getIt(),
      local: getIt(),
      network: getIt(),
    ),
  );

  getIt.registerLazySingleton<SubscriptionRepository>(
    () => SubscriptionRepositoryImp(
      remote: getIt(),
      networkInfo: getIt(),
      registrationLocal: getIt(),
    ),
  );

  getIt.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImp(
      networkInfo: getIt(),
      remote: getIt(),
    ),
  );

  getIt.registerLazySingleton<SectionRepository>(
    () => SectionRepositoryImpl(
      networkInfo: getIt(),
      remote: getIt(),
    ),
  );
}

void usecase() {
  getIt
      .registerLazySingleton(() => FetchCategoriesUsecase(repository: getIt()));
  getIt.registerLazySingleton(() => ChangeConversationUsecase(getIt()));
  getIt.registerLazySingleton(() => SendMessagesUsecase(getIt()));
  getIt.registerLazySingleton(() => GetResponseMessagesUsecase(getIt()));

  getIt.registerLazySingleton(() => RegistrationUsecase(getIt()));
  getIt.registerLazySingleton(() => CheckAuthUsecase(getIt()));

  getIt.registerLazySingleton(() => FetchCategoriesBySectionUsecase(getIt()));

  getIt.registerLazySingleton(() => DeleteAuthUsecase(getIt()));
  getIt.registerLazySingleton(() => FetchHistoricalUsecase(getIt()));

  getIt.registerLazySingleton(() => PaymentIntentUsecase(getIt()));

  getIt.registerLazySingleton(() => InitPaymentUsecase(getIt()));

  getIt.registerLazySingleton(() => PresentPaymentUsecase(getIt()));

  getIt.registerLazySingleton(() => ConfirmPaymentUsecase(getIt()));

  getIt.registerLazySingleton(() => FetchSubscriptionTypesUsecase(getIt()));

  // getIt.registerLazySingleton(() => UpdateSubscriptionUsecase(getIt()));

  getIt.registerLazySingleton(() => CheckCodeUsecase(getIt()));

  getIt.registerLazySingleton(() => CancelSubscriptionUsecase(getIt()));

  getIt.registerLazySingleton(() => CheckEmailUsecase(getIt()));

  getIt.registerLazySingleton(() => PickPictureUsecase(getIt()));

  getIt.registerLazySingleton(() => UpdateUserUsecase(getIt()));

  getIt.registerLazySingleton(() => LoginUsecase(getIt()));

  getIt.registerLazySingleton(() => SignInWithAppleUsecase(getIt()));

  getIt.registerLazySingleton(() => SignInWithGoogleUsecase(getIt()));

  getIt.registerLazySingleton(() => SignInWithFacebookUsecase(getIt()));

  getIt.registerLazySingleton(() => GetConversationByIdUsecase(getIt()));

  getIt.registerLazySingleton(() => GetProfileUsecase(getIt()));

  getIt.registerLazySingleton(
      () => FetchNotificationValuesByCatecoryUsecase(getIt()));
  getIt.registerLazySingleton(() => SwitchNotificationValueUsecase(getIt()));

  getIt.registerLazySingleton(() => GetSuggestionsMessageUsecase(getIt()));
  getIt.registerLazySingleton(() => ChangeNotifTimeUsecase(getIt()));
  // getIt.registerLazySingleton(() => ChangeNotifTimeUsecase(getIt()));
  getIt.registerLazySingleton(() => CancelMessageComingUsecase(getIt()));
  getIt.registerLazySingleton(() => FetchWelcomeThemeUsecase(getIt()));
}

void bloc() {
  getIt.registerFactory(
    () => HomeBloc(
      fetchCategoriesBySection: getIt(),
      fetchCategories: getIt(),
    ),
  );
  getIt.registerFactory(
    () => ChatBloc(
      changeConversation: getIt(),
      sendMessage: getIt(),
      getResponseMessages: getIt(),
      getConversationById: getIt(),
      getSuggestionMessages: getIt(),
      cancelMessageComing: getIt(),
      tts: getIt(),
      // tts: getIt(),
    ),
  );

  getIt.registerFactory(
    () => DonationBloc(),
  );

  getIt.registerFactory(
    () => RegistrationBloc(
      registration: getIt(),
      checkEmail: getIt(),
      pickPicture: getIt(),
      updateUser: getIt(),
    ),
  );

  getIt.registerFactory(
    () => AuthBloc(
      checkAuth: getIt(),
      deleteAuth: getIt(),
      login: getIt(),
    ),
  );

  getIt.registerFactory(
    () => HistoricalBloc(
      fetchHistorical: getIt(),
    ),
  );
  getIt.registerFactory(
    () => SubscriptionBloc(
      paymentIntent: getIt(),
      initPaymentSheet: getIt(),
      presentPaymentSheet: getIt(),
      confirmPaymentSheet: getIt(),
      fetchSubscriptions: getIt(),
      // updateSubscription: getIt(),
      checkCode: getIt(),
      cancelSubscription: getIt(),
    ),
  );

  getIt.registerFactory(
    () => IntroductionBloc(
      db: getIt(),
    ),
  );

  getIt.registerFactory(() => ObscureTextCubit());

  getIt.registerFactory(
    () => SocialConnectBloc(
      signInWithApple: getIt(),
      signInWithGoogle: getIt(),
      signInWithFacebook: getIt(),
    ),
  );

  getIt.registerFactory(
    () => ThemeBloc(
      sharedPreferences: getIt(),
    ),
  );

  getIt.registerFactory(
    () => ProfileBloc(
      getProfile: getIt(),
      updateUser: getIt(),
      pickPicture: getIt(),
    ),
  );

  getIt.registerFactory(
    () => NotificationBloc(
        // fetchNotifCategory: getIt(),
        // switchNotification: getIt(),
        ),
  );

  getIt.registerFactory(
    () => ContactUsBloc(),
  );

  getIt.registerFactory(
    () => ManageNotifBloc(
      switchNotifValue: getIt(),
      changeNotifTime: getIt(),
      notificationFetched: getIt(),
    ),
  );

  // getIt.registerFactory(
  //   () => ManageNotifBloc(
  //     switchNotifValue: getIt(),
  //     changeNotifTime: getIt(),
  //     notificationFetched: getIt(),
  //   ),
  // );

  getIt.registerFactory(
    () => SectionBloc(
      fetchWelcomeTheme: getIt(),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Logger().w('handling background');
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  Log.info('Handling a background message ${message.messageId}');
  getIt<StreamController<String?>>(instanceName: 'select_nofitication')
      .add(message.data['theme']);
}

/// Create a [AndroidNotificationChannel] for heads up notifications
late AndroidNotificationChannel channel;

bool isFlutterLocalNotificationsInitialized = false;

final StreamController<String?> selectNotificationStream =
    StreamController<String?>.broadcast();
final StreamController<RemoteMessage?> onNewPushNotificationStream =
    StreamController<RemoteMessage?>.broadcast();

Future<void> setupFlutterNotifications() async {
  if (isFlutterLocalNotificationsInitialized) {
    return;
  }

  getIt.registerLazySingleton(() => selectNotificationStream,
      instanceName: 'select_nofitication');

  getIt.registerLazySingleton(() => onNewPushNotificationStream,
      instanceName: 'new_push_notification');
  channel = const AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  getIt.registerLazySingleton(() => flutterLocalNotificationsPlugin);

  flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails()
      .then((value) {
    final payload = value?.notificationResponse?.payload;
    if (payload != null) {
      selectNotificationStream.add(value!.notificationResponse!.payload);
    }
  });

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/notif_icon');
  const DarwinInitializationSettings initializationSettingsDarwin =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);
  const InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsDarwin,
  );
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse:
        (NotificationResponse notificationResponse) {
      Log.info('there we go : ${notificationResponse.payload}');
      // print(notificationResponse.payload);
      selectNotificationStream.add(notificationResponse.payload);
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

  // await scheduledNotification();

  /// Create an Android Notification Channel.
  ///
  /// We use this channel in the `AndroidManifest.xml` file to override the
  /// default FCM channel to enable heads up notifications.
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);

  /// Update the iOS foreground notification presentation options to allow
  /// heads up notifications.
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
  isFlutterLocalNotificationsInitialized = true;
}

void showFlutterNotification(RemoteMessage message) {
  final RemoteNotification? notification = message.notification;
  final AndroidNotification? android = message.notification?.android;
  Log.info('play here ${message.data}');
  onNewPushNotificationStream.add(message);
  if (notification != null && android != null && !kIsWeb) {
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title ?? 'title',
      notification.body ?? 'body',
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel.id,
          channel.name,
          channelDescription: channel.description,
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      payload: message.data['theme'],
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
  Logger().w('tap back ground 2');
  getIt<StreamController<String?>>(instanceName: 'select_nofitication')
      .add(notificationResponse.payload);
  if (notificationResponse.input?.isNotEmpty ?? false) {
    // ignore: avoid_print
    print(
        'notification action tapped with input: ${notificationResponse.input}');
  }
}

void onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) {
  Logger().w('tap back ground 3');
  getIt<StreamController<String?>>(instanceName: 'select_nofitication')
      .add(payload);
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

// Future scheduledNotification() async {
//   tz.initializeTimeZones();

//   tz.setLocalLocation(tz.getLocation('Africa/Nairobi'));

//   await flutterLocalNotificationsPlugin.zonedSchedule(
//     0,
//     'scheduled title',
//     'scheduled body',
//     tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
//     const NotificationDetails(
//       android: AndroidNotificationDetails(
//         'high_importance_channel', // id
//         'High Importance Notifications', // title
//         channelDescription: 'This channel is used for important notifications.',
//         priority: Priority.high,
//         importance: Importance.high,
//       ),
//       iOS: DarwinNotificationDetails(
//         presentAlert: true,
//         presentBadge: true,
//         presentSound: true,
//       ),
//     ),
//     androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
//     uiLocalNotificationDateInterpretation:
//         UILocalNotificationDateInterpretation.absoluteTime,
//   );
// }
