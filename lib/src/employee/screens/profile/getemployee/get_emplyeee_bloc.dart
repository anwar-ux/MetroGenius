import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:metrogeniusorg/services/employee/getemployee/employee.dart';

part 'get_emplyeee_event.dart';
part 'get_emplyeee_state.dart';

class GetEmployeeBloc extends Bloc<GetEmployeeEvent, GetEmployeeState> {
  GetEmployeeBloc() : super(GetEmployeeInitial()) {
    on<FetchEmployeeData>(_onFetchData);
    on<DataFetched>(_onDataFetched);
  }

  Future<void> _onFetchData(FetchEmployeeData event, Emitter<GetEmployeeState> emit) async {
    emit(GetEmployeeLoading());
    try {
      DocumentSnapshot? documentSnapshot = await EmployeeService.getWorkerData();
      if (documentSnapshot != null) {
        add(DataFetched(documentSnapshot));
      } else {
        emit(GetEmplyeeFailed('Worker document does not exist.'));
      }
    } catch (e) {
      emit(GetEmplyeeFailed(e.toString()));
    }
  }

  void _onDataFetched(DataFetched event, Emitter<GetEmployeeState> emit) {
    emit(GetEmplyeeLoaded(event.data));
  }
}
