import 'package:chat_translator/data/datasource/remote_data_source.dart';
import 'package:chat_translator/data/network/firebase_auth.dart';
import 'package:chat_translator/data/network/firebase_store.dart';
import 'package:chat_translator/data/network/network_info.dart';
import 'package:chat_translator/data/repository/repositoryImpl.dart';
import 'package:chat_translator/domain/repository/repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  void init() {
    //network info
    getIt.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(InternetConnectionChecker()));

    // Firebase auth
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    getIt.registerLazySingleton<FirebaseAuthentication>(() => FirebaseAuthenticationImpl(firebaseAuth));

    // Firebase FireStore
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    getIt.registerLazySingleton<FirebaseStore>(() => FirebaseStoreImpl(firebaseFirestore));

    // Remote Data Source
    getIt.registerLazySingleton<RemoteDataSource>(
      () => RemoteDataSourceImpl(getIt<FirebaseAuthentication>(), getIt<FirebaseStore>()),
    );

    // Repository
    getIt.registerLazySingleton<Repository>(() => RepositoryImpl(getIt<RemoteDataSource>(), getIt<NetworkInfo>()));
  }
}
