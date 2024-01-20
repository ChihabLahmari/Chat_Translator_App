import 'package:chat_translator/core/utlis/constances.dart';
import 'package:chat_translator/data/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class FirebaseStore {
  Future<String> addNewUserToFirestore(CustomerModel userModel);
  Future<CustomerModel> getUserDataById(String id);
  Future<List<CustomerModel>> getAllUsers();
  Future<void> sentMessageToUserFirebase(MessageModel message);
  Future<void> sentTranslatedMsgToFriendFirebase(MessageModel translatedMsg);
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId, String myId);
}

class FirebaseStoreImpl implements FirebaseStore {
  final FirebaseFirestore _firebaseFirestore;

  FirebaseStoreImpl(this._firebaseFirestore);

  @override
  Future<String> addNewUserToFirestore(CustomerModel userModel) async {
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
  Future<CustomerModel> getUserDataById(String id) async {
    try {
      return await _firebaseFirestore.collection(FirebaseConstance.users).doc(id).get().then(
        (value) {
          print(value.data());
          return CustomerModel.fromJson(value.data()!);
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
  Future<List<CustomerModel>> getAllUsers() async {
    try {
      QuerySnapshot querySnapshot = await _firebaseFirestore.collection(FirebaseConstance.users).get();

      List<CustomerModel> usersList = [];

      for (var doc in querySnapshot.docs) {
        usersList.add(CustomerModel.fromJson(doc.data() as Map<String, dynamic>));
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
  Future<List<MessageModel>> getMessagesByFriendId(String myFriendId, String myId) async {
    try {
      List<MessageModel> messageList = [];
      QuerySnapshot querySnapshot = await _firebaseFirestore
          .collection(FirebaseConstance.users)
          .doc(myId)
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
