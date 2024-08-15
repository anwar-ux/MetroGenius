part of 'get_user_details_bloc.dart';

sealed class GetUserDetailsState extends Equatable {
  const GetUserDetailsState();
  
  @override
  List<Object> get props => [];
}


final class GetUserDeatailsInitial
    extends GetUserDetailsState {}

final class GetUserDeatailsLoading
    extends GetUserDetailsState {}

final class GetUserDeatailsLoaded extends GetUserDetailsState {
   final List<DocumentSnapshot<Object?>> data;

  const GetUserDeatailsLoaded(this.data);

}

final class GetUserDeatailsFailed extends GetUserDetailsState {
  final String errorMsg;

  const GetUserDeatailsFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
