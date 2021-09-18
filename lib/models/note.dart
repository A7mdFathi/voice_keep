import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String noteUrl;
  final String noteId;

  Note({this.noteId, this.noteUrl});

  Note.fromJson(Map<String, dynamic> json)
      : this(
          noteId: json['noteId'] as String ?? 'none',
          noteUrl: json['noteUrl'] as String ?? 'none',
        );

  Map<String, dynamic> toJson() {
    return {
      'noteId': noteId,
      'noteUrl': noteUrl,
    };
  }

  // Map<String, Object> toDocument() {
  //   return {
  //     'noteId': text,
  //     'from': from,
  //     'time': time,
  //   };
  // }

  static Note fromDocument(DocumentSnapshot doc) {
    final Map<String, dynamic> docData = doc.data();
    if (docData == null) throw Exception();
    return Note(
      noteId: docData['noteId'],
      noteUrl: docData['noteUrl'],
    );
  }

// static String timestampToString(Note _message) {
//   // in case the time is like 7:5 instead of 07:05
//   int _hour = _message.time.toDate().hour;
//   int _minute = _message.time.toDate().minute;
//   String _timeHour = _hour < 10 ? '0' + _hour.toString() : _hour.toString();
//   String _timeMinute = _minute < 10 ? '0' + _minute.toString() : _minute.toString();
//   return _timeHour + ':' + _timeMinute;
// }

// static Message fromJson(Map<String, Object> json) {
//   return Message(
//     text: json['text'] as String,
//     from: json['from'] as String,
//     time: json['time'] as Timestamp,
//   );
// }
}
