part of 'rating_and_review_bloc.dart';

enum RatingFormStatus { initial, pending, success, error }

@immutable
class RatingAndReviewState {
  const RatingAndReviewState({
    this.serviceName = '',
    this.rating = 0,
    this.review = '',
    this.status = RatingFormStatus.initial,
    this.errorMsg,
  });

  final String serviceName;
  final double rating;
  final String review;
  final RatingFormStatus status;
  final String? errorMsg;

  RatingAndReviewState copyWith({
    String? serviceName,
    double? rating,
    String? review,
    RatingFormStatus? status,
    String? errorMsg,
  }) {
    return RatingAndReviewState(
      serviceName: serviceName ?? this.serviceName,
      rating: rating ?? this.rating,
      review: review ?? this.review,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  factory RatingAndReviewState.initial() {
    return const RatingAndReviewState();
  }
}
