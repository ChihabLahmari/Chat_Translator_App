import 'package:chat_translator/domain/entities/user.dart';

abstract class Repository {
  Future<List<User>> getAllUsers();
  Future<List<Message>> getMessagesByFriendId(String myFriendId);
  Future<String> translateMsgToFriendLang(String myMessage);
  void sentTranslatedMsgToFriendFirebase(String translatedMsg);
  void sentMessageToUserFirebase(String message);
}
