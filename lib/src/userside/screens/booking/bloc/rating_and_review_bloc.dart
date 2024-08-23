import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/services/user/booking/service_booking.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'rating_and_review_event.dart';
part 'rating_and_review_state.dart';

class RatingAndReviewBloc extends Bloc<RatingAndReviewEvent, RatingAndReviewState> {
  RatingAndReviewBloc() : super(const RatingAndReviewState()) {
    on<SubmitRating>(_onSubmitRatingReview);
    on<ServiceNameChanged>(_serviceNameChanged);
    on<ReviewChanged>(_reviewChanged);
    on<RatingChanged>(_ratingChanged);
  }
  void _serviceNameChanged(ServiceNameChanged event, Emitter<RatingAndReviewState> emit) {
    emit(state.copyWith(serviceName: event.serviceName));
  }

  void _reviewChanged(ReviewChanged event, Emitter<RatingAndReviewState> emit) {
    emit(state.copyWith(review: event.review));
  }

  void _ratingChanged(RatingChanged event, Emitter<RatingAndReviewState> emit) {
    emit(state.copyWith(rating: event.rating));
  }

  void _onSubmitRatingReview(SubmitRating event, Emitter<RatingAndReviewState> emit) async {
    emit(state.copyWith(status: RatingFormStatus.pending));

    try {
      final prefs = await SharedPreferences.getInstance();
      final id = prefs.getString('userId');

      final details = ServiceBooking.ratingReviewInfo(userId: id!, review: state.review, rating: state.rating, serviceName:state.serviceName);
      final result = await ServiceBooking.addRatingReview(details);

      if (result) {
        emit(state.copyWith(status: RatingFormStatus.success));
      } else {
        emit(state.copyWith(status: RatingFormStatus.error));
      }
    } catch (e) {
      emit(state.copyWith(status: RatingFormStatus.error));
    }
  }
}
