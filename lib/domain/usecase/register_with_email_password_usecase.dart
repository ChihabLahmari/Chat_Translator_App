import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class RegisterWithEmailAndPasswordUsecase {
  final Repository _repository;

  RegisterWithEmailAndPasswordUsecase(this._repository);

  Future<Either<Failure, String>> execute(String email, String password) async {
    return await _repository.registerWithEmailAndPassword(email, password);
  }
}
