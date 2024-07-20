import 'package:cloud_firestore/cloud_firestore.dart';

class GetApplications {
  Future<Stream<QuerySnapshot>> getEmployeeApplicatons() async {
   return  FirebaseFirestore.instance
        .collection("EmployeeAplications")
        .snapshots();
  }
}
