import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:metrogeniusorg/services/user/registation/user_signin_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
part 'user_signin_event.dart';
part 'user_signin_state.dart';


class UserSigninBloc extends Bloc<UserSigninEvent, UserSigninState> {
  UserSigninBloc() : super(const UserSigninState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<FormSubmit>(_formSubmit);
    on<UserLoggedOut>(_userLoggedOut);
  }



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
      final user = await UserSigninAuth.signInWithEmailAndPassword(
        state.email,
        state.password,
      );
      if (user != null) {
        final prefs = await SharedPreferences.getInstance();
      await prefs.setString('userId', user.uid);

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
