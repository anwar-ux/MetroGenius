part of 'get_address_bloc.dart';


sealed class GetAddressEvent extends Equatable {
  const GetAddressEvent();

  @override
  List<Object> get props => [];
}

class FetchAddresData extends GetAddressEvent {}

class DataFetched extends GetAddressEvent {
  final List<DocumentSnapshot> data;
  const DataFetched(this.data);
  @override
  List<Object> get props => [data];
}