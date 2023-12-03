import 'package:chat_translator/domain/entities/user.dart';

class UserModel extends User {
  UserModel(
    super.fullName,
    super.image,
    super.firstLanguage,
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      json['fullName'],
      json['image'],
      json['firstLanguage'],
    );
  }
}

class MessageModel extends Message {
  MessageModel(
    super.text,
    super.date,
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      json['text'],
      json['date'],
    );
  }
}
