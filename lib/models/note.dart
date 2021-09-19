import 'package:cloud_firestore/cloud_firestore.dart';

class Note {
  final String noteUrl;
  final Timestamp time;
  final String noteId;

  Note({this.time, this.noteUrl, this.noteId});

  Note.fromJson(Map<String, dynamic> json)
      : this(
          time: json['time'] as Timestamp,
          noteUrl: json['noteUrl'] as String,
          noteId: json['noteId'] as String,
        );

  Map<String, dynamic> toJson() {
    return {
      'time': time,
      'noteUrl': noteUrl,
      'noteId': noteId,
    };
  }
}
