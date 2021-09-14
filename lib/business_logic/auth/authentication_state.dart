part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();
}

class AuthenticationInitial extends AuthenticationState {
  @override
  List<Object> get props => [];
}

class AuthenticationStateAuthenticated extends AuthenticationState {
  final firebase_auth.User user;

  AuthenticationStateAuthenticated({@required this.user});

  @override
  List<Object> get props => [user];
}

class AuthenticationUnauthenticated extends AuthenticationState {
  AuthenticationUnauthenticated();

  @override
  List<Object> get props => [];
}

class AuthenticationLoading extends AuthenticationState {
  AuthenticationLoading();

  @override
  List<Object> get props => [];
}
