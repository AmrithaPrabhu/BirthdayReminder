import 'dart:io';
import 'dart:ui';
import 'package:birthday_reminder/friend_form.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:birthday_reminder/model/Friend.dart'; // Make sure this exists
import 'package:table_calendar/table_calendar.dart';

import 'month_year_picker.dart';

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
  bool isFormVisible = false;

  @override
  void initState() {
    super.initState();
    today = DateTime.now();
    incrementedByYear = today.add(const Duration(days: 365));
  }

  void _closeForm() {
    setState(() {
      isFormVisible = false;  // Close the form when the cross icon is clicked
    });
  }

  // Show Friend Form Modal
  void _showFriendForm() {
    setState(() {
      isFormVisible = !isFormVisible;
    });
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  Future<void> _showCustomDatePicker() async {
    try {
      final result = await showDialog(
        context: context,
        builder: (context) => MonthYearPickerDialog(
          initialMonth: today.month,
          initialYear: today.year,
        ),
      );

      if (result != null && result is Map) {
        final selectedDate = DateTime(result['year'], result['month'], 1);
        final oneYearFromToday = today.add(const Duration(days: 365));

        // Check if the selected date is more than a year ahead
        if (selectedDate.isAfter(oneYearFromToday)) {
          throw Exception("You cannot select a date more than a year ahead.");
        }

        // Update the selected day if the date is valid
        setState(() {
          _selectedDay = selectedDate;
          today = selectedDate;
        });
      }
    } catch (e) {
      // Show error using SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error: ${e.toString()}"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white, // Text color
        backgroundColor: const Color(0xFF492B3F),
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          // Background: Table Calendar
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(20),
              child: GestureDetector(
                onDoubleTap: _showCustomDatePicker,  // Tap to open form
                child: TableCalendar(
                  daysOfWeekHeight: 50,
                  rowHeight: 70,
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
                    outsideDaysVisible: false,
                  ),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    titleTextFormatter: (date, locale) => '${_monthName(date.month)} ${date.year}',
                  ),
                ),
              ),
            ),
          ),

          // Blurred Background when form is visible
          if (isFormVisible)
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Adjust blur level
                child: Container(
                  color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                ),
              ),
            ),

          // FriendForm on top
          if (isFormVisible)
            Center(
              child: FriendForm(isFormVisible: isFormVisible, onClose: _closeForm),
            ),
        ],
      ),
      floatingActionButton: _selectedDay != null
          ? FloatingActionButton(
        onPressed: _showFriendForm,
        child: const Icon(Icons.add),
        backgroundColor: const Color(0xFFA28999),
      )
          : null,
    );
  }
}
