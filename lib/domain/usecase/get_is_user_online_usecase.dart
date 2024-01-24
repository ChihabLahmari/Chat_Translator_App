import 'package:chat_translator/domain/repository/repository.dart';

class GetIsUserOnlineUsecase {
  final Repository _repository;

  GetIsUserOnlineUsecase(this._repository);

  Stream<bool> execute(String myFriendId) {
    return _repository.getIsUserOnline(myFriendId);
  }
}
