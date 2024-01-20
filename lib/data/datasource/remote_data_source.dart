import 'dart:convert';

import 'package:chat_translator/core/error/exceptions.dart';
import 'package:chat_translator/core/network/api_constance.dart';
import 'package:chat_translator/core/network/error_message_model.dart';
import 'package:chat_translator/data/models/models.dart';
import 'package:chat_translator/data/network/firebase_auth.dart';
import 'package:chat_translator/data/network/firebase_store.dart';
import 'package:http/http.dart';

abstract class RemoteDataSource {
  Future<String> registerWithEmailAndPassword(String email, String password);
  Future<String> addNewUserToFiresbase(CustomerModel userModel);
  Future<String> loginWithEmailAndPassword(String email, String password);
  Future<CustomerModel> getUserDataById(String id);
  Future<List<CustomerModel>> getAllUsers();
  Future<String> translateMsgToFriendLang(String friendLanguage, String myMessage);
  Future<void> sentMessageToUserFirebase(MessageModel message);
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId, String myId);
  Future<void> sentTranslatedMsgToFriendFirebase(MessageModel translatedMsg);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseAuthentication _firebaseAuthentication;
  final FirebaseStore _firebaseStore;

  RemoteDataSourceImpl(this._firebaseAuthentication, this._firebaseStore);
  @override
  Future<String> registerWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuthentication.registerWithEmailAndPassword(email, password);
  }

  @override
  Future<String> addNewUserToFiresbase(CustomerModel userModel) async {
    return await _firebaseStore.addNewUserToFirestore(userModel);
  }

  @override
  Future<String> loginWithEmailAndPassword(String email, String password) async {
    return await _firebaseAuthentication.loginWithEmailAndPassword(email, password);
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
  Future<List<CustomerModel>> getAllUsers() async {
    List<CustomerModel> usersList = await _firebaseStore.getAllUsers();
    return usersList;
  }

  @override
  Future<void> sentMessageToUserFirebase(MessageModel message) async {
    await _firebaseStore.sentMessageToUserFirebase(message);
  }

  @override
  Future<void> sentTranslatedMsgToFriendFirebase(MessageModel translatedMsg) async {
    await _firebaseStore.sentTranslatedMsgToFriendFirebase(translatedMsg);
  }

  @override
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId, String myId) async {
    return await _firebaseStore.getMessagesByFriendId(myFriendId, myId);
  }

  @override
  Future<CustomerModel> getUserDataById(String id) async {
    return await _firebaseStore.getUserDataById(id);
  }
}
