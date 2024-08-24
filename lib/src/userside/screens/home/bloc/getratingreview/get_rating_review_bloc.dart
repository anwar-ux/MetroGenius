import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusorg/services/user/rating/rating_service.dart';
part 'get_rating_review_event.dart';
part 'get_rating_review_state.dart';

class GetRatingReviewBloc extends Bloc<GetRatingReviewEvent, GetRatingReviewState> {
  GetRatingReviewBloc() : super(GetRatingInitial()) {
     on<FetchRatingData>(_fetchSubCategoryData);
    on<DataFetched>(_dataFetched);
  }

 void _fetchSubCategoryData(FetchRatingData event, Emitter<GetRatingReviewState> emit) async {
  emit(GetRatingLoading());
  try {
    Stream<QuerySnapshot> dataStream =  RatingService.getRatingDetails(event.serviceName);
    await emit.forEach<QuerySnapshot>(
      dataStream,
      onData: (snapshot) {
        final data = snapshot.docs;
        return GetRatingLoaded(data);
      },
      onError: (error, stackTrace) {
        return GetRatingFailed(error.toString());
      },
    );
  } catch (e) {
    emit(GetRatingFailed(e.toString()));
  }
}


  void _dataFetched(DataFetched event, Emitter<GetRatingReviewState> emit) {
    emit(GetRatingLoaded(event.data));
  }
}
