import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/servicebooking/service_booking_bloc.dart';
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

  static Stream<QuerySnapshot> getRequestes() {
    return SharedPreferences.getInstance().asStream().asyncExpand((prefs) async* {
      final id = prefs.getString('employeeId');
      if (id != null) {
        DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('Workers').doc(id).get();
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        final workType = data['Work'];

        yield* FirebaseFirestore.instance
            .collectionGroup('requestedServices')
            .where('WorkType', isEqualTo: workType)
            .where('RequestStatus', isEqualTo: RequestStatus.pending.toString())
            .snapshots();
      } else {
        yield* Stream<QuerySnapshot>.empty(); // return an empty stream if employeeId is null
      }
    });
  }

  static Stream<QuerySnapshot> getCommitedRequestes() async* {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('employeeId');
    if (id != null) {
      yield* FirebaseFirestore.instance
          .collectionGroup('requestedServices')
          .where('WorkerId', isEqualTo: id)
          .where('RequestStatus', isEqualTo: RequestStatus.accepted.toString())
          .snapshots();
    } else {
      yield* const Stream<QuerySnapshot>.empty();
    }
  }

  static Stream<QuerySnapshot> getCompletedRequestes() async* {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('employeeId');

    if (id != null) {
      yield* FirebaseFirestore.instance
          .collectionGroup('requestedServices')
          .where('WorkerId', isEqualTo: id)
          .where('RequestStatus', isEqualTo: RequestStatus.completed.toString())
          .snapshots();
    } else {
      yield* const Stream<QuerySnapshot>.empty();
    }
  }

  static Future<bool> onAccept({required String id}) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final workerId = prefs.getString('employeeId');
      FirebaseFirestore.instance.collectionGroup('requestedServices').where('Id', isEqualTo: id).get().then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          document.reference.update({'RequestStatus': RequestStatus.accepted.toString(), 'WorkerId': workerId});
          return true;
        }
      });
    } catch (e) {
      return false;
    }
    return false;
  }

  static Future<bool> onComplete({required String id}) async {
    try {
      FirebaseFirestore.instance.collectionGroup('requestedServices').where('Id', isEqualTo: id).get().then((querySnapshot) {
        for (var document in querySnapshot.docs) {
          document.reference.update({
            'RequestStatus': RequestStatus.completed.toString(),
          });
          return true;
        }
      });
    } catch (e) {
      return false;
    }
    return false;
  }
}
