import 'package:blog_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, String>> signUpWithEmailPassword({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, String>> loginInWithEmailPassword({
    required String email,
    required String password,
  });
}
