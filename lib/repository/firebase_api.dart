import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask uploadFile(String destination, File file) {
    try {
      final reference = FirebaseStorage.instance.ref(destination);
      return reference.putFile(file);
    } catch (e, s) {
      throw FirebaseStorageException(e.toString());
    }
  }
}

class FirebaseStorageException implements Exception {
  final String message;

  FirebaseStorageException(this.message);
}
