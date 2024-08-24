import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusorg/services/user/booking/service_booking.dart';

part 'get_user_request_event.dart';
part 'get_user_request_state.dart';

class GetUserRequestBloc extends Bloc<GetUserRequestEvent, GetUserRequestState> {
  GetUserRequestBloc() : super(GetUserRequestInitial()) {

    on<FetchUserPendingRequestData>(_onFetchPendingData);
     on<FetchUserCompletedRequestData>(_onFetchCompletedData);
  }

  Future<void> _onFetchPendingData(FetchUserPendingRequestData event, Emitter<GetUserRequestState> emit) async {
    emit(GetUserRequestLoading());
    try {
      final stream = ServiceBooking.getPendingRequests();
      await emit.forEach<QuerySnapshot>(
        stream,
        onData: (snapshot) => GetUserRequestLoaded(snapshot.docs),
        onError: (error, stackTrace) => GetUserRequestFailed(error.toString()),
      );
    } catch (e) {
      emit(GetUserRequestFailed(e.toString()));
    }
  }
 Future<void> _onFetchCompletedData(FetchUserCompletedRequestData event, Emitter<GetUserRequestState> emit) async {
    emit(GetUserRequestLoading());
    try {
      final stream = ServiceBooking.getCompletedRequestes();
      await emit.forEach<QuerySnapshot>(
        stream,
        onData: (snapshot) => GetUserRequestLoaded(snapshot.docs),
        onError: (error, stackTrace) => GetUserRequestFailed(error.toString()),
      );
    } catch (e) {
      emit(GetUserRequestFailed(e.toString()));
    }
  }
 
}
