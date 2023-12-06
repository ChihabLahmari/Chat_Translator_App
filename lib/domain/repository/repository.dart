import 'package:chat_translator/domain/entities/user.dart';

abstract class Repository {
  Future<void> loginWithEmailAndPassword(String email, String password);
  Future<void> registerWithEmailAndPassword(String email, String password);
  Future<List<User>> getAllUsers();
  Future<List<Message>> getMessagesByFriendId(String myFriendId);
  Future<void> sentMessageToUserFirebase(Message message);
  Future<String> translateMsgToFriendLang(Message message);
  Future<void> sentTranslatedMsgToFriendFirebase(Message translatedMsg);
}
