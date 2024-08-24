part of 'get_rating_review_bloc.dart';

sealed class GetRatingReviewState extends Equatable {
  const GetRatingReviewState();
  
  @override
  List<Object> get props => [];
}

final class GetRatingInitial extends GetRatingReviewState {}

final class GetRatingLoading extends GetRatingReviewState {}

final class GetRatingLoaded extends GetRatingReviewState {
  final List<DocumentSnapshot> data;
 const GetRatingLoaded(this.data);
}

final class GetRatingFailed extends GetRatingReviewState {
   final String errorMsg;

  const GetRatingFailed(this.errorMsg);
}
