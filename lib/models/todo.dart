import 'dart:convert';

class Task {
  String id;
  String title;
  String? description;
  String dateTime;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.dateTime,
  });

  factory Task.fromRawJson(String str) => Task.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "dateTime": dateTime,
      };
}
