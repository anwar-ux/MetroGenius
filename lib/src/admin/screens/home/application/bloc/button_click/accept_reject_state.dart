part of 'accept_reject_bloc.dart';

enum FormStatusAccept {
  initial,
  pending,
  success,
  error,
}

enum FormStatusReject {
  initial,
  pending,
  success,
  error,
}

@immutable
class AcceptRejectState {
  const AcceptRejectState({
    this.rejectStatus = FormStatusReject.initial,
    this.acceptStatus=FormStatusAccept.initial,
  });
  final FormStatusReject? rejectStatus;
  final FormStatusAccept? acceptStatus;

  AcceptRejectState copyWith({
    FormStatusReject? rejectStatus,
    FormStatusAccept? acceptStatus
  }) =>
      AcceptRejectState(
        rejectStatus: rejectStatus ?? this.rejectStatus,
        acceptStatus: acceptStatus??this.acceptStatus,
      );
}
