import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthLoginRequested>(_authLoginRequested);
    on<AuthLogoutRequested>(_authLogoutRequested);
  }
}

void _authLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
  emit(AuthLoading());
  try {
    final email = event.email;
    final password = event.password;

    if (password.length < 6) {
      emit(AuthFailure("Password can not be less than 6 characters"));
      return;
    }
    // email validation using Regex
    await Future.delayed(const Duration(seconds: 1), () {
      return emit(AuthSuccess(uid: '$email-$password'));
    });
  } catch (e) {
    return emit(AuthFailure(e.toString()));
  }
}

void _authLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
  emit(AuthLoading());
  try {
    await Future.delayed(const Duration(seconds: 1), () {
      return emit(AuthInitial());
    });
  } catch (e) {
    emit(AuthFailure(e.toString()));
  }
}
