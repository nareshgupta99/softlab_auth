import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginSubmittedEvent>(_onLogin);
  }

  Future<void> _onLogin(LoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final errors = <String, String>{};
      if (event.email.isEmpty) {
        errors['email'] = 'email is required';
      } else if (!event.email.contains('@')) {
        errors['email'] = 'enter valid email';
      }
      if (event.password.isEmpty) {
        errors['password'] = 'Password is required';
      } else if (event.password.length < 6) {
        errors['password'] = 'password must be 6 character long';
      }

      if (errors.isNotEmpty) {
        final firstKey = errors.keys.first;
        final firstError = errors[firstKey]!;
        emit(AuthValidationError(errorTitle: firstKey == 'email' ? 'Invalid Email' : 'Invalid Password', error: firstError));
        return;
      }
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
