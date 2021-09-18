import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';

import 'firebase_api.dart';

@injectable
class StorageRepository {
  static Future<String> uploadFile(String userId, File file) async {
    if (file == null) return null;

    final fileName = basename(file.path);
    print('filename $fileName');
    final destination = '$userId/$fileName';
    final UploadTask task = FirebaseApi.uploadFile(destination, file);

    if (task == null) return null;

    final snapshot = await task.whenComplete(() => {});
    final imageUrl = await snapshot.ref.getDownloadURL();
    print('file url $imageUrl');
    return imageUrl;
  }
}
