import 'dart:convert';

import 'package:chat_translator/core/error/exceptions.dart';
import 'package:chat_translator/core/network/api_constance.dart';
import 'package:chat_translator/core/network/error_message_model.dart';
import 'package:chat_translator/data/models/user_model.dart';
import 'package:chat_translator/data/network/firebase_auth.dart';
import 'package:chat_translator/data/network/firebase_store.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart';

abstract class RemoteDataSource {
  Future<String> registerWithEmailAndPassword(String fullName, String firstLanguage, String email, String password);
  Future<String> addNewUserToFiresbase(UserModel userModel);
  Future<String> loginWithEmailAndPassword(String email, String password);
  Future<List<UserModel>> getAllUsers();
  Future<String> translateMsgToFriendLang(String friendLanguage, String myMessage);
  Future<void> sentMessageToUserFirebase(MessageModel message);
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId);
  Future<void> sentTranslatedMsgToFriendFirebase(MessageModel translatedMsg);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuthentication _firebaseAuthentication;
  final FirebaseStore _firebaseStore;

  RemoteDataSourceImpl(this._firebaseAuthentication, this._firebaseStore);
  @override
  Future<String> registerWithEmailAndPassword(
    String fullName,
    String firstLanguage,
    String email,
    String password,
  ) async {
    try {
      var id = await _firebaseAuthentication.registerWithEmailAndPassword(email, password);
      print("registerWithEmailAndPassword");
      return id;

      // return await _firebaseStore.addNewUserToFirestore(
      //   UserModel(
      //     fullName,
      //     'image',
      //     id,
      //     email,
      //     firstLanguage,
      //   ),
      // );
    } on FirebaseException catch (e) {
      print("error registerWithEmailAndPassword");
      print(e.message);
      // ignore: use_rethrow_when_possible
      throw e;
    }
  }

  @override
  Future<String> addNewUserToFiresbase(UserModel userModel) async {
    try {
      return await _firebaseStore.addNewUserToFirestore(userModel);
    } on FirebaseException catch (e) {
      print("error addNewUserToFiresbase");
      print(e);
      rethrow;
    }
  }

  @override
  Future<String> loginWithEmailAndPassword(String email, String password) async {
    try {
      return await _firebaseAuthentication.loginWithEmailAndPassword(email, password);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<String> translateMsgToFriendLang(String friendLanguage, String myMessage) async {
    final url = Uri.parse(ApiConstance.baseUrl);
    final headers = {
      "Content-Type": ApiConstance.contentType,
      "Authorization": ApiConstance.apiKey,
    };
    final json = {
      "model": ApiConstance.apiModel,
      "messages": [
        {
          "role": "user",
          "content": "translate this message to $friendLanguage : '$myMessage'",
        },
      ],
      "temperature": 0.7
    };

    final Response response = await post(
      url,
      headers: headers,
      body: jsonEncode(json),
    );

    final statusCode = response.statusCode;
    if (statusCode == 200) {
      print("✅✅");
      // print(response.body);
      // print(jsonDecode(utf8.decode(response.bodyBytes)));
      return jsonDecode(utf8.decode(response.bodyBytes))["choices"][0]["message"]["content"];
    } else {
      throw ServerException(
        errorMessageModel: ErrorMessageModel.fromJson(jsonDecode(utf8.decode(response.bodyBytes))),
      );
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      List<UserModel> usersList = await _firebaseStore.getAllUsers();
      return usersList;
    } on FirebaseException catch (e) {
      print("Error getting all users: $e");
      rethrow;
    }
  }

  @override
  Future<void> sentMessageToUserFirebase(MessageModel message) async {
    try {
      _firebaseStore.sentMessageToUserFirebase(message);
    } on FirebaseException catch (e) {
      print("errro sentMessageToUserFirebase $e");
      rethrow;
    }
  }

  @override
  Future<void> sentTranslatedMsgToFriendFirebase(MessageModel translatedMsg) async {
    try {
      _firebaseStore.sentTranslatedMsgToFriendFirebase(translatedMsg);
    } on FirebaseException catch (e) {
      print("errro sentTranslatedMsgToFriendFirebase $e");
      rethrow;
    }
  }

  @override
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId) async {
    try {
      return await _firebaseStore.getMessagesByFriendId(myFriendId);
    } on FirebaseException {
      print("errro getMessagesByFriendId");
      rethrow;
    }
  }
}
