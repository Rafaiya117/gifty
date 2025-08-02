class Note {
  final String noteDate;
  final String note;
  final String createdAt;

  Note({
    required this.noteDate,
    required this.note,
    required this.createdAt,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      noteDate: json['note_date'] ?? '',
      note: json['note'] ??'',
      createdAt: json['created_at']??'',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'note_date': noteDate,
      'note': note,
      'created_at': createdAt,
    };
  }
}

