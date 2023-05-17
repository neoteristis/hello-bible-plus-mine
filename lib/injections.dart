import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get_it/get_it.dart';
import 'package:gpt/features/chat/domain/repositories/chat_repository.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:gpt/features/user/data/datasources/datasources.dart';
import 'package:gpt/features/user/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/base_repository/base_repository.dart';
import 'core/base_repository/base_repository_imp.dart';
import 'core/db_services/db_services.dart';
import 'core/dio_interceptors/interceptors.dart';
import 'core/network/network_info.dart';
import 'features/chat/data/datasources/chat_remote_datasources.dart';
import 'features/chat/data/repositories/chat_repository_imp.dart';
import 'features/chat/domain/usecases/usecases.dart';
import 'features/chat/presentation/bloc/donation_bloc/donation_bloc.dart';
import 'features/user/data/repositories/registration_repository_imp.dart';
import 'features/user/domain/repositories/registration_repository.dart';
import 'features/user/domain/usecases/usecases.dart';
import 'features/user/presentation/bloc/auth_bloc/auth_bloc.dart';

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
  dio.interceptors.add(LoggingInterceptors());
}

Future external() async {
  await dioHandling();
  getIt.registerLazySingleton<BaseRepository>(
      () => BaseRepositoryImp(dio: getIt()));
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  getIt.registerLazySingleton(() => internetConnectionChecker);
  getIt.registerLazySingleton<DbService>(
      () => DbServiceImp(secureStorage: const FlutterSecureStorage()));
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(
      getIt(),
    ),
  );
  final FlutterTts flutterTts = FlutterTts();
  await flutterTts.setSharedInstance(true);
  await flutterTts.setSpeechRate(0.5);
  await flutterTts.setLanguage('fr-FR');
  // await flutterTts.setVoice({'name': 'Karen', 'locale': 'fr-FR'});
  await flutterTts.setVolume(1.0);

  getIt.registerLazySingleton<FlutterTts>(() => flutterTts);
}

void dataSource() {
  getIt.registerLazySingleton<ChatRemoteDatasources>(
      () => ChatRemoteDatasourcesImp(getIt()));

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
        remote: ChatRemoteDatasourcesImp(getIt()), networkInfo: getIt()),
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
}

void bloc() {
  getIt.registerFactory(
    () => ChatBloc(
      fetchCategories: getIt(),
      changeConversation: getIt(),
      sendMessage: getIt(),
      getResponseMessages: getIt(),
      tts: getIt(),
    ),
  );

  getIt.registerFactory(
    () => DonationBloc(),
  );

  getIt.registerFactory(
    () => RegistrationBloc(registration: getIt()),
  );

  getIt.registerFactory(
    () => AuthBloc(checkAuth: getIt()),
  );
}
