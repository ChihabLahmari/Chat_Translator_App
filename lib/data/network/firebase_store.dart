import 'package:chat_translator/core/constances.dart';
import 'package:chat_translator/data/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseStore {
  Future<String> addNewUserToFirestore(UserModel userModel);
  Future<UserModel> getUserDataById(String id);
  Future<List<UserModel>> getAllUsers();
  Future<void> sentMessageToUserFirebase(MessageModel message);
  Future<void> sentTranslatedMsgToFriendFirebase(MessageModel translatedMsg);
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId);
}

class FirebaseStoreImpl implements FirebaseStore {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseStoreImpl(this._firebaseFirestore);

  @override
  Future<String> addNewUserToFirestore(UserModel userModel) async {
    try {
      await _firebaseFirestore.collection(FirebaseConstance.users).doc(userModel.id).set(
            userModel.toJson(),
          );
      return userModel.id;
    } on FirebaseException catch (e) {
      print("🛑 error addNewUserToFirestore");
      print(e.message);
      rethrow;
    }
  }

  @override
  Future<UserModel> getUserDataById(String id) async {
    try {
      return await _firebaseFirestore.collection(FirebaseConstance.users).doc(id).get().then(
        (value) {
          print(value.data());
          return UserModel.fromJson(value.data()!);
        },
      ).catchError((onError) {
        print("🫣🫣");
        print(onError.toString());
        throw onError;
      });
    } on FirebaseException {
      print("🫣");

      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection(FirebaseConstance.users).get();

      List<UserModel> usersList = [];

      for (var doc in querySnapshot.docs) {
        usersList.add(UserModel.fromJson(doc.data() as Map<String, dynamic>));
      }

      return usersList;
    } on FirebaseException catch (e) {
      print("Error getting all users: $e");
      rethrow;
    }
  }

  @override
  Future<void> sentMessageToUserFirebase(MessageModel message) async {
    try {
      _firebaseFirestore
          .collection(FirebaseConstance.users)
          .doc(message.senderId)
          .collection(FirebaseConstance.chats)
          .doc(message.receiverId)
          .collection(FirebaseConstance.messages)
          .add(message.toJson());
      print("sent message succes");
    } on FirebaseException catch (e) {
      print("error sentMessageToUserFirebase $e");
      rethrow;
    }
  }

  @override
  Future<void> sentTranslatedMsgToFriendFirebase(MessageModel translatedMsg) async {
    try {
      _firebaseFirestore
          .collection(FirebaseConstance.users)
          .doc(translatedMsg.receiverId)
          .collection(FirebaseConstance.chats)
          .doc(translatedMsg.senderId)
          .collection(FirebaseConstance.messages)
          .add(translatedMsg.toJson());
      print("sentTranslatedMsgToFriendFirebase");
    } on FirebaseException catch (e) {
      print("error sentTranslatedMsgToFriendFirebase $e");
      rethrow;
    }
  }

  @override
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId) async {
    try {
      List<MessageModel> messageList = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection(FirebaseConstance.users)
          //TODO: change this :: line to the user id that stored in the local storage
          .doc("ulndN50HslQ1TcUEEXwqukI1e1d2")
          .collection(FirebaseConstance.chats)
          .doc(myFriendId)
          .collection(FirebaseConstance.messages)
          .get();

      for (var doc in querySnapshot.docs) {
        messageList.add(MessageModel.fromJson(doc.data() as Map<String, dynamic>));
      }
      print("getMessagesByFriendId");

      return messageList;
    } on FirebaseException {
      print("error getMessagesByFriendId");
      rethrow;
    }
  }
}
