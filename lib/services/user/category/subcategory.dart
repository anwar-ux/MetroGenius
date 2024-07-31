import 'package:cloud_firestore/cloud_firestore.dart';

class Subcategory {
  static Future<Stream<QuerySnapshot>> getSubcategories(String categoryId) async {
    return FirebaseFirestore.instance.collection("Categorys").doc(categoryId).collection("subcategories").snapshots();
  }
}
