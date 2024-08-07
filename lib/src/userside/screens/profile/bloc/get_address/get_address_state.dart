part of 'get_address_bloc.dart';

sealed class GetAddressState extends Equatable {
  const GetAddressState();

  @override
  List<Object> get props => [];
}

final class GetAddressInitial
    extends GetAddressState {}

final class GetAddressLoading
    extends GetAddressState {}

final class GetAddressLoaded extends GetAddressState {
  final List<DocumentSnapshot> data;

  const GetAddressLoaded(this.data);
}

final class GetAddressFailed extends GetAddressState {
  final String errorMsg;

  const GetAddressFailed(this.errorMsg);

  @override
  List<Object> get props => [errorMsg];
}
