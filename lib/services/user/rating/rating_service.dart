import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RatingService {
  static Future<bool> addRatingReview(Map<String, dynamic> ratingInfo) async {
    try {
     
      await FirebaseFirestore.instance.collection('RatingReviews').doc().set(ratingInfo);

      
      final snapshot = await FirebaseFirestore.instance.collection('RatingReviews').where('ServiceName', isEqualTo: ratingInfo['ServiceName']).get();

      final ratings = snapshot.docs.map((doc) => doc['Rating'] as double).toList();

      if (ratings.isNotEmpty) {
        final averageRating = ratings.reduce((a, b) => a + b) / ratings.length;

        final subcategorySnapshot = await FirebaseFirestore.instance.collectionGroup('subcategories').where('Name', isEqualTo: ratingInfo['ServiceName']).get();

        for (var doc in subcategorySnapshot.docs) {
          await FirebaseFirestore.instance.collection(doc.reference.parent.path).doc(doc.id).update({'Rating': averageRating});
        }

        debugPrint('SubCategory rating updated successfully');
      } else {
        debugPrint('No ratings found for this service');
      }

      return true;
    } catch (e) {
      debugPrint('Error adding rating and updating subcategory: $e');
      return false;
    }
  }

  static Map<String, dynamic> ratingReviewInfo({
    required String userId,
    required String review,
    required String serviceName,
    required double rating,
  }) {
    Map<String, dynamic> addressInfo = {'UserID': userId, 'Review': review, 'ServiceName': serviceName, 'Rating': rating};
    return addressInfo;
  }

  static Stream<QuerySnapshot<Object?>> getRatingDetails(String serviceName) {
    return FirebaseFirestore.instance.collection('RatingReviews').where('ServiceName', isEqualTo: serviceName).snapshots();
  }
}
