part of 'get_service_request_bloc.dart';

sealed class GetServiceRequestEvent extends Equatable {
  const GetServiceRequestEvent();

  @override
  List<Object> get props => [];
}

class FetchRequestData extends GetServiceRequestEvent {}

class FetchCommitedRequestData extends GetServiceRequestEvent {}

class FetchCompletedRequestData extends GetServiceRequestEvent {}
class DataRequestFetched extends GetServiceRequestEvent {
  final List<DocumentSnapshot> data;
  const DataRequestFetched(this.data);
  @override
  List<Object> get props => [data];
}
