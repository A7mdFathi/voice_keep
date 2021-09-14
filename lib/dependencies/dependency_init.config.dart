// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i3;
import 'package:flutter_sound_lite/flutter_sound.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;

import '../business_logic/auth/authentication_bloc.dart' as _i12;
import '../business_logic/bloc_observer.dart' as _i11;
import '../business_logic/login_cubit/login_cubit.dart' as _i8;
import '../business_logic/show_password/show_password_cubit.dart' as _i7;
import '../business_logic/signup_cubit/sign_up_cubit.dart' as _i10;
import '../repository/authentication_repository.dart' as _i9;
import 'register_module.dart' as _i13; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.FacebookAuth>(() => registerModule.facebookAuth);
  gh.factory<_i4.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.lazySingleton<_i5.FlutterSoundRecorder>(
      () => registerModule.flutterSoundRecorder());
  gh.factory<_i6.GoogleSignIn>(() => registerModule.googleSignIn);
  gh.factory<_i7.ShowPasswordCubit>(() => _i7.ShowPasswordCubit());
  gh.factory<_i8.LoginCubit>(
      () => _i8.LoginCubit(get<_i9.AuthenticationRepository>()));
  gh.factory<_i10.SignUpCubit>(
      () => _i10.SignUpCubit(get<_i9.AuthenticationRepository>()));
  gh.singleton<_i11.AppBlocObserver>(_i11.AppBlocObserver());
  gh.singleton<_i9.AuthenticationRepository>(_i9.AuthenticationRepository(
      firebaseAuth: get<_i4.FirebaseAuth>(),
      googleSignIn: get<_i6.GoogleSignIn>(),
      facebookAuth: get<_i3.FacebookAuth>()));
  gh.singleton<_i12.AuthenticationBloc>(_i12.AuthenticationBloc(
      authenticationRepository: get<_i9.AuthenticationRepository>()));
  return get;
}

class _$RegisterModule extends _i13.RegisterModule {}
