import 'package:blog_app/core/error/failure.dart';
import 'package:blog_app/core/usecase/usecase.dart';
import 'package:blog_app/features/auth/domain/entities/user.dart';
import 'package:blog_app/features/auth/domain/repository/auth_repository.dart';
import 'package:dartz/dartz.dart';

class CurrentUser implements Usercase<User, NoParams> {
  final AuthRepository repository;

  CurrentUser(this.repository);
  @override
  Future<Either<Failure, User>> call(params) async {
    return await repository.currentUser();
  }
}
