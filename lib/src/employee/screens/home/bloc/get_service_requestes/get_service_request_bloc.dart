import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusorg/services/employee/getemployee/employee.dart';

part 'get_service_request_event.dart';
part 'get_service_request_state.dart';

class GetServiceRequestBloc extends Bloc<GetServiceRequestEvent, GetServiceRequestState> {
  GetServiceRequestBloc() : super(GetRequestInitial()) {
    on<FetchRequestData>(_onFetchRequestData);
    on<FetchCommitedRequestData>(_onFetchCommitedData);
     on<FetchCompletedRequestData>(_onFetchCompletedData);
  }

  Future<void> _onFetchRequestData(FetchRequestData event, Emitter<GetServiceRequestState> emit) async {
    emit(GetRequestLoading());
    try {
      final stream = EmployeeService.getRequestes();
      await emit.forEach<QuerySnapshot>(
        stream,
        onData: (snapshot) => GetRequestLoaded(snapshot.docs),
        onError: (error, stackTrace) => GetRequestFailed(error.toString()),
      );
    } catch (e) {
      emit(GetRequestFailed(e.toString()));
    }
  }

  Future<void> _onFetchCommitedData(FetchCommitedRequestData event, Emitter<GetServiceRequestState> emit) async {
    emit(GetRequestLoading());
    try {
      final stream = EmployeeService.getCommitedRequestes();
      await emit.forEach<QuerySnapshot>(
        stream,
        onData: (snapshot) => GetRequestLoaded(snapshot.docs),
        onError: (error, stackTrace) => GetRequestFailed(error.toString()),
      );
    } catch (e) {
      emit(GetRequestFailed(e.toString()));
    }
  }
 Future<void> _onFetchCompletedData(FetchCompletedRequestData event, Emitter<GetServiceRequestState> emit) async {
    emit(GetRequestLoading());
    try {
      final stream = EmployeeService.getCompletedRequestes();
      await emit.forEach<QuerySnapshot>(
        stream,
        onData: (snapshot) => GetRequestLoaded(snapshot.docs),
        onError: (error, stackTrace) => GetRequestFailed(error.toString()),
      );
    } catch (e) {
      emit(GetRequestFailed(e.toString()));
    }
  }
 
}
