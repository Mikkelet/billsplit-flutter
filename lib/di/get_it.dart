

import 'package:billsplit_flutter/data/auth/auth_provider.dart';
import 'package:billsplit_flutter/data/local/database/splitsby_db.dart';
import 'package:billsplit_flutter/data/remote/api_service.dart';
import 'package:billsplit_flutter/data/remote/network_client.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup(){

  // Data
  getIt.registerSingleton<SplitsbyDatabase>(SplitsbyDatabase());
  getIt.registerSingleton<AuthProvider>(AuthProvider());
  getIt.registerSingleton<NetworkClient>(NetworkClient());
  getIt.registerSingleton<ApiService>(ApiService(getIt<NetworkClient>()));

  // usecases


}