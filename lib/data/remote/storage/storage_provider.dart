import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageProvider {
  Future initialize(FirebaseApp firebaseApp) async {
    FirebaseStorage.instanceFor(app: firebaseApp);
  }

  Future<String> uploadPhoto(String userId, Uri uri) async {
    final response = await FirebaseStorage.instance
        .ref("$userId/${uri.pathSegments.last}")
        .putFile(File(uri.path));
    return await response.ref.getDownloadURL();
  }

  Future deleteProfilePicture(String userId) async {
    //await FirebaseStorage.instance.ref("$userId").delete();
  }
}
