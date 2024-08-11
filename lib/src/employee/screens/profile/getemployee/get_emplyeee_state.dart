part of 'get_emplyeee_bloc.dart';

sealed class GetEmployeeState extends Equatable {
  const GetEmployeeState();
  
  @override
  List<Object> get props => [];
}

final class GetEmployeeInitial extends GetEmployeeState {}

final class GetEmployeeLoading
    extends GetEmployeeState {}

final class GetEmplyeeLoaded extends GetEmployeeState {
  final DocumentSnapshot data;

  const GetEmplyeeLoaded(this.data);
}

final class GetEmplyeeFailed extends GetEmployeeState {
  final String errorMsg;

  const GetEmplyeeFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}

