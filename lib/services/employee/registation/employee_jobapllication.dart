import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:random_string/random_string.dart';

class EmployeeJobapllication {
  Future<bool> addEmployeeAplication(employeeAplicationInfo) async {
    try {
      final id = randomAlphaNumeric(6);
      await FirebaseFirestore.instance
          .collection("EmployeeAplications")
          .doc(id.toString())
          .set(employeeAplicationInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> employeeAplicationInfo({
    required String email,
    required String name,
    required int phone,
    required String iDproof,
    required int experience,
    required String work,
    required String image,
  }) {
    Map<String, dynamic> employeeAplicationInfo = {
      'Email': email,
      'Name': name,
      'Phone': phone,
      'IDproof': iDproof,
      'Experience': experience,
      'Work': work,
      'Image': image,
    };
    return employeeAplicationInfo;
  }
}
