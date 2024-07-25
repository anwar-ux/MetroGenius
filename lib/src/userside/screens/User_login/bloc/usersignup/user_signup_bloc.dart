// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';
import 'package:metrogeniusorg/services/user/registation/user_signup_auth.dart';
part 'user_signup_event.dart';
part 'user_signup_state.dart';

class UserSignupBloc extends Bloc<UserSignupEvent, UserSignupState> {
  UserSignupBloc(this._userSignupAuth) : super(const UserSignupState()) {
    on<EmailChanged>(_emailChanged);
    on<PasswordChanged>(_passwordChanged);
    on<FormSubmit>(_formSubmit);
  }

  final UserSignupAuth _userSignupAuth;

  void _emailChanged(EmailChanged event, Emitter<UserSignupState> emit) {
    emit(state.copyWith(email: event.email));
    
  }

  void _passwordChanged(PasswordChanged event, Emitter<UserSignupState> emit) {
    emit(state.copyWith(password: event.password));
  }

  Future<void> _formSubmit(
      FormSubmit event, Emitter<UserSignupState> emit) async {
    emit(state.copyWith(status: FormStatus.pending));

    try {
      final user = await _userSignupAuth.createUserWithEmailAndPassword(
        state.email,
        state.password,
      );

      if (user != null) {
        emit(state.copyWith(status: FormStatus.success));
      } else {
        emit(state.copyWith(
            status: FormStatus.error, errorMsg: 'Signup failed.'));
      }
    } catch (e) {
      emit(state.copyWith(status: FormStatus.error, errorMsg: e.toString()));
    }
  }
}
