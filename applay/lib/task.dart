// task.dart

class Task {
  final String name;
  final DateTime? deadline; // Nullable DateTime

  Task({
    required this.name,
    this.deadline,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      name: json['name'] ?? '',
      deadline:
      json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'deadline': deadline?.toIso8601String(),
    };
  }
}