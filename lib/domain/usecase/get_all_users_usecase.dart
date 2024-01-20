import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetAllusersUsecase {
  final Repository _repository;

  GetAllusersUsecase(this._repository);

  Future<Either<Failure, List<Customer>>> execute() async {
    return await _repository.getAllUsers();
  }
}
