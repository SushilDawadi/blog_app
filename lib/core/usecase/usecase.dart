import 'package:blog_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract interface class Usercase<SuccesType, Params> {
  Future<Either<Failure, SuccesType>> call(Params params);
}

class NoParams {}
