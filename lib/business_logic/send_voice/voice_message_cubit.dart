import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:voice_keep/repository/authentication_repository.dart';
import 'package:voice_keep/repository/record_repository.dart';
import 'package:voice_keep/repository/storage_repository.dart';

part 'voice_message_state.dart';

@injectable
class VoiceMessageCubit extends Cubit<VoiceMessageState> {
  VoiceMessageCubit({
    @required RecordRepository repository,
    @required AuthenticationRepository authenticationRepository,
  })  : this._recordRepository = repository,
        this._authenticationRepository = authenticationRepository,
        super(VoiceMessageInitial()) {
    _recordRepository.openSession();
  }

  final AuthenticationRepository _authenticationRepository;
  final RecordRepository _recordRepository;

  String _voicePath;
  File _file;

  Future<void> startRecording() async {
    _recordRepository.startRecording();

    emit(VoiceMessageRecording());
  }

  Future<void> stopRecording() async {
    _voicePath = await _recordRepository.stopRecording();
    emit(VoiceMessageRecorded());
  }

  sendVoice() async {
    final user = await _authenticationRepository.user.first;
    if (_voicePath == null || user == null) {
      emit(VoiceMessageError());
    }
    print('RECORD PATH: $_voicePath');
    emit(VoiceMessageSending());
    _file = File(_voicePath);
    if (_file == null) return;
    final voiceUrl = await StorageRepository.uploadFile(user.id, _file);
    final uuid = Uuid().v1();
    FirebaseFirestore.instance
        .collection('users')
        .doc('${user.id}')
        .collection('notes')
        .doc('$uuid')
        .set({
      "noteId": uuid,
      "noteUrl": voiceUrl,
      "time": Timestamp.now(),
    });

    emit(VoiceMessageSent());
  }

  cancelSendVoice() {
    _recordRepository.deleteRecord();
  }

  @override
  Future<void> close() async {
    await _recordRepository.closeSession();
    return super.close();
  }
}
