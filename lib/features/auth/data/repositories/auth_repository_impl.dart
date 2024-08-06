import 'package:blog_app/core/error/exception.dart';
import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl({required this.authRemoteDataSource});
  @override
  Future<Either<Failure, User>> loginInWithEmailPassword(
      {required String email, required String password}) async {
    try {
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
