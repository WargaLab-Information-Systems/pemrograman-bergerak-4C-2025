// models/notes.dart
class Notes {
  final String id;
  final String title;
  final String body;
  final String createdAt;

  Notes({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  factory Notes.fromJson(Map<String, dynamic> json) {
    return Notes(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      createdAt: json['createdAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'createdAt': createdAt,
    };
  }
}