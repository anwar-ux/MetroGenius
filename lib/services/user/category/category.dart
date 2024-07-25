import 'package:cloud_firestore/cloud_firestore.dart';

class Category{
  static Future<Stream<QuerySnapshot>> getCategorys() async {
    return FirebaseFirestore.instance
        .collection("Categorys")
        .snapshots();
  }
}