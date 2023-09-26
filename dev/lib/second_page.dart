import 'package:flutter/material.dart';

class TaskAddingPage extends StatefulWidget {
  @override
  _TaskAddingPageState createState() => _TaskAddingPageState();
}

class _TaskAddingPageState extends State<TaskAddingPage> {
  // State variables to store user input
  String title = '';
  DateTime? selectedDate;
  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;
  String location = '';
  String text = '';

  // Function to open a date picker dialog
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

  // Function to open a time picker dialog (for both start and end times)
  Future<void> _selectTime(BuildContext context, bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime
          ? (selectedStartTime ?? TimeOfDay.now())
          : (selectedEndTime ?? TimeOfDay.now()),
    );
    if (picked != null) {
      setState(() {
        if (isStartTime) {
          selectedStartTime = picked;
        } else {
          selectedEndTime = picked;
        }
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Input field for the task title
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
              SizedBox(height: 16.0), // Spacer

              // Row to select the task date
              Row(
                children: [
                  Text('Date: ${selectedDate?.toLocal()}'.split(' ')[0]),
                  SizedBox(width: 20), // Spacer
                  ElevatedButton(
                    onPressed: () => _selectDate(context),
                    child: Text('Select Date'),
                  ),
                ],
              ),
              SizedBox(height: 16.0), // Spacer

              // Row to select the task start time
              Row(
                children: [
                  Text('Start Time: ${selectedStartTime?.format(context) ?? ''}'),
                  SizedBox(width: 20), // Spacer
                  ElevatedButton(
                    onPressed: () => _selectTime(context, true),
                    child: Text('Select'),
                  ),
                ],
              ),
              SizedBox(height: 16.0), // Spacer

              // Row to select the task end time
              Row(
                children: [
                  Text('End Time: ${selectedEndTime?.format(context) ?? ''}'),
                  SizedBox(width: 20), // Spacer
                  ElevatedButton(
                    onPressed: () => _selectTime(context, false),
                    child: Text('Select'),
                  ),
                ],
              ),
              SizedBox(height: 16.0), // Spacer

              // Input field for task location
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
              SizedBox(height: 16.0), // Spacer

              // Input field for task description
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
              SizedBox(height: 16.0), // Spacer

              // Button to add the task
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
      ),
    );
  }
}

// Function to handle adding a task (to be implemented)
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
