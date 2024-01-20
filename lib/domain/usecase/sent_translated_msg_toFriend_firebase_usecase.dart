import 'package:chat_translator/core/error/failure.dart';
import 'package:chat_translator/domain/entities/entities.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:dartz/dartz.dart';

class SentTranslatedMessageToFirebaseUsecase {
  final Repository _repository;

  SentTranslatedMessageToFirebaseUsecase(this._repository);

  Future<Either<Failure, void>> execute(Message translatedMsg) async {
    return await _repository.sentTranslatedMsgToFriendFirebase(translatedMsg);
  }
}
