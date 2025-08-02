class UserNotification {
  final String notificationDate;
  final String notes;
  final String createdAt;

  UserNotification({
    required this.notificationDate,
    required this.notes,
    required this.createdAt,
  });

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
      notificationDate: json['note_date'] ?? '',
      notes: json['note'] ?? '',
      createdAt: json['created_at'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'note_date': notificationDate,
      'note': notes,
      'created_at': createdAt,
    };
  }
}
