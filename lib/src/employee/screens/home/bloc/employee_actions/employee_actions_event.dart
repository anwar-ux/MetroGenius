part of 'employee_actions_bloc.dart';

sealed class EmployeeActionsEvent   {

}
final class AcceptClicked extends EmployeeActionsEvent {
     AcceptClicked(this.id);
  final String id;
}

final class RejectClicked extends EmployeeActionsEvent {
   RejectClicked(this.id);
  final String id;
}
final class CompletedClicked extends EmployeeActionsEvent {
   CompletedClicked(this.id);
  final String id;
}