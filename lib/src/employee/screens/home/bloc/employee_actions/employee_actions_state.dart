part of 'employee_actions_bloc.dart';

enum FormStatus {
  initial,
  pending,
  success,
  error,
}

@immutable
class EmployeeActionsState {
  const EmployeeActionsState({
    this.rejectStatus = FormStatus.initial,
    this.acceptStatus = FormStatus.initial,
    this.completed=FormStatus.initial
  });
  final FormStatus? rejectStatus;
  final FormStatus? acceptStatus;
  final FormStatus? completed;

  EmployeeActionsState copyWith({FormStatus? rejectStatus, FormStatus? acceptStatus,FormStatus? completed}) => EmployeeActionsState(
        rejectStatus: rejectStatus ?? this.rejectStatus,
        acceptStatus: acceptStatus ?? this.acceptStatus,
        completed: completed??this.completed
      );
}
