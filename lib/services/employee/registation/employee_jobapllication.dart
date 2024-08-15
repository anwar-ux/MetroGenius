import 'package:cloud_firestore/cloud_firestore.dart';

class EmployeeJobapllication {
  Future<bool> addEmployeeApplication(Map<String, dynamic> employeeApplicationInfo, String id) async {
  try {
    final workerEmailQuery = await FirebaseFirestore.instance
        .collection('Workers')
        .where('Email', isEqualTo: employeeApplicationInfo['Email'])
        .get();
    
    final applicantEmailQuery = await FirebaseFirestore.instance
        .collection('EmployeeApplications')
        .where('Email', isEqualTo: employeeApplicationInfo['Email'])
        .get();
        final savedEmailQuery = await FirebaseFirestore.instance
        .collection('EmployeeUsedMails')
        .where('Email', isEqualTo: employeeApplicationInfo['Email'])
        .get();

    if (workerEmailQuery.docs.isEmpty && applicantEmailQuery.docs.isEmpty&&savedEmailQuery.docs.isEmpty) {
      await FirebaseFirestore.instance
          .collection("EmployeeApplications")
          .doc(id)
          .set(employeeApplicationInfo);
      return true;
    } else {
      return false;
    }
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
      'Id': id,
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
