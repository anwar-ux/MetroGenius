import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/servicebooking/service_booking_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ServiceBooking {
  static Future<bool> submitServiceRequest(userId, requestInfo,requestId) async {
    try {
      DocumentReference categoryDoc = FirebaseFirestore.instance.collection('users').doc(userId);
      await categoryDoc.collection('requestedServices').doc(requestId).set(requestInfo);
      return true;
    } catch (e) {
      return false;
    }
  }

  static Map<String, dynamic> requestInfo({
    required String userId,
    required String userName,
    required String workType,
    required String id,
    required String address,
    required String dateTime,
    required String serviceTitle,
    required int totalPrice,
    required int discountPrice,
    required String workerId,
    required String requestStatus,
    required String discription,
    required String paymentType,
  }) {
    Map<String, dynamic> addressInfo = {
      'Id': id,
      'WorkType':workType,
      'UserID': userId,
      'Address': address,
      'DateTime': dateTime,
      'ServiceTitle': serviceTitle,
      'TotalPrice': totalPrice,
      'DiscountPrice': discountPrice,
      'WorkerId': workerId,
      'RequestStatus': requestStatus,
      'UserName':userName,
      'Discription': discription,
      'PaymetType':paymentType,
      'CreatAt': FieldValue.serverTimestamp()
    };
    return addressInfo;
  }
 static Stream<QuerySnapshot> getPendingRequests() async* {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getString('userId');

  if (id != null) {
    yield* FirebaseFirestore.instance
        .collection('users').doc(id).collection('requestedServices')
        .where('RequestStatus', whereIn: [
          RequestStatus.pending.toString(),
          RequestStatus.accepted.toString()
        ])
        .snapshots();
  } else {
    yield* const Stream<QuerySnapshot>.empty();
  }
}

  static Stream<QuerySnapshot> getCompletedRequestes() async* {
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('userId');

    if (id != null) {
      yield* FirebaseFirestore.instance
          .collection('users').doc(id).collection('requestedServices')
          .where('RequestStatus', isEqualTo: RequestStatus.completed.toString())
          .snapshots();
    } else {
      yield* const Stream<QuerySnapshot>.empty();
    }
  }

}
