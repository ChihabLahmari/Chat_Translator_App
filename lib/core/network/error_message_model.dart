class ErrorMessageModel {
  final String message;
  final String messageType;

  ErrorMessageModel({
    required this.message,
    required this.messageType,
  });

  factory ErrorMessageModel.fromJson(Map<String, dynamic> json) {
    return ErrorMessageModel(
      message: json["error"]["message"],
      messageType: json["error"]["type"],
    );
  }
}
