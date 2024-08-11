import 'package:cloud_firestore/cloud_firestore.dart';

class Address {
  static Future<bool> addAddress(addressInfo,userId,addressId) async {
    try {
      DocumentReference categoryDoc = FirebaseFirestore.instance.collection('users').doc(userId);
      await categoryDoc.collection('addresses').doc(addressId).set(addressInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Map<String, dynamic> addressInfo({
    required String id,
    required String city,
    required String name,
    required int phone,
    required String houseflatno,
    required int pincode,
    required String area,
  }) {
    Map<String, dynamic> addressInfo = {
      'Id': id,
      'City': city,
      'Name': name,
      'Phone': phone,
      'HouseOrFlatNo': houseflatno,
      'Pincode': pincode,
      'Area': area,
    };
    return addressInfo;
  }

  static Future<Stream<QuerySnapshot>> getAddress(String? userId) async {
  
    return FirebaseFirestore.instance.collection('users').doc(userId).collection('addresses').snapshots();
  }
}
