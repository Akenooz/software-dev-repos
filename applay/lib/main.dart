import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: CalendarViewScreen(),
    );
  }
}

class CalendarViewScreen extends StatefulWidget {
  const CalendarViewScreen({Key? key});

  @override
  _CalendarViewScreenState createState() => _CalendarViewScreenState();
}

class _CalendarViewScreenState extends State<CalendarViewScreen> {
  DateTime today = DateTime.now();

  void onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome To Code Daily!"),
      ),
      body: content(),
    );
  }

  Widget content() {
    final DateTime firstDay = DateTime(DateTime.now().year - 1);
    final DateTime lastDay = DateTime(DateTime.now().year + 1);

    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          Container(
            child: TableCalendar(
              locale: "en_US",
              selectedDayPredicate: (day) => isSameDay(day, today),
              focusedDay: today,
              firstDay: firstDay,
              lastDay: lastDay,
              onDaySelected: onDaySelected,
            ),
          ),
        ],
      ),
    );
  }
}
