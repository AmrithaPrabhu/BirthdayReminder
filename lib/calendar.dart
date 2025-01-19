import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarComponent extends StatefulWidget {
  const CalendarComponent({super.key, required this.title});
  final String title;

  @override
  _CalendarComponentState createState() => _CalendarComponentState();
}

class _CalendarComponentState extends State<CalendarComponent> {
  CalendarFormat _calendarFormat = CalendarFormat.month;
  late DateTime today;
  late DateTime incrementedByYear;
  DateTime? _selectedDay;
  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    incrementedByYear = today.add(const Duration(days: 365));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white, // Text color
        backgroundColor: const Color(0xFF492B3F),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(20), // Added some padding for better layout
          child: TableCalendar(
            locale: "en_US",
            focusedDay: today,
            firstDay: DateTime.utc(1950, 01, 01),
            lastDay: incrementedByYear,
            calendarFormat: _calendarFormat,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                if (isSameDay(_selectedDay, selectedDay)) {
                  _selectedDay = null;
                } else {
                  _selectedDay = selectedDay;
                }
                today = focusedDay;
              });
            },
            onFormatChanged: (format) {
              setState(() {
                _calendarFormat = format;
              });
            },
            calendarStyle: CalendarStyle(
              todayDecoration: BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
              selectedDecoration: BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              outsideDaysVisible: false, // Hide days from other months
            ),
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
            ), // Hide format button for cleaner UI
          ),
        ),
      ),

      floatingActionButton: _selectedDay!=null ? FloatingActionButton(
        onPressed: () {
          // Add event logic here

        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ) : null,
    );
  }
}
