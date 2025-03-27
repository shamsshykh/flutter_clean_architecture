import 'package:flutter_clean_architecture/core/network/api_client.dart';
import 'package:flutter_clean_architecture/features/domain/usecases/get_user_comments.dart';
import 'package:flutter_clean_architecture/features/domain/usecases/post_user_detail.dart';
import 'package:flutter_clean_architecture/features/presentation/bloc/user_state_hold/user_data_bloc.dart';
import 'package:get_it/get_it.dart';

import '../../features/data/repository/user_repository_impl.dart';
import '../../features/domain/repository/user_repository.dart';
import '../../features/domain/usecases/get_current_user.dart';
import '../../features/presentation/bloc/user/user_bloc.dart';
import '../network/api_service.dart';

final GetIt sl = GetIt.instance;

void setupDependencies() {
  // Dio setup
  sl.registerLazySingleton(() => ApiClient().dio);

  // API Service
  sl.registerLazySingleton(() => ApiService(sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(sl()));

  // UseCase
  sl.registerLazySingleton(() => GetCurrentUserUseCase(sl()));
  sl.registerLazySingleton(() => GetUserCommentsCase(sl()));
  sl.registerLazySingleton(() => PostUserDetail(sl()));

  // BLoC
  sl.registerFactory(() => UserBloc(sl(), sl(), sl()));

  sl.registerFactory(() => UserDataBloc(sl(), sl(), sl()));
}
