abstract class ChatStates {}

class ChatInitialState extends ChatStates {}

class ChatGetStreamMessagesLoadingState extends ChatStates {}

class ChatGetStreamMessagesSuccessState extends ChatStates {}

class ChatGetStreamMessagesErrorState extends ChatStates {
  final String error;

  ChatGetStreamMessagesErrorState(this.error);
}

class ChatGetMessagesLoadingState extends ChatStates {}

class ChatGetMessagesSuccessState extends ChatStates {}

class ChatGetMessagesErrorState extends ChatStates {
  final String error;

  ChatGetMessagesErrorState(this.error);
}

class ChatSendMessagesLoadingState extends ChatStates {}

class ChatSendMessagesSuccessState extends ChatStates {}

class ChatSendMessagesErrorState extends ChatStates {
  final String error;

  ChatSendMessagesErrorState(this.error);
}

class ChatTranslateMessagesLoadingState extends ChatStates {}

class ChatTranslateMessagesSuccessState extends ChatStates {}

class ChatTranslateMessagesErrorState extends ChatStates {
  final String error;

  ChatTranslateMessagesErrorState(this.error);
}

class ChatSendTranslatedMessagesLoadingState extends ChatStates {}

class ChatSendTranslatedMessagesSuccessState extends ChatStates {}

class ChatSendTranslatedMessagesErrorState extends ChatStates {
  final String error;

  ChatSendTranslatedMessagesErrorState(this.error);
}
