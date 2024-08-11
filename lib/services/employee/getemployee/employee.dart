import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmployeeService {
  static Future<DocumentSnapshot?> getWorkerData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? employeeId = prefs.getString('employeeId');

      if (employeeId != null) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('Workers').doc(employeeId).get();

        if (documentSnapshot.exists) {
          return documentSnapshot;
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<void> employeeLogout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  static Future<Stream<QuerySnapshot>> getRequestes() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('employeeId');
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('Workers').doc(id).get();
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
    final workType = data['Work'];
    print(workType);
    return FirebaseFirestore.instance.collectionGroup('requestedServices').where('WorkType', isEqualTo: workType).snapshots();
  }
}
