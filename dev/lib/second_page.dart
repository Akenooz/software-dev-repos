import 'package:flutter/material.dart';

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
                addTask(title, selectedDate, selectedStartTime, selectedEndTime, location, text);
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
