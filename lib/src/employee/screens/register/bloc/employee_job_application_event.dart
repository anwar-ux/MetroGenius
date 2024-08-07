part of 'employee_job_application_bloc.dart';

sealed class EmployeeJobApplicationEvent {}

final class PhotoChanged extends EmployeeJobApplicationEvent {
  PhotoChanged(this.image);
  final String image;
}
final class NameChanged extends EmployeeJobApplicationEvent {
  NameChanged(this.name);
  final String name;
}
final class PhoneChanged extends EmployeeJobApplicationEvent {
  PhoneChanged(this.phone);
  final int phone;
}
final class EmailChanged extends EmployeeJobApplicationEvent {
  EmailChanged(this.email);
  final String email;
}
final class WorkChanged extends EmployeeJobApplicationEvent {
  WorkChanged(this.work);
  final String work;
}
final class ExperienceChanged extends EmployeeJobApplicationEvent {
  ExperienceChanged(this.experience);
  final int experience;
}
final class IdproofChanged extends EmployeeJobApplicationEvent {
  IdproofChanged(this.iDproof);
  final String iDproof;
}
final class FormSubmit extends EmployeeJobApplicationEvent {}
final class PendingFrom extends EmployeeJobApplicationEvent {}

final class FormClear extends EmployeeJobApplicationEvent {}
