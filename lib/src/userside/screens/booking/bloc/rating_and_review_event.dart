part of 'rating_and_review_bloc.dart';

abstract class RatingAndReviewEvent extends Equatable {
  const RatingAndReviewEvent();

  @override
  List<Object?> get props => [];
}

class ServiceNameChanged extends RatingAndReviewEvent {
  final String serviceName;

  const ServiceNameChanged({
    required this.serviceName,
  });

  @override
  List<Object?> get props => [serviceName];
}

class RatingChanged extends RatingAndReviewEvent {
  final double rating;

  const RatingChanged({
    required this.rating,
  });

  @override
  List<Object?> get props => [rating];
}
class ReviewChanged extends RatingAndReviewEvent {
  final String review;

  const ReviewChanged({
    required this.review,
  });

  @override
  List<Object?> get props => [review];
}
class SubmitRating extends RatingAndReviewEvent{}