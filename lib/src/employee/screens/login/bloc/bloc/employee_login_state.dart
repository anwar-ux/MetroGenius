part of 'employee_login_bloc.dart';

enum FormStatus { initial, pending, success, error }

@immutable
class EmployeeLoginState {
  const EmployeeLoginState({
    this.email = '',
    this.password = '',
    this.status = FormStatus.initial,
    this.errorMsg,
  });

  final String email;
  final String password;
  final FormStatus status;
  final String? errorMsg;

  EmployeeLoginState copyWith({
    String? email,
    String? password,
    FormStatus? status,
    String? errorMsg,
  }) {
    return EmployeeLoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }

  factory EmployeeLoginState.initial() {
    return const EmployeeLoginState();
  }
}
