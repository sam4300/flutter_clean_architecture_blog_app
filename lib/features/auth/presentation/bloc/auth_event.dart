part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class AuthSighUp extends AuthEvent {
  final String name;
  final String email;
  final String password;

  AuthSighUp({
    required this.name,
    required this.email,
    required this.password,
  });
}

class AuthSignIn extends AuthEvent {
  final String email;
  final String password;
  AuthSignIn({
    required this.email,
    required this.password,
  });
}

class AuthCurrentUser extends AuthEvent{}
