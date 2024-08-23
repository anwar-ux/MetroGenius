part of 'saved_services_bloc.dart';

sealed class SavedServicesState extends Equatable {
  const SavedServicesState();
  
  @override
  List<Object> get props => [];
}

final class SavedServicesInitial extends SavedServicesState {}

final class SavedServicesLoading extends SavedServicesState {}

final class SavedServicesLoaded extends SavedServicesState {
  final List<DocumentSnapshot> data;
 const SavedServicesLoaded(this.data);
}

final class SavedServicesFailed extends SavedServicesState {
   final String errorMsg;

  const SavedServicesFailed(this.errorMsg);
}
