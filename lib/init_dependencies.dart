import 'package:blog_app/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blog_app/core/secrets/app_secrets.dart';
import 'package:blog_app/features/auth/data/data_sources/auth_remote_dart_source.dart';
import 'package:blog_app/features/auth/data/respository/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usescases/current_user.dart';
import 'package:blog_app/features/auth/domain/usescases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usescases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  final supabase = await Supabase.initialize(
    url: AppSecrets.supabaseUrl,
    anonKey: AppSecrets.supabaseAnonkey,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        serviceLocator(),
      ),
    )
    ..registerFactory(
      () => CurrentUser(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
        currentUser: serviceLocator(),
        appUserCubit: serviceLocator(),
      ),
    );
}
