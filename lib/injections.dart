import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:gpt/features/chat/domain/repositories/chat_repository.dart';
import 'package:gpt/features/chat/domain/usecases/fetch_categories_usecase.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';

import 'core/dio_interceptors/interceptors.dart';
import 'features/chat/data/datasources/chat_remote_datasources.dart';
import 'features/chat/data/repositories/chat_repository_imp.dart';

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
}

void dataSource() {
  getIt.registerLazySingleton<ChatRemoteDatasources>(
      () => ChatRemoteDatasourcesImp(getIt()));
}

void repository() {
  getIt.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImp(remote: getIt()),
  );
}

void usecase() {
  getIt.registerLazySingleton(() => FetchCategoriesUsecase(getIt()));
  getIt.registerLazySingleton(() => ChatConversationChanged(getIt()));
}

void bloc() {
  getIt.registerFactory(
    () => ChatBloc(
      fetchCategories: getIt(),
      changeConversation: getIt(),
    ),
  );
}
