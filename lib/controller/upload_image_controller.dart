import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class UploadImage {
  static Future<String> uploadImage(
      {required File image, required String path}) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef =
        storageRef.child('$path/${DateTime.now().millisecondsSinceEpoch}.jpg');

    await imageRef.putFile(image);
    String urlImage = await imageRef.getDownloadURL();
    return urlImage;
  }
}
