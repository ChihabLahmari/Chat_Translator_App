import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // RemoteDataSourceImpl remoteDataSourceImpl = RemoteDataSourceImpl(
  //     FirebaseAuthenticationImpl(FirebaseAuth.instance), FirebaseStoreImpl(FirebaseFirestore.instance));

  // List<MessageModel> list = await remoteDataSourceImpl.getMessagesByFriendId("a;sldkjfa;lskdjfa;ls");
  // print(list.first.toJson());
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Text('Hello World!'),
        ),
      ),
    );
  }
}
