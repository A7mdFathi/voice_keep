part of 'voice_message_cubit.dart';

abstract class VoiceMessageState extends Equatable {
  const VoiceMessageState();
}

class VoiceMessageInitial extends VoiceMessageState {
  @override
  List<Object> get props => [];

  const VoiceMessageInitial();
}

class VoiceMessageStarting extends VoiceMessageState {
  const VoiceMessageStarting();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class VoiceMessageRecording extends VoiceMessageState {
  @override
  List<Object> get props => [];

  const VoiceMessageRecording();
}

class VoiceMessageRecorded extends VoiceMessageState {
  VoiceMessageRecorded();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class VoiceMessageSending extends VoiceMessageState {
  VoiceMessageSending();

  @override
  // TODO: implement props
  List<Object> get props => [];
}

class VoiceMessageSent extends VoiceMessageState {
  @override
  // TODO: implement props
  List<Object> get props => [];

  VoiceMessageSent();
}

class VoiceMessageError extends VoiceMessageState {
  @override
  // TODO: implement props
  List<Object> get props => [];

  VoiceMessageError();
}
