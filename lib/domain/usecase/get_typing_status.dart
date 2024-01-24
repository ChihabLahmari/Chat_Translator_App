import 'package:chat_translator/domain/repository/repository.dart';

class GetTypingStatusUsecase {
  final Repository _repository;

  GetTypingStatusUsecase(this._repository);

  Stream<bool> execute(String myFriendId, String myId) {
    return _repository.getTypingStatus(myFriendId, myId);
  }
}
