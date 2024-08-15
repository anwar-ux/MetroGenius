part of 'get_user_details_bloc.dart';

sealed class GetUserDetailsEvent extends Equatable {
  const GetUserDetailsEvent();

  @override
  List<Object> get props => [];
}
class FetchUserData extends GetUserDetailsEvent {}

class DataFetched extends GetUserDetailsEvent {
  final List<DocumentSnapshot> data;
  const DataFetched(this.data);
  @override
  List<Object> get props => [data];
}