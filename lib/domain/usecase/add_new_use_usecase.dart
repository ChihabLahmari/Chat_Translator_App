import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/entities/user.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class AddNewUserToFiresbaseUsecase {
  final Repository _repository;

  AddNewUserToFiresbaseUsecase(this._repository);

  Future<Either<Failure, String>> execute(Customer customer) async {
    return await _repository.addNewUserToFiresbase(customer);
  }
}
