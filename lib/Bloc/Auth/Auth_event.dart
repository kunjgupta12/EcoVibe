import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthEvent {}

class AuthLoadingEvent extends AuthEvent {}

class AuthCodeSentEvent extends AuthEvent {}

class AuthCodeVerifiedEvent extends AuthEvent {}

class AuthLoggedInEvent extends AuthEvent {
  final User firebaseUser;
  AuthLoggedInEvent(this.firebaseUser);
}

class AuthLoggedOutEvent extends AuthEvent {}

class AuthErrorEvent extends AuthEvent {
  final String error;
  AuthErrorEvent(this.error);
}
