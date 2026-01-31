import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageProvider {
  Future initialize(FirebaseApp firebaseApp) async {
    FirebaseStorage.instanceFor(app: firebaseApp);
  }

  Future<String> _uploadPicture(String path, Uri uri) async {
    final response =
        await FirebaseStorage.instance.ref(path).putFile(File(uri.path));
    return await response.ref.getDownloadURL();
  }

  Future _deletePicture(String path) async {
    await FirebaseStorage.instance.ref(path).delete();
  }

  Future<String> uploadProfilePicture(String userId, Uri uri) async {
    final path = "$userId/${uri.pathSegments.last}";
    return _uploadPicture(path, uri);
  }

  Future deleteProfilePicture(String userId) async {
    //await FirebaseStorage.instance.ref("$userId").delete();
  }

  Future<String> uploadGroupPicture(String groupId, Uri uri) {
    final path = "$groupId/${uri.pathSegments.last}";
    return _uploadPicture(path, uri);
  }
}
