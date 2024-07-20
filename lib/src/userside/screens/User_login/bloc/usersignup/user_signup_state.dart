part of 'user_signup_bloc.dart';

enum FormStatus {
  initial,
  pending,
  success,
  error,
}

@immutable
class UserSignupState {
  const UserSignupState({
    this.email = "",
    this.password = "",
    this.status = FormStatus.initial,
    this.errorMsg,
  });
  final String email;
  final String password;
  final FormStatus status;
  final String? errorMsg;

  UserSignupState copyWith({
    String? email,
    String? password,
    FormStatus? status,
    String? errorMsg,
  }) =>
      UserSignupState(
        email: email ?? this.email,
        password: password ?? this.password,
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
      );
}
