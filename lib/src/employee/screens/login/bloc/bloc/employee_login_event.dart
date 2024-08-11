part of 'employee_login_bloc.dart';

@immutable
sealed class EmployeeLoginEvent {}

final class EmailChanged extends EmployeeLoginEvent {
  EmailChanged(this.email);
  final String email;
}
final class PasswordChanged extends EmployeeLoginEvent {
  PasswordChanged(this.password);
  final String password;
}

final class FormSubmit extends EmployeeLoginEvent {}

class UserLoggedOut extends EmployeeLoginEvent {}