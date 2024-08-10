import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/helper/connection_checker.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/data/models/user_model.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final ConnectionChecker connectionChecker;
  AuthRepositoryImpl(this.connectionChecker,
      {required this.authRemoteDataSource});

  @override
  Future<Either<Failure, User>> currentUser() async {
    if (!await (connectionChecker.isConnected)) {
      final session = authRemoteDataSource.currentUserSession;
      if (session == null) {
        return Left(Failure("User is not logged in!"));
      }

      return Right(UserModel(
        id: session.user.id,
        email: session.user.email ?? " ",
        name: "",
      ));
    }

    final user = await authRemoteDataSource.getCurrentUserData();
    if (user == null) {
      return Left(
        Failure("User is not logged in!"),
      );
    }
    return Right(user);
  }

  @override
  Future<Either<Failure, User>> loginInWithEmailPassword(
      {required String email, required String password}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return Left(Failure("No internet connection"));
      }
      final user = await authRemoteDataSource.loginInWithEmailPassword(
          email: email, password: password);
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> signUpWithEmailPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      if (!await (connectionChecker.isConnected)) {
        return Left(Failure("No internet connection"));
      }
      final user = await authRemoteDataSource.signUpWithEmailPassword(
        email: email,
        password: password,
        name: name,
      );
      return Right(user);
    } on ServerException catch (e) {
      return Left(Failure(e.message));
    }
  }
}
