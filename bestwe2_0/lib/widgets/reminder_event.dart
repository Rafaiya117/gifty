import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteItem {
  final String noteDate;
  final String note;
  final String createdAt;

  NoteItem({
    required this.noteDate,
    required this.note,
    required this.createdAt,
  });

  factory NoteItem.fromJson(Map<String, dynamic> json) {
    return NoteItem(
      noteDate: json['note_date'] ?? '',
      note: json['note'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }
}

class NoteListScreen extends StatelessWidget {
  final List<Map<String, dynamic>> jsonData = [
    {
      "note_date": "2025-10-01",
      "note": "Remember to buy a gift for mom's birthday.",
      "created_at": "1 day ago"
    }
  ];

  NoteListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<NoteItem> notes =
        jsonData.map((data) => NoteItem.fromJson(data)).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Notes"),
        backgroundColor: const Color(0xFF5B4025),
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: notes.length,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        itemBuilder: (context, index) {
          final note = notes[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFFF9F6F3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE0DAD1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.noteDate,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.brown[400],
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  note.note,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    note.createdAt,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
