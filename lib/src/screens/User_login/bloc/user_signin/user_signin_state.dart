part of 'user_signin_bloc.dart';

enum FormStatus { initial, pending, success, error }

@immutable
class UserSigninState {
  const UserSigninState({
    this.email = '',
    this.password = '',
    this.status = FormStatus.initial,
    this.errorMsg,
  });

  final String email;
  final String password;
  final FormStatus status;
  final String? errorMsg;

  UserSigninState copyWith({
    String? email,
    String? password,
    FormStatus? status,
    String? errorMsg,
  }) {
    return UserSigninState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
