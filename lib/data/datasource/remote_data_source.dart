import 'dart:convert';

import 'package:chat_translator/core/error/exceptions.dart';
import 'package:chat_translator/core/network/api_constance.dart';
import 'package:chat_translator/core/network/error_message_model.dart';
import 'package:chat_translator/data/models/user_model.dart';
import 'package:http/http.dart';

abstract class RemoteDataSource {
  Future<String> translateMsgToFriendLang(String friendLanguage, String myMessage);
  Future<List<UserModel>> getAllUsers();
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId);
  void sentTranslatedMsgToFriendFirebase(String translatedMsg);
  void sentMessageToUserFirebase(String message);
}

class RemoteDataSourceImpl implements RemoteDataSource {
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
  Future<List<UserModel>> getAllUsers() {
    // TODO: implement getAllUsers
    throw UnimplementedError();
  }

  @override
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId) {
    // TODO: implement getMessagesByFriendId
    throw UnimplementedError();
  }

  @override
  void sentMessageToUserFirebase(String message) {
    // TODO: implement sentMessageToUserFirebase
  }

  @override
  void sentTranslatedMsgToFriendFirebase(String translatedMsg) {
    // TODO: implement sentTranslatedMsgToFriendFirebase
  }
}
