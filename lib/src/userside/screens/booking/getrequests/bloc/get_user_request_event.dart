part of 'get_user_request_bloc.dart';

sealed class GetUserRequestEvent extends Equatable {
  const GetUserRequestEvent();

  @override
  List<Object> get props => [];
}
class FetchUserPendingRequestData extends GetUserRequestEvent {}

class FetchUserCompletedRequestData extends GetUserRequestEvent {}
class DataRequestFetched extends GetUserRequestEvent {
  final List<DocumentSnapshot> data;
  const DataRequestFetched(this.data);
  @override
  List<Object> get props => [data];
}
