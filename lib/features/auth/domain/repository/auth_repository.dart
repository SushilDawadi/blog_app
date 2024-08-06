import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, User>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, User>> loginInWithEmailPassword({
    required String email,
    required String password,
  });
}
