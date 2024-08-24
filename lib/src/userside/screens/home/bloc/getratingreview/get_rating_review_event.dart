part of 'get_rating_review_bloc.dart';

sealed class GetRatingReviewEvent extends Equatable {
  const GetRatingReviewEvent();

  @override
  List<Object> get props => [];
}
class FetchRatingData extends GetRatingReviewEvent {
  final String serviceName;
  const FetchRatingData(this.serviceName);
}

class DataFetched extends GetRatingReviewEvent {
  final List<DocumentSnapshot> data;
  const DataFetched(this.data);
  @override
  List<Object> get props => [data];
}
