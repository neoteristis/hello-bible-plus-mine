import 'dart:async';

import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:gpt/features/chat/domain/repositories/chat_repository.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:gpt/features/user/data/datasources/datasources.dart';
import 'package:gpt/features/user/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'core/base_repository/base_repository.dart';
import 'core/base_repository/base_repository_imp.dart';
import 'core/db_services/db_services.dart';
import 'core/dio_interceptors/interceptors.dart';
import 'core/helper/log.dart';
import 'core/network/network_info.dart';
import 'features/chat/data/datasources/chat_local_datasources.dart';
import 'features/chat/data/datasources/chat_remote_datasources.dart';
import 'features/chat/data/repositories/chat_repository_imp.dart';
import 'features/chat/domain/usecases/usecases.dart';
import 'features/chat/presentation/bloc/donation_bloc/donation_bloc.dart';
import 'features/chat/presentation/bloc/historical_bloc/historical_bloc.dart';
import 'features/user/data/models/box/user_box.dart';
import 'features/user/data/repositories/registration_repository_imp.dart';
import 'features/user/domain/repositories/registration_repository.dart';
import 'features/user/domain/usecases/usecases.dart';
import 'features/user/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'objectbox.g.dart';

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

  getIt.registerLazySingleton<DbService>(
    () => DbServiceImp(
      secureStorage: const FlutterSecureStorage(),
      store: getIt(),
      userBox: getIt(),
    ),
  );
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(
      getIt(),
    ),
  );

  await Firebase.initializeApp();
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
  await dioHandling();
}

void dataSource() {
  getIt.registerLazySingleton<ChatRemoteDatasources>(
      () => ChatRemoteDatasourcesImp(getIt()));

  getIt.registerLazySingleton<ChatLocalDatasources>(
      () => ChatLocalDatasourcesImp(db: getIt()));

  getIt.registerLazySingleton<RegistrationRemoteDatasources>(
      () => RegistrationRemoteDatasourcesImp(getIt()));

  getIt.registerLazySingleton<RegistrationLocalDatasources>(
      () => RegistrationLocalDatasourcesImp(getIt()));
}

void repository() {
  // getIt.registerLazySingleton<ChatRemoteDatasources>(
  //     () => ChatRemoteDatasourcesImp(getIt()));
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImp(
        remote: getIt(), networkInfo: getIt(), local: getIt()),
  );

  getIt.registerLazySingleton<RegistrationRepository>(
    () => RegistrationRepositoryImp(
      remote: getIt(),
      local: getIt(),
      network: getIt(),
    ),
  );
}

void usecase() {
  getIt.registerLazySingleton(
      () => FetchCategoriesUsecase(chatRepository: getIt()));
  getIt.registerLazySingleton(() => ChangeConversationUsecase(getIt()));
  getIt.registerLazySingleton(() => SendMessagesUsecase(getIt()));
  getIt.registerLazySingleton(() => GetResponseMessagesUsecase(getIt()));

  getIt.registerLazySingleton(() => RegistrationUsecase(getIt()));
  getIt.registerLazySingleton(() => CheckAuthUsecase(getIt()));

  getIt.registerLazySingleton(() => FetchCategoriesBySectionUsecase(getIt()));

  getIt.registerLazySingleton(() => DeleteAuthUsecase(getIt()));
  getIt.registerLazySingleton(() => FetchHistoricalUsecase(getIt()));
}

void bloc() {
  getIt.registerFactory(
    () => ChatBloc(
      fetchCategories: getIt(),
      changeConversation: getIt(),
      sendMessage: getIt(),
      getResponseMessages: getIt(),
      fetchCategoriesBySection: getIt(),
      // tts: getIt(),
    ),
  );

  getIt.registerFactory(
    () => DonationBloc(),
  );

  getIt.registerFactory(
    () => RegistrationBloc(registration: getIt()),
  );

  getIt.registerFactory(
    () => AuthBloc(
      checkAuth: getIt(),
      deleteAuth: getIt(),
    ),
  );

  getIt.registerFactory(
    () => HistoricalBloc(
      fetchHistorical: getIt(),
    ),
  );
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  await setupFlutterNotifications();
  // showFlutterNotification(message);
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  Log.info('Handling a background message ${message.messageId}');
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

  flutterLocalNotificationsPlugin
      .getNotificationAppLaunchDetails()
      .then((value) => selectNotificationStream.add('heeeey'));

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('mipmap/ic_launcher');
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
      selectNotificationStream.add(notificationResponse.payload);
    },
    onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
  );

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
  Log.info(message);
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
    );
  }
}

@pragma('vm:entry-point')
void notificationTapBackground(NotificationResponse notificationResponse) {
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
  getIt<StreamController<String?>>(instanceName: 'select_nofitication')
      .add(payload);
}

/// Initialize the [FlutterLocalNotificationsPlugin] package.
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
