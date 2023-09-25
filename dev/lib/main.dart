import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'dart:collection';

void main() {
  runApp(MyApp());
}

class Event {
  final String title;
  final DateTime date;

  Event(this.title, this.date);
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  LinkedHashMap<DateTime, List<Event>> events = LinkedHashMap(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  // Define light and dark themes
  final ThemeData lightTheme = ThemeData.light().copyWith(
    // Configure the light theme here
  );

  final ThemeData darkTheme = ThemeData.dark().copyWith(
    // Configure the dark theme here
  );

  ThemeMode _themeMode = ThemeMode.light;

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  void initState() {
    super.initState();
    _generateEvents();
  }

  // Generate example events
  void _generateEvents() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final oneDay = Duration(days: 1);

    events = LinkedHashMap(
      equals: isSameDay,
      hashCode: getHashCode,
    );

    for (int i = 0; i < 5; i++) {
      final day = today.add(Duration(days: i));
      final eventsForDay = <Event>[
        Event('Event 1', day.add(Duration(hours: 9))),
        Event('Event 2', day.add(Duration(hours: 14))),
      ];

      events[day] = eventsForDay;
    }
  }

  List<Event> _getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: _themeMode,
      home: Scaffold(
        appBar: AppBar(
          title: Text("🗓️ Day Planner"), // Replace with your app's title
          actions: [
            IconButton(
              icon: Icon(Icons.account_circle), // Account icon
              onPressed: () {
                // Handle account button press
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: Container(
            color: darkTheme.appBarTheme.backgroundColor,
            height: MediaQuery.of(context).size.height * 0.8,
            child: ListView(
              children: [
                DrawerHeader(
                  child: Center(
                    child: Text(
                      "Day Planner 🗓️",
                      style: TextStyle(fontSize: 32),
                    ),
                  ),
                ),
                ListTile(
                  title: Text("Day View"),
                  onTap: () {
                    // Handle day view
                  },
                ),
                ListTile(
                  title: Text("3-Day View"),
                  onTap: () {
                    // Handle 3-day view
                  },
                ),
                ListTile(
                  title: Text("Week View"),
                  onTap: () {
                    // Handle week view
                  },
                ),
                ListTile(
                  title: Text("Month View"),
                  onTap: () {
                    // Handle month view
                  },
                ),
                Divider(),
                ListTile(
                  title: Text("Holidays"),
                  leading: Checkbox(
                    value: false, // Replace with the holiday checkbox value
                    onChanged: (value) {
                      // Handle holiday checkbox
                    },
                  ),
                ),
                ListTile(
                  title: Text("Events"),
                  leading: Checkbox(
                    value: false, // Replace with the events checkbox value
                    onChanged: (value) {
                      // Handle events checkbox
                    },
                  ),
                ),
                ListTile(
                  title: Text("Tasks"),
                  leading: Checkbox(
                    value: false, // Replace with the tasks checkbox value
                    onChanged: (value) {
                      // Handle tasks checkbox
                    },
                  ),
                ),
                ListTile(
                  title: Text("Toggle Theme"),
                  leading: Icon(Icons.brightness_4),
                  onTap: _toggleTheme,
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                TableCalendar(
                  firstDay: DateTime.utc(2010, 10, 16),
                  lastDay: DateTime.utc(2030, 3, 14),
                  focusedDay: _focusedDay,
                  calendarFormat: _calendarFormat,
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay ?? selectedDay;
                    });
                  },
                  eventLoader: (day) {
                    return _getEventsForDay(day);
                  },
                  rowHeight: 30,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.black,
                    ),
                    weekendStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: Colors.red,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _getEventsForDay(_selectedDay).length,
                    itemBuilder: (context, index) {
                      final event = _getEventsForDay(_selectedDay)[index];
                      return ListTile(
                        title: Text(event.title),
                        subtitle: Text(DateFormat('hh:mm a').format(event.date)),
                      );
                    },
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => TaskAddingPage()),
                  );
                },
                child: Icon(Icons.add),

              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TaskAddingPage extends StatefulWidget {
  @override
  _TaskAddingPageState createState() => _TaskAddingPageState();
}

class _TaskAddingPageState extends State<TaskAddingPage> {
  String title = '';
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String location = '';
  String text = '';

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedStartTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedStartTime) {
      setState(() {
        selectedStartTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedEndTime ?? TimeOfDay.now(),
    );
    if (picked != null && picked != selectedEndTime) {
      setState(() {
        selectedEndTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              onChanged: (value) {
                setState(() {
                  title = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Title',
              ),
            ),
            Row(
              children: [
                Text('Date: ${selectedDate?.toLocal()}'.split(' ')[0]),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _selectDate(context),
                  child: Text('Select Date'),
                ),
              ],
            ),
            Row(
              children: [
                Text('Start Time: ${selectedStartTime?.format(context) ?? ''}'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _selectStartTime(context),
                  child: Text('Select'),
                ),
              ],
            ),
            Row(
              children: [
                Text('End Time: ${selectedEndTime?.format(context) ?? ''}'),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => _selectEndTime(context),
                  child: Text('Select'),
                ),
              ],
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  location = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Location',
              ),
            ),
            TextField(
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
              decoration: InputDecoration(
                labelText: 'Text',
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Add the task to your task list or database
                // You can use the title, selectedDate, selectedStartTime, selectedEndTime, location, and text variables
                // to access the entered values and save them.
                // For example, you can call a function like addTask(title, selectedDate, selectedStartTime, selectedEndTime, location, text)
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}

void addTask(
    String title,
    DateTime? selectedDate,
    TimeOfDay? selectedStartTime,
    TimeOfDay? selectedEndTime,
    String location,
    String text,
    ) {
  // Implement your task addition logic here
}
// A function to generate a unique hash code for a DateTime
int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
