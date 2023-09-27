import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'calendar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(LoginApp());
}
void main() {
  runApp(TaskReminderApp());
}

class TaskReminderApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Reminder Section',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => TaskReminderScreen(),
        '/calendar': (context) => CalendarViewScreen(),
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

  Task(this.id, this.name, this.deadline, this.description, this.startTime);
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

  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {});
      }
    });
  }

  void addTask(String taskName, DateTime? deadline, String? description, DateTime? startTime) {
    setState(() {
      tasks.add(Task(taskId, taskName, deadline, description, startTime));
      taskId++;
      taskController.clear();
      descriptionController.clear();
      selectedStartDate = null;
      selectedStartTime = null;
      selectedDeadlineDate = null;
      selectedDeadlineTime = null;
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
        title: Text('Task Reminder Section'),
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
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: taskController,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      hintText: 'Enter task',
                    ),
                  ),
                ),
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
            Row(
              children: [
                IconButton(
                  onPressed: () => _selectDeadlineDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
                Text(selectedDeadlineDate != null
                    ? DateFormat('yyyy-MM-dd').format(selectedDeadlineDate!)
                    : "Select Deadline Date"),
                IconButton(
                  onPressed: () => _selectDeadlineTime(context),
                  icon: Icon(Icons.access_time),
                ),
                Text(selectedDeadlineTime != null
                    ? DateFormat('hh:mm a').format(selectedDeadlineTime!)
                    : "Select Deadline Time"),
              ],
            ),
            SizedBox(height: 10),
            TextField(
              controller: descriptionController,
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'Enter description (optional)',
              ),
            ),
            SizedBox(height: 20),
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
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/calendar');
              },
              child: Text('Calendar View'),
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
  bool isChecked=false;

  @override
  void initState() {
    super.initState();
    _calculateCountdown();
    // Update the countdown timer every second
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
    final countdownText = countdown > 0 ? 'Starts in $countdown minutes' : 'Started';

    return ListTile(
      leading: Container(
        width: 80, // Adjust the width to your preference
        height: 80, // Adjust the height to your preference
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.pink, // You can use any color you like
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5.0), // Adjust the padding as needed
            child: Text(
              countdownText,
              style: TextStyle(color: Colors.white, fontSize: 12), // Adjust font size as needed
            ),
          ),
        ),
      ),
      title: Text(widget.task.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Start Date: ${DateFormat('yyyy-MM-dd').format(widget.task.startTime!)}'),
          Text('Start Time: ${DateFormat('hh:mm a').format(widget.task.startTime!)}'),
          if (widget.task.deadline != null)
            Text('Deadline Date: ${DateFormat('yyyy-MM-dd').format(widget.task.deadline!)}'),
          if (widget.task.deadline != null)
            Text('Deadline Time: ${DateFormat('hh:mm a').format(widget.task.deadline!)}'),
          if (widget.task.description != null && widget.task.description!.isNotEmpty)
            Text('Description: ${widget.task.description}'),
        ],
      ),
      trailing: Checkbox(
        value: isChecked, // Use the isChecked state
        onChanged: (newValue) {
          // Handle checkbox state change here
          setState(() {
            isChecked = newValue!;
          });
        },
        activeColor: Colors.green, // Change the checkbox color to green
        checkColor: Colors.white, // Change the checkmark color to white
      ),
    );
  }
}



class CalendarViewScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calendar View'),
      ),
      body: Center(
        child: Text('This is the Calendar View screen.'),
      ),
    );
  }
}







