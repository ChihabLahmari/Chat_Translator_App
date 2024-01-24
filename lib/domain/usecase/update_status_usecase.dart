import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class UpdatetypingStatusUsecase {
  final Repository _repository;

  UpdatetypingStatusUsecase(this._repository);

  Future<Either<Failure, void>> execute(String myFriendId, String myId, bool typingStatus) async {
    return await _repository.updateTypingStatus(myFriendId, myId, typingStatus);
  }
}
