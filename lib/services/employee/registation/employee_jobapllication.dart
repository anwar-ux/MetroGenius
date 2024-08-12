import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeJobapllication {
  Future<bool> addEmployeeApplication(employeeApplicationInfo,id) async {
    try {
     
      await FirebaseFirestore.instance
          .collection("EmployeeApplications")
          .doc(id)
          .set(employeeApplicationInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  Map<String, dynamic> employeeApplicationInfo({
    required String id,
    required String email,
    required String name,
    required int phone,
    required String iDproof,
    required int experience,
    required String work,
    required String image,
  }) {
    Map<String, dynamic> employeeAplicationInfo = {
      'Id':id,
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
