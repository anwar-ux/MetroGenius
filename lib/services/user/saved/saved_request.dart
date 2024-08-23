import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedService {
  static Future<bool> addToSave(serviceInfo, userId, addressId) async {
    try {
      DocumentReference categoryDoc = FirebaseFirestore.instance.collection('users').doc(userId);
      await categoryDoc.collection('SavedServices').doc(addressId).set(serviceInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Map<String, dynamic> saveServiceInfo({
    required String id,
    required String name,
    required String image,
    required String discription,
    required int price,
    required Map<String, dynamic> checkboxes,
  }) {
    Map<String, dynamic> employeeAplicationInfo = {
      'Id': id,
      'Name': name,
      'Image': image,
      'Discription': discription,
      'Price': price,
      'Checkboxes': checkboxes,
    };
    return employeeAplicationInfo;
  }

  static Stream<QuerySnapshot> getSavedServices(String userId) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .collection('SavedServices')
        .snapshots();
}

  static Future<bool> isServiceSaved(String serviceId) async {

    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    final savedServiceDoc = await FirebaseFirestore.instance.collection('users').doc(userId).collection('SavedServices').doc(serviceId).get();

    return savedServiceDoc.exists;
  }

  static Future<void> removeFromSaved(String docId) async {

    final prefs = await SharedPreferences.getInstance();  
    final userId = prefs.getString('userId');

    await FirebaseFirestore.instance.collection('users').doc(userId).collection('SavedServices').doc(docId).delete();

  }
}
