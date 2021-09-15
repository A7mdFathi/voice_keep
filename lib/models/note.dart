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
}
