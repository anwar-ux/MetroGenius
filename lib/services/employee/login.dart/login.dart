import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginEmployee {
  static Future<bool> loginEmployee(String email, String employeeCode) async {
    try {
      QuerySnapshot querySnapshot =
          await FirebaseFirestore.instance.collection('Workers').where('Email', isEqualTo: email).where('EmployeeCode', isEqualTo: employeeCode).get();

      if (querySnapshot.docs.isNotEmpty) {
        final dynamic documentId = querySnapshot.docs.first.id;
        
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('employeeId', documentId);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error logging in: $e');
      return false;
    }
  }
}
