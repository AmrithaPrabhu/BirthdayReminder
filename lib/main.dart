import 'package:birthday_reminder/calendar.dart';
import 'package:birthday_reminder/profile_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Birthday Reminder App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF492B3F)),
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      home: const MyHomePage(title: 'Birthday Reminder App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String currentMonthStr = DateFormat('MMMM').format(now);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF492B3F),
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildBirthdaysTodaySection(),
            const SizedBox(height: 15),
            _buildBirthdaysInMonthSection(currentMonthStr),
            // Add a Birthday Button (Optional)
            _buildAddBirthdayButton(context),
          ],
        ),
      ),
    );
  }

  // Widget for 'Birthdays Today' section
  Widget _buildBirthdaysTodaySection() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 21),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Birthdays Today",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 21),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildBirthdayItem("Name", "assets/images/trial_dp.png"),
                const SizedBox(width: 20),
                _buildBirthdayItem("Name", "assets/images/trial_dp.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget for 'Birthdays in current month' section
  Widget _buildBirthdaysInMonthSection(String currentMonthStr) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Birthdays in $currentMonthStr",
              style: const TextStyle(fontSize: 20),
            ),
              const SizedBox(height: 15,),
              Scrollbar(
                thumbVisibility: true,
                child: SizedBox(height: 300,
                    child: ProfileList()),
              )
          ],
        ),
      ),
    );
  }

  // Helper function to build each birthday item
  Widget _buildBirthdayItem(String name, String imagePath) {
    return Column(
      children: [
        CircleAvatar(
          foregroundImage: AssetImage(imagePath),
          radius: 45,
          child: ClipOval(
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              width: 100,
              height: 100,
            ),
          ),
        ),
        Text(
          name,
          style: const TextStyle(fontSize: 15),
        ),
      ],
    );
  }

// Optional: Button to add a birthday (uncomment if needed)
Widget _buildAddBirthdayButton(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: ElevatedButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CalendarComponent(
              title: "Birthday Reminder App",
            ),
          ),
        );
      },
      child: const Text("Add a Birthday"),
    ),
  );
}
}
