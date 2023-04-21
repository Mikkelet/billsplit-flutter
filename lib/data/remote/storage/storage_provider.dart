import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

class FirebaseStorageProvider {
  final _emulatorHost =
      (!kIsWeb && defaultTargetPlatform == TargetPlatform.android)
          ? '10.0.2.2'
          : 'localhost';

  Future initialize(FirebaseApp firebaseApp) async {
    FirebaseStorage.instanceFor(app: firebaseApp);
  }

  Future<String> uploadPhoto(String userId, Uri uri) async {
    final response = await FirebaseStorage.instance
        .ref("$userId/${uri.pathSegments.last}")
        .putFile(File(uri.path));
    return await response.ref.getDownloadURL();
  }
}
