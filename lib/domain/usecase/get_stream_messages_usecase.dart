import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/repository/repository.dart';

class GetStreamMessagesUseCase {
  final Repository _repository;

  GetStreamMessagesUseCase(this._repository);

  Stream<List<Message>> execute(String myFriendId, String myId) {
    return _repository.getStreamMessages(myFriendId, myId);
  }
}
