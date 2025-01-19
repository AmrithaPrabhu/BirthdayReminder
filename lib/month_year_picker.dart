import 'package:flutter/material.dart';

class MonthYearPickerDialog extends StatefulWidget {
  final int initialMonth;
  final int initialYear;

  const MonthYearPickerDialog({
    Key? key,
    required this.initialMonth,
    required this.initialYear,
  }) : super(key: key);

  @override
  _MonthYearPickerDialogState createState() => _MonthYearPickerDialogState();
}

class _MonthYearPickerDialogState extends State<MonthYearPickerDialog> {
  late int selectedMonth;
  late int selectedYear;

  @override
  void initState() {
    super.initState();
    selectedMonth = widget.initialMonth;
    selectedYear = widget.initialYear;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Month and Year"),
      content: Row(
        children: [
          // Dropdown for selecting the month
          Expanded(
            child: DropdownButton<int>(
              value: selectedMonth,
              onChanged: (int? newValue) {
                setState(() {
                  selectedMonth = newValue!;
                });
              },
              items: List.generate(12, (index) => index + 1)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    _monthName(value),
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 10),
          // Dropdown for selecting the year
          Expanded(
            child: DropdownButton<int>(
              value: selectedYear,
              onChanged: (int? newValue) {
                setState(() {
                  selectedYear = newValue!;
                });
              },
              items: List.generate(100, (index) => 1950 + index)
                  .map<DropdownMenuItem<int>>((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: const TextStyle(fontSize: 16),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () => Navigator.pop(
            context,
            {'month': selectedMonth, 'year': selectedYear},
          ),
          child: const Text("OK"),
        ),
      ],
    );
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
}
