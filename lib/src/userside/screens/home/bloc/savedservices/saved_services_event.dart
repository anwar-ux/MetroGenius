part of 'saved_services_bloc.dart';

sealed class SavedServicesEvent extends Equatable {
  const SavedServicesEvent();

  @override
  List<Object> get props => [];
}

class FetchSavedServiceData extends SavedServicesEvent {}

class RemoveFromSaved extends SavedServicesEvent {
  final String id;
  const RemoveFromSaved(this.id);
}

class AddToSave extends SavedServicesEvent {
  final QueryDocumentSnapshot data;
  const AddToSave(this.data);
}

class DataFetched extends SavedServicesEvent {
  final List<DocumentSnapshot> data;
  const DataFetched(this.data);
  @override
  List<Object> get props => [data];
}
