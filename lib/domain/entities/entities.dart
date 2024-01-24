class Customer {
  String fullName;
  String image;
  String id;
  String email;
  String firstLanguage;
  bool isUserOnline;

  Customer(
    this.fullName,
    this.image,
    this.id,
    this.email,
    this.firstLanguage,
    this.isUserOnline,
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
