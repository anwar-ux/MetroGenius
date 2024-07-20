import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrogeniusorg/services/user/registation/user_signin_auth.dart';
import 'package:meta/meta.dart';
part 'user_signin_event.dart';
part 'user_signin_state.dart';

class UserSigninBloc extends Bloc<UserSigninEvent, UserSigninState> {
  UserSigninBloc(this._userSigninAuth) : super(const UserSigninState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<FormSubmit>(_formSubmit);
    on<UserLoggedOut>(_userLoggedOut);
  }

  final UserSigninAuth _userSigninAuth;

  void _emailChanged(EmailChanged event, Emitter<UserSigninState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordChanged(PasswordChanged event, Emitter<UserSigninState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _formSubmit(
      FormSubmit event, Emitter<UserSigninState> emit) async {
    emit(state.copyWith(status: FormStatus.pending));
    try {
      final user = await _userSigninAuth.signInWithEmailAndPassword(
        state.email,
        state.password,
      );
      if (user != null) {
        emit(state.copyWith(status: FormStatus.success));
      } else {
        emit(state.copyWith(
            status: FormStatus.error, errorMsg: 'Sign in failed.'));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, errorMsg: e.toString()));
    }
  }
   void _userLoggedOut(UserLoggedOut event, Emitter<UserSigninState> emit) async {
    await FirebaseAuth.instance.signOut();
    emit(UserSigninState.initial());
  }
}
