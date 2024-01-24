import 'dart:async';

import 'package:chat_translator/core/services/services_locator.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/usecase/get_stream_messages_usecase.dart';
import 'package:chat_translator/domain/usecase/get_typing_status.dart';
import 'package:chat_translator/domain/usecase/send_message_to_user_firebase_usecase.dart';
import 'package:chat_translator/domain/usecase/send_translated_msg_toFriend_firebase_usecase.dart';
import 'package:chat_translator/domain/usecase/translate_message_to_friend_lang_usecase.dart';
import 'package:chat_translator/domain/usecase/update_status_usecase.dart';
import 'package:chat_translator/presentation/screens/chat/cubit/chat_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(ChatInitialState());

  static ChatCubit get(context) => BlocProvider.of(context);

  // final GetMessagesByFriendIdUsecase _getMessagesByFriendIdUsecase = GetMessagesByFriendIdUsecase(getIt());
  final TranslateMessageToFriendLanguageUsecase _translateMessageToFriendLanguageUsecase =
      TranslateMessageToFriendLanguageUsecase(getIt());

  final SendMessagetoUserFirebaseUsecase _sendMessagetoUserFirebaseUsecase = SendMessagetoUserFirebaseUsecase(getIt());

  final SendTranslatedMessageToFirebaseUsecase _sendTranslatedMessageToFirebaseUsecase =
      SendTranslatedMessageToFirebaseUsecase(getIt());

  final GetStreamMessagesUseCase _getStreamMessagesUseCase = GetStreamMessagesUseCase(getIt());

  final GetTypingStatusUsecase _getTypingStatusUsecase = GetTypingStatusUsecase(getIt());

  final UpdatetypingStatusUsecase _updatetypingStatusUsecase = UpdatetypingStatusUsecase(getIt());

  String translatedMsg = '';

  TextEditingController messageController = TextEditingController();

  Stream<bool> getTypingStatus(String myFriendId, String myId) {
    return _getTypingStatusUsecase.execute(myFriendId, myId);
  }

  bool typingStatusBool = false;

  Future<void> updateTypingStatus(String myFriendId, String myId, bool typingStatus) async {
    if (typingStatus != typingStatusBool) {
      typingStatusBool = typingStatus;
      (await _updatetypingStatusUsecase.execute(myFriendId, myId, typingStatus)).fold(
        (failure) {
          print('error updateTypingStatus');
        },
        (data) {
          print('success updateTypingStatus');
        },
      );
    } else {}
  }

  // ScrollController scrollController = ScrollController();

  // scrollToEnd() {
  //   scrollController.animateTo(scrollController.position.maxScrollExtent,
  //       duration: const Duration(), curve: Curves.easeOut);
  //   // scrollController.position.maxScrollExtent(duration: const Duration(microseconds: 0), curve: Curves.easeOut);
  // }

  var testMessageList = [
    Message('textas;dlfja;lskdjfa;lksdjf;lakjsd;flkaj;sdlkfja;lskjdf; a;slkdjfa;lskdjf a;sldkfja;sldf a;sldkfj',
        DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hello how are you ', DateTime.now().toString(), '1', 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi my name is steve', DateTime.now().toString(), '', '1'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi my name is steve', DateTime.now().toString(), '1', 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2'),
    Message('hi my name is steve', DateTime.now().toString(), '1', 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi my name is steve', DateTime.now().toString(), '', 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi my name is steve', DateTime.now().toString(), '', '1'),
    Message('hi my name is steve', DateTime.now().toString(), ';', 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2'),
    Message('hi my name is steve', DateTime.now().toString(), 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2', '1'),
    Message('hi iam jude bellingham', DateTime.now().toString(), '1', 'Oqtn9qHzSDMHyG7ZCO4XjiOY3ZF2'),
  ].reversed.toList();

  // List<Message> messagesList = [];

  // void getMessages({
  //   required String reciverId,
  //   required String myId,
  // }) {
  //   FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(myId)
  //       .collection('chats')
  //       .doc(reciverId)
  //       .collection('messages')
  //       .orderBy('dateTime')
  //       .snapshots()
  //       .listen((event) {
  //     messagesList = [];
  //     for (var element in event.docs) {
  //       messagesList.add(MessageModel.fromJson(element.data()));
  //     }
  //     emit(ChatGetMessagesSuccessState());
  //     print('get message changes');
  //   });
  // }

  Stream<List<Message>> getMessagesStream({
    required String reciverId,
    required String myId,
  }) {
    return _getStreamMessagesUseCase.execute(reciverId, myId);
  }

  // void getStreamMessages(String friendId, String myId) async {
  //   emit(ChatGetStreamMessagesLoadingState());
  //   (await _getStreamMessagesUseCase.execute(friendId, myId)).fold(
  //     (failure) {
  //       emit(ChatGetStreamMessagesErrorState(failure.message));
  //     },
  //     (data) {
  //       messagesList = data;
  //     },
  //   );
  // }

  // void getMessages(String friendId, String myId) async {
  //   emit(ChatGetMessagesLoadingState());
  //   (await _getMessagesByFriendIdUsecase.execute(friendId, myId)).fold(
  //     (failure) {
  //       emit(ChatGetMessagesErrorState(failure.message));
  //     },
  //     (data) {
  //       messagesList = data;
  //       emit(ChatGetMessagesSuccessState());
  //     },
  //   );
  // }

  Future<void> sendUntranslatedMessage(String friendId, String myId) async {
    // emit(ChatSendMessagesLoadingState());
    (await _sendMessagetoUserFirebaseUsecase
            .execute(Message(messageController.text, DateTime.now().toString(), friendId, myId)))
        .fold(
      (failure) {
        emit(ChatSendMessagesErrorState(failure.message));
      },
      (data) {
        // emit(ChatSendMessagesSuccessState());
      },
    );
  }

  Future<void> translateMessage(String friendLanguage) async {
    // emit(ChatTranslateMessagesLoadingState());
    (await _translateMessageToFriendLanguageUsecase.execute(friendLanguage, messageController.text)).fold(
      (failure) {
        emit(ChatTranslateMessagesErrorState(failure.message));
      },
      (data) {
        translatedMsg = data;
        // emit(ChatTranslateMessagesSuccessState());
      },
    );
  }

  Future<void> sendTranslatedMessage(String friendId, String myId) async {
    // emit(ChatSendTranslatedMessagesLoadingState());
    (await _sendTranslatedMessageToFirebaseUsecase
            .execute(Message(translatedMsg, DateTime.now().toString(), friendId, myId)))
        .fold(
      (failure) {
        emit(ChatSendTranslatedMessagesErrorState(failure.message));
      },
      (data) {
        translatedMsg = '';
        // emit(ChatSendMessagesSuccessState());
      },
    );
  }

  void sendMessage(String friendId, String friendLanguage, String myId) async {
    if (messageController.text.isNotEmpty) {
      emit(ChatSendMessagesLoadingState());
      await translateMessage(friendLanguage);

      await sendUntranslatedMessage(friendId, myId);

      await sendTranslatedMessage(friendId, myId);
      messageController.clear();
      emit(ChatSendMessagesSuccessState());
    } else {}
  }

  String? extractTime(String inputString) {
    try {
      // Parse the string into a DateTime object
      DateTime dateTime = DateTime.parse(inputString);

      // Get the current date
      DateTime currentDate = DateTime.now();

      // Check if the date is today
      if (dateTime.year == currentDate.year && dateTime.month == currentDate.month && dateTime.day == currentDate.day) {
        // Format the DateTime to get the time part only
        return "${dateTime.hour}:${dateTime.minute}";
      } else {
        // Format the DateTime to include the date and time
        return "${dateTime.year}-${dateTime.month}-${dateTime.day}  ${dateTime.hour}:${dateTime.minute}";
      }
    } catch (e) {
      // Handle parsing errors or invalid input strings
      print("Error parsing the input string: $e");
      return null;
    }
  }
}
