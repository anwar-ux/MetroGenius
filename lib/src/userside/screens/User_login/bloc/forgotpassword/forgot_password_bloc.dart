import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:metrogeniusorg/services/user/registation/user_signin_auth.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(const ForgotPasswordState()) {
    on<EmailChanged>(_emailChanged);
    on<FormSubmit>(_formSubmit);
  }

  void _emailChanged(EmailChanged event, Emitter<ForgotPasswordState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _formSubmit(FormSubmit event, Emitter<ForgotPasswordState> emit) async {
    emit(state.copyWith(status: FormStatus.pending));
    try {
      final result = await UserSigninAuth.resetPassword(state.email);
      if (result) {
        emit(state.copyWith(status: FormStatus.success));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error));
    }
  }
}
