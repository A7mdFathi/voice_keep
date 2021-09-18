// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i5;
import 'package:firebase_auth/firebase_auth.dart' as _i4;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart' as _i3;
import 'package:flutter_sound_lite/flutter_sound.dart' as _i6;
import 'package:get_it/get_it.dart' as _i1;
import 'package:google_sign_in/google_sign_in.dart' as _i7;
import 'package:injectable/injectable.dart' as _i2;

import '../business_logic/auth/authentication_bloc.dart' as _i18;
import '../business_logic/bloc_observer.dart' as _i17;
import '../business_logic/login_cubit/login_cubit.dart' as _i12;
import '../business_logic/notes_list_bloc/note_list_bloc.dart' as _i14;
import '../business_logic/send_voice/voice_message_cubit.dart' as _i16;
import '../business_logic/show_password/show_password_cubit.dart' as _i10;
import '../business_logic/signup_cubit/sign_up_cubit.dart' as _i15;
import '../repository/authentication_repository.dart' as _i13;
import '../repository/notes_repository.dart' as _i8;
import '../repository/record_repository.dart' as _i9;
import '../repository/storage_repository.dart' as _i11;
import 'register_module.dart' as _i19; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String environment, _i2.EnvironmentFilter environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final registerModule = _$RegisterModule();
  gh.factory<_i3.FacebookAuth>(() => registerModule.facebookAuth);
  gh.factory<_i4.FirebaseAuth>(() => registerModule.firebaseAuth);
  gh.factory<_i5.FirebaseFirestore>(() => registerModule.firebaseFirestore);
  gh.lazySingleton<_i6.FlutterSoundRecorder>(
      () => registerModule.flutterSoundRecorder());
  gh.factory<_i7.GoogleSignIn>(() => registerModule.googleSignIn);
  gh.factory<_i8.NoteRepository>(() => _i8.NoteRepository());
  gh.factory<_i9.RecordRepository>(
      () => _i9.RecordRepository(get<_i6.FlutterSoundRecorder>()));
  gh.factory<_i10.ShowPasswordCubit>(() => _i10.ShowPasswordCubit());
  gh.factory<_i11.StorageRepository>(() => _i11.StorageRepository());
  gh.factory<_i12.LoginCubit>(
      () => _i12.LoginCubit(get<_i13.AuthenticationRepository>()));
  gh.factory<_i14.NoteListBloc>(
      () => _i14.NoteListBloc(noteRepository: get<_i8.NoteRepository>()));
  gh.factory<_i15.SignUpCubit>(
      () => _i15.SignUpCubit(get<_i13.AuthenticationRepository>()));
  gh.factory<_i16.VoiceMessageCubit>(() => _i16.VoiceMessageCubit(
      repository: get<_i9.RecordRepository>(),
      authenticationRepository: get<_i13.AuthenticationRepository>()));
  gh.singleton<_i17.AppBlocObserver>(_i17.AppBlocObserver());
  gh.singleton<_i13.AuthenticationRepository>(_i13.AuthenticationRepository(
      firebaseAuth: get<_i4.FirebaseAuth>(),
      googleSignIn: get<_i7.GoogleSignIn>(),
      facebookAuth: get<_i3.FacebookAuth>()));
  gh.singleton<_i18.AuthenticationBloc>(_i18.AuthenticationBloc(
      authenticationRepository: get<_i13.AuthenticationRepository>()));
  return get;
}

class _$RegisterModule extends _i19.RegisterModule {}
