import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TaskReminderApp(),
    ),
  );
}

class TaskReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Reminder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TaskReminderScreen(),
      },
    );
  }
}

class Task {
  final int id;
  final String name;
  final DateTime? deadline;
  final String? description;
  final DateTime? startTime;
  final bool isRepeating;
  final TaskRecurrence? recurrence;
  final bool hasReminder;
  final int? reminderMinutes;
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

enum RecurrenceType { Daily, Weekly, Monthly, None }

class TaskRecurrence {
  final RecurrenceType type;
  final int frequency;

  TaskRecurrence(this.type, this.frequency);
}

class TaskReminderScreen extends StatefulWidget {
  @override
  _TaskReminderScreenState createState() => _TaskReminderScreenState();
}

class _TaskReminderScreenState extends State<TaskReminderScreen> {
  List<Task> tasks = [];
  int taskId = 1;

  TextEditingController taskController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTime? selectedStartDate;
  DateTime? selectedStartTime;
  DateTime? selectedDeadlineDate;
  DateTime? selectedDeadlineTime;
  bool isRepeating = false;
  RecurrenceType? selectedRecurrenceType;
  int? selectedRecurrenceFrequency;
  bool hasReminder = false;
  int? reminderMinutes;
  double priorityLevel = 1.0;

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void addTask(String taskName, DateTime? deadline, String? description,
      DateTime? startTime) {
    setState(() {
      tasks.add(Task(
        taskId,
        taskName,
        deadline,
        description,
        startTime,
        isRepeating: isRepeating,
        recurrence: isRepeating
            ? TaskRecurrence(
            selectedRecurrenceType!, selectedRecurrenceFrequency!)
            : null,
        hasReminder: hasReminder,
        reminderMinutes: hasReminder ? reminderMinutes : null,
        priority: priorityLevel.toInt(),
      ));
      taskId++;
      taskController.clear();
      descriptionController.clear();
      selectedStartDate = null;
      selectedStartTime = null;
      selectedDeadlineDate = null;
      selectedDeadlineTime = null;
      isRepeating = false;
      selectedRecurrenceType = null;
      selectedRecurrenceFrequency = null;
      hasReminder = false;
      reminderMinutes = null;
      priorityLevel = 1.0;
    });
  }

  void removeTask(int id) {
    setState(() {
      tasks.removeWhere((task) => task.id == id);
    });
  }

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null)
      setState(() {
        selectedStartDate = picked;
      });
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        selectedStartTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          picked.hour,
          picked.minute,
        );
      });
  }

  Future<void> _selectDeadlineDate(BuildContext context) async {
    final DateTime picked = (await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    ))!;
    if (picked != null)
      setState(() {
        selectedDeadlineDate = picked;
      });
  }

  Future<void> _selectDeadlineTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null)
      setState(() {
        selectedDeadlineTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          picked.hour,
          picked.minute,
        );
      });
  }

  @override
  Widget build(BuildContext context) {
    final currentTime = DateTime.now();
    final formattedTime = DateFormat('hh:mm:ss a').format(currentTime);
    return Scaffold(
      appBar: AppBar(
        title: Text('Task Reminder'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Current Time: $formattedTime',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(height: 25),
            // Enter Task TextField
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: taskController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Enter task',
                ),
              ),
            ),
            SizedBox(height: 10),
            // Select Start Date and Select Start Time Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => _selectStartDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
                Text(selectedStartDate != null
                    ? DateFormat('yyyy-MM-dd').format(selectedStartDate!)
                    : "Select Start Date"),
                IconButton(
                  onPressed: () => _selectStartTime(context),
                  icon: Icon(Icons.access_time),
                ),
                Text(selectedStartTime != null
                    ? DateFormat('hh:mm a').format(selectedStartTime!)
                    : "Select Start Time"),
              ],
            ),
            // Select Deadline Date and Select Deadline Time Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () => _selectDeadlineDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
                Text(selectedDeadlineDate != null
                    ? DateFormat('yyyy-MM-dd')
                    .format(selectedDeadlineDate!)
                    : "Select end Date"),
                IconButton(
                  onPressed: () => _selectDeadlineTime(context),
                  icon: Icon(Icons.access_time),
                ),
                Text(selectedDeadlineTime != null
                    ? DateFormat('hh:mm a')
                    .format(selectedDeadlineTime!)
                    : "Select end Time"),
              ],
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: taskController,
                onChanged: (value) {},
                decoration: InputDecoration(
                  hintText: 'Enter description (optional)',
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Row(
                  children: [
                    Checkbox(
                      value: isRepeating,
                      onChanged: (value) {
                        setState(() {
                          isRepeating = value!;
                        });
                      },
                    ),
                    Text('Repeating Task    '),
                  ],
                ),
                Row(
                  children: [
                    Checkbox(
                      value: hasReminder,
                      onChanged: (value) {
                        setState(() {
                          hasReminder = value!;
                        });
                      },
                    ),
                    Text('Set Reminder'),
                  ],
                ),
              ],
            ),
            if (isRepeating)
              Row(
                children: [
                  Text('Repeat Type: '),
                  DropdownButton<RecurrenceType>(
                    value: selectedRecurrenceType,
                    onChanged: (value) {
                      setState(() {
                        selectedRecurrenceType = value;
                      });
                    },
                    items: RecurrenceType.values
                        .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last),
                    ))
                        .toList(),
                  ),
                ],
              ),
            if (isRepeating)
              Row(
                children: [
                  Text('Repeat Frequency: '),
                  DropdownButton<int>(
                    value: selectedRecurrenceFrequency,
                    onChanged: (value) {
                      setState(() {
                        selectedRecurrenceFrequency = value;
                      });
                    },
                    items: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
                        .map((frequency) => DropdownMenuItem(
                      value: frequency,
                      child: Text(frequency.toString()),
                    ))
                        .toList(),
                  ),
                ],
              ),
            if (hasReminder)
              Row(
                children: [
                  Text('Reminder Minutes Before: '),
                  DropdownButton<int>(
                    value: reminderMinutes,
                    onChanged: (value) {
                      setState(() {
                        reminderMinutes = value;
                      });
                    },
                    items: [5, 10, 15, 30, 60]
                        .map((minutes) => DropdownMenuItem(
                      value: minutes,
                      child: Text('$minutes minutes'),
                    ))
                        .toList(),
                  ),
                ],
              ),
            SizedBox(height: 20),
            Row(
              children: [
                Text('Priority Level: '),
                Slider(
                  value: priorityLevel,
                  onChanged: (value) {
                    setState(() {
                      priorityLevel = value;
                    });
                  },
                  min: 1.0,
                  max: 5.0,
                  divisions: 4,
                  label: priorityLevel.toString(),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                addTask(
                  taskController.text,
                  selectedStartDate,
                  descriptionController.text,
                  selectedStartTime,
                );
              },
              child: Text('Add Task'),
            ),
            SizedBox(height: 20),
            Column(
              children: tasks.map((task) {
                return TaskListItem(task: task);
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskListItem extends StatefulWidget {
  final Task task;

  const TaskListItem({required this.task});

  @override
  _TaskListItemState createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  late Timer _timer;
  late int countdown;
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    _calculateCountdown();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _calculateCountdown();
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _calculateCountdown() {
    final currentTime = DateTime.now();
    final timeDifference = widget.task.startTime!.difference(currentTime);
    countdown = timeDifference.inMinutes;
  }

  @override
  Widget build(BuildContext context) {
    final countdownText =
    countdown > 0 ? 'Starts in $countdown minutes' : 'Started';

    return ListTile(
      leading: Container(
        width: 80,
        height: 80,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.pink,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Text(
              countdownText,
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
        ),
      ),
      title: Text(widget.task.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
              'Start Date: ${DateFormat('yyyy-MM-dd').format(widget.task.startTime!)}'),
          Text(
              'Start Time: ${DateFormat('hh:mm a').format(widget.task.startTime!)}'),
          if (widget.task.deadline != null)
            Text(
                'Deadline Date: ${DateFormat('yyyy-MM-dd').format(widget.task.deadline!)}'),
          if (widget.task.deadline != null)
            Text(
                'Deadline Time: ${DateFormat('hh:mm a').format(widget.task.deadline!)}'),
          if (widget.task.description != null &&
              widget.task.description!.isNotEmpty)
            Text('Description: ${widget.task.description}'),
        ],
      ),
      trailing: Checkbox(
        value: isChecked,
        onChanged: (newValue) {
          setState(() {
            isChecked = newValue!;
          });
        },
        activeColor: Colors.green,
        checkColor: Colors.white,
      ),
    );
  }
}
