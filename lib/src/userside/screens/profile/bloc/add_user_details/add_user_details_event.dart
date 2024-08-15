part of 'add_user_details_bloc.dart';

sealed class AddUserDetailsEvent  {}
final class PhotoChanged extends AddUserDetailsEvent {
  PhotoChanged(this.photo);
  final String photo;
}
final class NameChanged extends AddUserDetailsEvent {
  NameChanged(this.name);
  final String name;
}



final class FormSubmit extends AddUserDetailsEvent {}
final class PendingFrom extends AddUserDetailsEvent {}

final class FormClear extends AddUserDetailsEvent {}

