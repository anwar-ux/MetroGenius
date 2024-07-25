part of 'employee_job_application_bloc.dart';

enum FormStatus {
  initial,
  pending,
  success,
  error,
}

@immutable
class EmployeeJobApplicationState {
  const EmployeeJobApplicationState({
    this.email = "",
    this.name = '',
    this.phone = 0,
    this.iDproof = '',
    this.experience = 0,
    this.work = '',
    this.image = '',
    this.status = FormStatus.initial,
    this.errorMsg,
  });
  final String email;
  final String name;
  final FormStatus status;
  final String? errorMsg;
  final int phone;
  final int experience;
  final String iDproof;
  final String image;
  final String work;

  EmployeeJobApplicationState copyWith({
    String? email,
    String? name,
    FormStatus? status,
    String? errorMsg,
    String? image,
    String? iDproof,
    int? phone,
    int? experience,
    String? work,
  }) =>
      EmployeeJobApplicationState(
        email: email ?? this.email,
        name: name ?? this.name,
        status: status ?? this.status,
        errorMsg: errorMsg ?? this.errorMsg,
        image: image ?? this.image,
        iDproof: iDproof ?? this.iDproof,
        phone: phone ?? this.phone,
        experience: experience ?? this.experience,
        work: work ?? this.work,
      );

  factory EmployeeJobApplicationState.initial() {
    return const EmployeeJobApplicationState();
  }
}

final class EmployeeJobApplicationLoding extends EmployeeJobApplicationState{}