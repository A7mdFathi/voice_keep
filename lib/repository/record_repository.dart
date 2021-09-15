import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

@injectable
class RecordRepository {
  FlutterSoundRecorder _soundRecorder;

  RecordRepository(this._soundRecorder);

  String _fileName;

  startRecording() async {
    final permissionStatus = await Permission.microphone.request();
    if (permissionStatus != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission access denied');
    }
    _fileName = 'sound-audio-${DateTime.now().millisecondsSinceEpoch}.mp4';
    await _soundRecorder.startRecorder(
      codec: Codec.aacMP4,
      toFile: '$_fileName',
    );
  }

  openSession() async {
    _soundRecorder = await _soundRecorder.openAudioSession();
  }

  Future<String> stopRecording() async {
    String voiceUrl;
    if (!_soundRecorder.isStopped) {
      voiceUrl = await _soundRecorder.stopRecorder();
    }

    print('$voiceUrl');
    return voiceUrl;
  }

  deleteRecord() async {
    await _soundRecorder.deleteRecord(fileName: _fileName);
  }

  Future<void> closeSession() async {
    await _soundRecorder.closeAudioSession();
  }
}
