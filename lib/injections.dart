import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:gpt/features/chat/presentation/bloc/chat_bloc.dart';

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
}

Future external() async {
  await dioHandling();
}

void dataSource() {}

void repository() {}

void usecase() {}

void bloc() {
  getIt.registerFactory(
    () => ChatBloc(),
  );
}
