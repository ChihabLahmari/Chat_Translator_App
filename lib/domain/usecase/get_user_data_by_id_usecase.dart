import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/entities/user.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetUserDataByIdUsecase {
  final Repository _repository;

  GetUserDataByIdUsecase(this._repository);

  Future<Either<Failure, Customer>> execute(String id) async {
    return await _repository.getUserDataById(id);
  }
}
