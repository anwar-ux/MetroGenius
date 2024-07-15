part of 'user_signup_bloc.dart';

@immutable
sealed class UserSignupEvent {}

final class EmailChanged extends UserSignupEvent {
  EmailChanged(this.email);
  final String email;
}

final class PasswordChanged extends UserSignupEvent {
  PasswordChanged(this.password);
  final String password;
}

final class FormSubmit extends UserSignupEvent {}
