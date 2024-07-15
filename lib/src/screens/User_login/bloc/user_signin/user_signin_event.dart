part of 'user_signin_bloc.dart';

@immutable
sealed class UserSigninEvent {}

final class EmailChanged extends UserSigninEvent {
  EmailChanged(this.email);
  final String email;
}
final class PasswordChanged extends UserSigninEvent {
  PasswordChanged(this.password);
  final String password;
}

final class FormSubmit extends UserSigninEvent {}