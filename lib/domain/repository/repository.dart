import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:dartz/dartz.dart';

abstract class Repository {
  Future<Either<Failure, String>> registerWithEmailAndPassword(String email, String password);
  Future<Either<Failure, String>> addNewUserToFiresbase(Customer customer);
  Future<Either<Failure, String>> loginWithEmailAndPassword(String email, String password);
  Future<Either<Failure, Customer>> getUserDataById(String id);
  Future<Either<Failure, List<Customer>>> getAllUsers();
  Future<Either<Failure, List<Message>>> getMessagesByFriendId(String myFriendId, String myId);
  Future<Either<Failure, String>> translateMsgToFriendLang(String friendLang, String message);
  Future<Either<Failure, void>> sentMessageToUserFirebase(Message message);
  Future<Either<Failure, void>> sentTranslatedMsgToFriendFirebase(Message translatedMsg);
}
