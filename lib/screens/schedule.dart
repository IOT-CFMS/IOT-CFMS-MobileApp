import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ShiftScheduleScreen extends StatefulWidget {
  const ShiftScheduleScreen({super.key});

  @override
  State<ShiftScheduleScreen> createState() => _ShiftScheduleScreenState();
}

class _ShiftScheduleScreenState extends State<ShiftScheduleScreen> {
  DateTime weekStart = DateTime(2025, 7, 14);
  int selectedDateIndex = 0;

  final List<Map<String, dynamic>> weeklyShifts = [
    {
      'date': '14/7',
      'weekday': 'Mon',
      'shifts': [
        {'slot': 'Morning', 'time': '6:00 - 14:00', 'status': 'present'},
        {'slot': 'Afternoon', 'time': '14:00 - 22:00', 'status': 'off'},
      ]
    },
    {
      'date': '15/7',
      'weekday': 'Tue',
      'shifts': [
        {'slot': 'Night', 'time': '22:00 - 06:00', 'status': 'present'},
      ]
    },
    {
      'date': '16/7',
      'weekday': 'Wed',
      'shifts': [],
    },
    {
      'date': '17/7',
      'weekday': 'Thu',
      'shifts': [
        {'slot': 'Morning', 'time': '6:00 - 14:00', 'status': 'present'},
      ]
    },
    {
      'date': '18/7',
      'weekday': 'Fri',
      'shifts': [
        {'slot': 'Afternoon', 'time': '14:00 - 22:00', 'status': 'not yet'},
      ]
    },
    {
      'date': '19/7',
      'weekday': 'Sat',
      'shifts': [],
    },
    {
      'date': '20/7',
      'weekday': 'Sun',
      'shifts': [],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final currentWeek = DateFormat('dd/MM/yyyy').format(weekStart) +
        ' - ' +
        DateFormat('dd/MM/yyyy').format(weekStart.add(const Duration(days: 6)));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Weekly Shift Timetable"),
        backgroundColor: Colors.orange,
        elevation: 0,
      ),
      body: Column(
        children: [
          Text(
            "Current week: $currentWeek",
            style: const TextStyle(color: Colors.blue),
          ),
          const SizedBox(height: 8),
          _buildDateSelector(),
          const Divider(thickness: 1),
          Expanded(
            child: _buildDayShiftList(),
          ),
        ],
      ),
    );
  }

  Widget _buildTermTabs() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildTab("SUMMER2025", true),
        const SizedBox(width: 8),
        _buildTab("SPRING2025", false),
        const SizedBox(width: 8),
        _buildTab("FALL2024", false),
      ],
    );
  }

  Widget _buildTab(String title, bool active) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: active ? Colors.orange : Colors.white,
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: active ? Colors.white : Colors.orange,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          final day = weekStart.add(Duration(days: index));
          final weekday = DateFormat('E').format(day);
          final dayNumber = day.day.toString();

          final isSelected = selectedDateIndex == index;

          return GestureDetector(
            onTap: () => setState(() => selectedDateIndex = index),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  Text(weekday),
                  const SizedBox(height: 4),
                  CircleAvatar(
                    backgroundColor: isSelected ? Colors.orange : Colors.grey[300],
                    radius: 16,
                    child: Text(
                      dayNumber,
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDayShiftList() {
    final selectedDay = weeklyShifts[selectedDateIndex];

    if (selectedDay['shifts'].isEmpty) {
      return const Center(
        child: Text(
          "No shifts scheduled.",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: selectedDay['shifts'].length,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      itemBuilder: (context, index) {
        final shift = selectedDay['shifts'][index];

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.orange.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Slot: ${shift['slot']}',
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                'Time: ${shift['time']}',
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  _buildStatusChip(shift['status']),
                  const SizedBox(width: 10),
                  _buildMaterialButton(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatusChip(String status) {
    Color bgColor;
    String text = status.toUpperCase();

    switch (status) {
      case 'present':
        bgColor = Colors.green;
        break;
      case 'not yet':
        bgColor = Colors.black45;
        break;
      case 'off':
        bgColor = Colors.grey;
        break;
      default:
        bgColor = Colors.blue;
    }

    return Chip(
      label: Text(text, style: const TextStyle(color: Colors.white)),
      backgroundColor: bgColor,
    );
  }

  Widget _buildMaterialButton() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text(
        'Materials',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
