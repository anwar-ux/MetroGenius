import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart' as path;


class ImageConvertion{

static Future<String?> uploadImageToFirebase(File imageFile) async {
  try {
    String fileName = path.basename(imageFile.path);
    Reference firebaseStorageRef = FirebaseStorage.instance.ref().child('uploads/$fileName');

    UploadTask uploadTask = firebaseStorageRef.putFile(imageFile);

    // Listen for upload progress
    uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
      print('Upload is ${snapshot.bytesTransferred}/${snapshot.totalBytes} (${(snapshot.bytesTransferred / snapshot.totalBytes * 100).toStringAsFixed(0)}%)');
    });

    TaskSnapshot taskSnapshot = await uploadTask;

    String downloadURL = await taskSnapshot.ref.getDownloadURL();
    return downloadURL;
  } catch (e) {
    print('Error uploading image: $e');
    return null;
  }
}
static Uint8List convertStringToBytes(String input) {
  List<int> utf8List = utf8.encode(input);
  return Uint8List.fromList(utf8List);
} 
}