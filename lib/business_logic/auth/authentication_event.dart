part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();
}

class AuthenticationAppStarted extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationLogged extends AuthenticationEvent {
  final firebase_auth.User user;

  AuthenticationLogged({@required this.user});

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class AuthenticationLogout extends AuthenticationEvent {
  @override
  List<Object> get props => [];
}

class AuthenticationOnBoardComplete extends AuthenticationEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}
