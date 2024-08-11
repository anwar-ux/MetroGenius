part of 'get_emplyeee_bloc.dart';

sealed class GetEmployeeEvent extends Equatable {
  const GetEmployeeEvent();

  @override
  List<Object> get props => [];
}
class FetchEmployeeData extends GetEmployeeEvent {}

class DataFetched extends GetEmployeeEvent {
  final DocumentSnapshot data;
  const DataFetched(this.data);
  @override
  List<Object> get props => [data];
}