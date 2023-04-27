import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:gpt/features/chat/domain/repositories/chat_repository.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'core/base_repository/base_repository.dart';
import 'core/base_repository/base_repository_imp.dart';
import 'core/dio_interceptors/interceptors.dart';
import 'core/network/network_info.dart';
import 'features/chat/data/datasources/chat_remote_datasources.dart';
import 'features/chat/data/repositories/chat_repository_imp.dart';
import 'features/chat/domain/usecases/usecases.dart';

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
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImp(
      getIt(),
    ),
  );
}

void dataSource() {
  getIt.registerLazySingleton<ChatRemoteDatasources>(
      () => ChatRemoteDatasourcesImp(getIt()));
}

void repository() {
  // getIt.registerLazySingleton<ChatRemoteDatasources>(
  //     () => ChatRemoteDatasourcesImp(getIt()));
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImp(
        remote: ChatRemoteDatasourcesImp(getIt()), networkInfo: getIt()),
  );
}

void usecase() {
  getIt.registerLazySingleton(
      () => FetchCategoriesUsecase(chatRepository: getIt()));
  getIt.registerLazySingleton(() => ChangeConversationUsecase(getIt()));
  getIt.registerLazySingleton(() => SendMessagesUsecase(getIt()));
  getIt.registerLazySingleton(() => GetResponseMessagesUsecase(getIt()));
}

void bloc() {
  getIt.registerFactory(
    () => ChatBloc(
      fetchCategories: getIt(),
      changeConversation: getIt(),
      sendMessage: getIt(),
      getResponseMessages: getIt(),
    ),
  );
}
