import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class GetMessagesByFriendIdUsecase {
  final Repository _repository;

  GetMessagesByFriendIdUsecase(this._repository);

  Future<Either<Failure, List<Message>>> execute(String myFriendId, String myId) async {
    return await _repository.getMessagesByFriendId(myFriendId, myId);
  }
}
