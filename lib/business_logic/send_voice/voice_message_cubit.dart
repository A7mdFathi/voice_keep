import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_procrew/repository/record_repository.dart';
import 'package:flutter_procrew/repository/storage_repository.dart';
import 'package:injectable/injectable.dart';

part 'voice_message_state.dart';

@injectable
class VoiceMessageCubit extends Cubit<VoiceMessageState> {
  VoiceMessageCubit({
    @required RecordRepository repository,
  })  : this._recordRepository = repository,
        super(VoiceMessageInitial()) {
    _recordRepository.openSession();
  }

  final RecordRepository _recordRepository;

  String _voicePath;
  String _chatId;
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
    if (_voicePath == null || _chatId == null) {
      emit(VoiceMessageError());
    }
    print('RECORD PATH: $_voicePath');
    emit(VoiceMessageSending());
    _file = File(_voicePath);
    if (_file == null) return;
    final voiceUrl = await StorageRepository.uploadFile(_chatId, _file);

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
