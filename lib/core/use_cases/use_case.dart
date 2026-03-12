import 'package:dartz/dartz.dart';
import 'package:invoicepro/core/error/Failure.dart';

// ignore: avoid_types_as_parameter_names
abstract class UserCase<Type, Param> {
  Future<Either<Failure, Type>> call([Param param]);
}

class NoParam {}
