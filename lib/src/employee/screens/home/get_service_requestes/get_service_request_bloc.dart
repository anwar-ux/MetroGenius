import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrogeniusorg/services/employee/getemployee/employee.dart';

part 'get_service_request_event.dart';
part 'get_service_request_state.dart';

class GetServiceRequestBloc extends Bloc<GetServiceRequestEvent, GetServiceRequestState> {
  GetServiceRequestBloc() : super(GetRequestInitial()) {
  on<FetchRequestData>(_onFetchData);
    on<DataRequestFetched>(_onDataFetched);
  }

  Future<void> _onFetchData(FetchRequestData event, Emitter<GetServiceRequestState> emit) async {
    emit(GetCategoryLoading());
    try {
      
      Stream<QuerySnapshot> dataStream = await EmployeeService.getRequestes();
      dataStream.listen((snapshot) {final data = snapshot.docs;
      add(DataRequestFetched(data));
      });
    } catch (e) {
      emit(GetRequestFailed(e.toString()));
    }
  }

  void _onDataFetched(DataRequestFetched event, Emitter<GetServiceRequestState> emit) {
    emit(GetRequestLoaded(event.data));
  }
}
