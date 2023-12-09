import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class TranslateMessageToFriendLanguageUsecase {
  final Repository _repository;

  TranslateMessageToFriendLanguageUsecase(this._repository);

  Future<Either<Failure, String>> execute(String friendLang, String message) async {
    return await _repository.translateMsgToFriendLang(friendLang, message);
  }
}
