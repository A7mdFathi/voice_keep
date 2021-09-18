import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:flutter_procrew/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@singleton
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc({
    @required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(AuthenticationInitial());

  final AuthenticationRepository _authenticationRepository;

  firebase_auth.User user;

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AuthenticationAppStarted) {
      yield* _mapAppStarted();
    } else if (event is AuthenticationLogout) {
      yield* _logOut();
    } else if (event is AuthenticationLogged) {
      yield* _login(event);
    }
  }

  Stream<AuthenticationState> _mapAppStarted() async* {
    yield AuthenticationLoading();
    await Future.delayed(Duration(seconds: 7));
    user = await _authenticationRepository.currentUser;

    if (user != null) {
      yield AuthenticationStateAuthenticated(user: user);
    } else {
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _logOut() async* {
    yield AuthenticationLoading();

    await _authenticationRepository.logOut();
    yield AuthenticationUnauthenticated();
  }

  Stream<AuthenticationState> _login(AuthenticationLogged event) async* {
    yield AuthenticationLoading();
    yield AuthenticationStateAuthenticated(user: user);
  }
}
