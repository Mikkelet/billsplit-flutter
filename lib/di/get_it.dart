

import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/firebase/firebase.dart';
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:billsplit_flutter/data/remote/storage/storage_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup(){

  // Data
  getIt.registerSingleton<FirebaseProvider>(FirebaseProvider());
  getIt.registerSingleton<SplitsbyDatabase>(SplitsbyDatabase());
  getIt.registerSingleton<AuthProvider>(AuthProvider());
  getIt.registerSingleton<FirebaseStorageProvider>(FirebaseStorageProvider());
  getIt.registerSingleton<NetworkClient>(NetworkClient());
  getIt.registerSingleton<ApiService>(ApiService(getIt<NetworkClient>()));

  // usecases


}