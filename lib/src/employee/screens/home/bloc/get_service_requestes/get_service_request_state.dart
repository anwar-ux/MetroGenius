part of 'get_service_request_bloc.dart';

sealed class GetServiceRequestState extends Equatable {
  const GetServiceRequestState();
  
  @override
  List<Object> get props => [];
}

final class GetRequestInitial
    extends GetServiceRequestState {}

final class GetRequestLoading
    extends GetServiceRequestState {}

final class GetRequestLoaded extends GetServiceRequestState {
  final List<DocumentSnapshot> data;
  const GetRequestLoaded(this.data);
}

final class GetRequestFailed extends GetServiceRequestState {
  final String errorMsg;

  const GetRequestFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
