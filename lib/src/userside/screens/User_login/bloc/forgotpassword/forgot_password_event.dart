part of 'forgot_password_bloc.dart';

sealed class ForgotPasswordEvent {}

final class EmailChanged extends ForgotPasswordEvent {
   EmailChanged(this.email);
  final String? email;
}

final class FormSubmit extends ForgotPasswordEvent{}