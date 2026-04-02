part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class LoginSubmittedEvent extends AuthEvent {
  final String email;
  final String password;
  LoginSubmittedEvent(this.email, this.password);
}
