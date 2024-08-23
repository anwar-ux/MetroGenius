part of 'get_user_request_bloc.dart';

sealed class GetUserRequestState extends Equatable {
  const GetUserRequestState();
  
  @override
  List<Object> get props => [];
}

final class GetUserRequestInitial
    extends GetUserRequestState {}

final class GetUserRequestLoading
    extends GetUserRequestState {}

final class GetUserRequestLoaded extends GetUserRequestState {
  final List<DocumentSnapshot> data;
  const GetUserRequestLoaded(this.data);
}

final class GetUserRequestFailed extends GetUserRequestState {
  final String errorMsg;

  const GetUserRequestFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
