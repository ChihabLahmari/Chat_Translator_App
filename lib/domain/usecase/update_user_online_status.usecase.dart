import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class UpdateUserOnlineStatus {
  final Repository _repository;

  UpdateUserOnlineStatus(this._repository);

  Future<Either<Failure, void>> execute(String userId, bool status) async {
    return _repository.updateUserOnlineStatus(userId, status);
  }
}
