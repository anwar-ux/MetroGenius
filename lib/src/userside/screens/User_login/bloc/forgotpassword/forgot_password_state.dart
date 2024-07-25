part of 'forgot_password_bloc.dart';

enum FormStatus { initial, pending, success, error }

@immutable
class ForgotPasswordState {
  const ForgotPasswordState(
      {this.status = FormStatus.initial, this.email = ''});
  final FormStatus status;
  final String email;

  ForgotPasswordState copyWith({
    String? email,
    FormStatus? status,
  }) {
    return ForgotPasswordState(
        status: status ?? this.status, email: email ?? this.email);
  }
}
