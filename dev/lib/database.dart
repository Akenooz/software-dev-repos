import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime? deadline;
  @HiveField(3)
  final String? description;
  @HiveField(4)
  final DateTime? startTime;
  @HiveField(5)
  final bool isRepeating;
  @HiveField(6)
  final TaskRecurrence? recurrence;
  @HiveField(7)
  final bool hasReminder;
  @HiveField(8)
  final int? reminderMinutes;
  @HiveField(9)
  final int priority;

  Task(
    this.id,
    this.name,
    this.deadline,
    this.description,
    this.startTime, {
    required this.isRepeating,
    this.recurrence,
    this.hasReminder = false,
    this.reminderMinutes,
    required this.priority,
  });
}

@HiveType(typeId: 1)
class TaskRecurrence {
  @HiveField(0)
  final RecurrenceType type;
  @HiveField(1)
  final int frequency;

  TaskRecurrence(this.type, this.frequency);
}

enum RecurrenceType { Daily, Weekly, Monthly, None }

