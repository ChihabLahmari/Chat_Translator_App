import 'package:chat_translator/domain/entities/user.dart';

class CustomerModel extends Customer {
  CustomerModel(
    super.fullName,
    super.image,
    super.id,
    super.email,
    super.firstLanguage,
  );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      json['fullName'],
      json['image'],
      json['id'],
      json['email'],
      json['firstLanguage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "fullName": fullName,
      "image": image,
      "id": id,
      "email": email,
      "firstLanguage": firstLanguage,
    };
  }
}

class MessageModel extends Message {
  MessageModel(
    super.text,
    super.dateTime,
    super.receiverId,
    super.senderId,
  );

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      json['text'],
      json['dateTime'],
      json['receiverId'],
      json['senderId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "text": text,
      "dateTime": dateTime,
      "receiverId": receiverId,
      "senderId": senderId,
    };
  }
}
