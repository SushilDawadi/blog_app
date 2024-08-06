import 'package:blog_app/core/secrets/app_secret.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_in.dart';
import 'package:blog_app/features/auth/domain/usecases/user_sign_up.dart';
import 'package:blog_app/features/auth/presentation/bloc/bloc/auth_bloc.dart';

import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async {
  // Initialize Supabase before other services
  final supabase = await Supabase.initialize(
      url: AppSecret.supabaseUrl, anonKey: AppSecret.supabaseAnonKey);
  serviceLocator.registerLazySingleton(() => supabase.client);

  _initAuth();
}

void _initAuth() {
  serviceLocator
    ..registerFactory<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        supabaseClient: serviceLocator(),
      ),
    )
    ..registerFactory<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignUp(
        authRepository: serviceLocator(),
      ),
    )
    ..registerFactory(
      () => UserSignIn(
        authRepository: serviceLocator(),
      ),
    )
    ..registerLazySingleton(
      () => AuthBloc(
        userSignUp: serviceLocator(),
        userSignIn: serviceLocator(),
      ),
    );
}
