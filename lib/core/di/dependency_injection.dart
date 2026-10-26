import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:mediconnect/core/api/api_consumer.dart';
import 'package:mediconnect/core/api/api_service.dart';
import 'package:mediconnect/core/api/dio_factory.dart';
import 'package:mediconnect/features/auth/data/datasources/auth_local_data_source.dart';
import 'package:mediconnect/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:mediconnect/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:mediconnect/features/auth/domain/repositories/auth_repository.dart';
import 'package:mediconnect/features/auth/domain/usecases/login_usecase.dart';
import 'package:mediconnect/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mediconnect/features/onboarding/data/datasources/onboarding_local_data_source.dart';
import 'package:mediconnect/features/onboarding/data/repositories/onboarding_repository_impl.dart';
import 'package:mediconnect/features/onboarding/domain/repositories/onboarding_repository.dart';
import 'package:mediconnect/features/onboarding/domain/usecases/get_onboarding_completed_usecase.dart';
import 'package:mediconnect/features/onboarding/domain/usecases/set_onboarding_completed_usecase.dart';
import 'package:mediconnect/features/onboarding/presentation/cubit/onboarding_cubit.dart';

final GetIt getIt = GetIt.instance;

Future<void> setupGetIt() async {
  // Core: Dio & Api
  final dio = DioFactory.getDio();
  getIt.registerLazySingleton<Dio>(() => dio);
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<Dio>()));
  getIt.registerLazySingleton<ApiConsumer>(() => DioConsumer(dio: getIt<Dio>()));

  // Auth: Data Sources
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(apiService: getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AuthLocalDataSource>(
    () => AuthLocalDataSourceImpl(),
  );

  // Auth: Repository
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      remoteDataSource: getIt<AuthRemoteDataSource>(),
      localDataSource: getIt<AuthLocalDataSource>(),
    ),
  );

  // Auth: Use Cases
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  // Auth: Bloc
  getIt.registerFactory<AuthBloc>(
    () => AuthBloc(loginUseCase: getIt<LoginUseCase>()),
  );

  // Onboarding: Data Sources & Repository
  getIt.registerLazySingleton<OnboardingLocalDataSource>(
    () => OnboardingLocalDataSourceImpl(),
  );
  getIt.registerLazySingleton<OnboardingRepository>(
    () => OnboardingRepositoryImpl(getIt<OnboardingLocalDataSource>()),
  );

  // Onboarding: Use Cases
  getIt.registerLazySingleton<GetOnboardingCompletedUseCase>(
    () => GetOnboardingCompletedUseCase(getIt<OnboardingRepository>()),
  );
  getIt.registerLazySingleton<SetOnboardingCompletedUseCase>(
    () => SetOnboardingCompletedUseCase(getIt<OnboardingRepository>()),
  );

  // Onboarding: Cubit
  getIt.registerFactory<OnboardingCubit>(
    () => OnboardingCubit(
      setOnboardingCompletedUseCase: getIt<SetOnboardingCompletedUseCase>(),
    ),
  );
}
