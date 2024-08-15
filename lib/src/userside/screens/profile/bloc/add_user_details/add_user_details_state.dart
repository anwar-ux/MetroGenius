part of 'add_user_details_bloc.dart';

enum FormStatus {
  initial,
  pending,
  success,
  error,
}

@immutable
class AddUserDetailsState {
  const AddUserDetailsState({
    this.name = '',
    this.image = '',
    this.status=FormStatus.initial,
  });
  final FormStatus status;
  final String name;
  final String image;

  AddUserDetailsState copyWith({
    String? name,
    String? image,
    FormStatus? status
  }) =>
      AddUserDetailsState(
        name: name ?? this.name,
        image: image ?? this.image,
        status: status??this.status
      );

  factory AddUserDetailsState.initial() {
    return const AddUserDetailsState();
  }
}

final class EmployeeJobApplicationLoding extends AddUserDetailsState {}
