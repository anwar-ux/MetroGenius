import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  static Future<bool> addUserDetails(userInfo, userId) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(userId).update(userInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Map<String, dynamic> userInfo({
    required String name,
    required String image,
    
  }) {
    Map<String, dynamic> addressInfo = {
      'Name': name,
      'Image': image,
     
    };
    return addressInfo;
  }
static Stream<DocumentSnapshot<Object?>> getUserDetails(String? userId) {
  return FirebaseFirestore.instance.collection('users').doc(userId).snapshots();
}

}
