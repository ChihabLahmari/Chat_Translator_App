import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/data/datasource/remote_data_source.dart';
import 'package:chat_translator/data/models/models.dart';
import 'package:chat_translator/domain/entities/user.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;

  RepositoryImpl(this._remoteDataSource);

  @override
  Future<Either<Failure, String>> addNewUserToFiresbase(Customer customer) async {
    try {
      final result = await _remoteDataSource.addNewUserToFiresbase(
          CustomerModel(customer.fullName, customer.image, customer.id, customer.email, customer.firstLanguage));
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Message>>> getMessagesByFriendId(String myFriendId, String myId) async {
    try {
      final result = await _remoteDataSource.getMessagesByFriendId(myFriendId, myId);
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> loginWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _remoteDataSource.loginWithEmailAndPassword(email, password);
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> registerWithEmailAndPassword(String email, String password) async {
    try {
      final result = await _remoteDataSource.registerWithEmailAndPassword(email, password);
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sentMessageToUserFirebase(Message message) async {
    try {
      final result = await _remoteDataSource.sentMessageToUserFirebase(
          MessageModel(message.text, message.dateTime, message.receiverId, message.senderId));
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sentTranslatedMsgToFriendFirebase(Message translatedMsg) async {
    try {
      final result = await _remoteDataSource.sentTranslatedMsgToFriendFirebase(
          MessageModel(translatedMsg.text, translatedMsg.dateTime, translatedMsg.receiverId, translatedMsg.senderId));
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> translateMsgToFriendLang(String friendLang, String message) async {
    try {
      final result = await _remoteDataSource.translateMsgToFriendLang(friendLang, message);
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Customer>>> getAllUsers() async {
    try {
      final result = await _remoteDataSource.getAllUsers();
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }

  @override
  Future<Either<Failure, Customer>> getUserDataById(String id) async {
    try {
      CustomerModel result = await _remoteDataSource.getUserDataById(id);
      return right(result);
    } on FirebaseException catch (excpetion) {
      print(excpetion.message);
      return left(Failure(excpetion.message.toString()));
    }
  }
}
