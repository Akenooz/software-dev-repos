import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'task.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const CalendarViewScreen(tasks: []);
  }
}

class CalendarViewScreen extends StatefulWidget {
  final List<Task> tasks;

  const CalendarViewScreen({
    required this.tasks,
    Key? key,
  }) : super(key: key);

  @override
  CalendarViewScreenState createState() => CalendarViewScreenState();
}

class CalendarViewScreenState extends State<CalendarViewScreen> {
  final PageController _pageController =
  PageController(initialPage: DateTime.now().month - 1);

  int currentPageIndex = DateTime.now().month - 1; // Store the current page index here

  List<Task> getTasksForDate(DateTime date) {
    return widget.tasks.where((task) {
      if (task.deadline != null) {
        return task.deadline!.year == date.year &&
            task.deadline!.month == date.month &&
            task.deadline!.day == date.day;
      }
      return false;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar View'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  onPressed: () {
                    _pageController.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
                Text(
                  DateFormat('MMMM yyyy').format(
                    DateTime.now().add(
                      Duration(days: 30 * currentPageIndex), // Use currentPageIndex
                    ),
                  ),
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                IconButton(
                  onPressed: () {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: 12,
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index; // Update the current page index
                });
              },
              itemBuilder: (context, monthIndex) {
                final currentDate = DateTime.now()
                    .subtract(Duration(days: DateTime.now().day - 1));
                final date = currentDate.add(
                    Duration(days: DateTime.now().day - 1 + 30 * monthIndex));

                final firstDayOfWeek =
                    DateTime(date.year, date.month, 1).weekday;
                final lastDayOfMonth =
                    DateTime(date.year, date.month + 1, 0).day;

                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                  ),
                  itemCount: date.month == DateTime.now().month ? 35 : 42,
                  itemBuilder: (context, index) {
                    if (index < firstDayOfWeek - 1 ||
                        index > lastDayOfMonth + firstDayOfWeek - 2) {
                      return Container();
                    }

                    final day = index - firstDayOfWeek + 2;

                    final tasksForDay =
                    getTasksForDate(DateTime(date.year, date.month, day));

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                        ),
                        child: Column(
                          children: [
                            if (index == 0 || day == 1)
                              Text(
                                DateFormat('MMM').format(date),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            Text(
                              '$day',
                            ),
                            Expanded(
                              child: ListView.builder(
                                itemCount: tasksForDay.length,
                                itemBuilder: (context, taskIndex) {
                                  final task = tasksForDay[taskIndex];
                                  return ListTile(
                                    title: Text(task.name),
                                    subtitle: task.deadline != null
                                        ? Text(
                                      DateFormat('hh:mm a')
                                          .format(task.deadline!),
                                    )
                                        : const Text('No deadline'),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    const MaterialApp(home: MyApp()), // use MaterialApp
  );
}

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text("Something"))
    );
  }
}