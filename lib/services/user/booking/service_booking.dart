import 'package:cloud_firestore/cloud_firestore.dart';

class ServiceBooking {
  static Future<bool> submitServiceRequest(userId, requestInfo,requestId) async {
    try {
      DocumentReference categoryDoc = FirebaseFirestore.instance.collection('users').doc(userId);
      await categoryDoc.collection('requestedServices').doc(requestId).set(requestInfo);
      return true;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  static Map<String, dynamic> requestInfo({
    required String userId,
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
      'Discription': discription,
      'CreatAt': FieldValue.serverTimestamp()
    };
    return addressInfo;
  }
}
