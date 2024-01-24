import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/repository/repository.dart';

class GetLastMessageUsecase {
  final Repository _repository;

  GetLastMessageUsecase(this._repository);

  Stream<Message> execute(String myFriendId, String myId) {
    return _repository.getLastMessage(myFriendId, myId);
  }
}
