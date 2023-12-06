class User {
  String fullName;
  String image;
  String id;
  String email;
  String firstLanguage;

  User(
    this.fullName,
    this.image,
    this.id,
    this.email,
    this.firstLanguage,
  );
}

class Message {
  String text;
  String dateTime;
  String receiverId;
  String senderId;

  Message(
    this.text,
    this.dateTime,
    this.receiverId,
    this.senderId,
  );
}
