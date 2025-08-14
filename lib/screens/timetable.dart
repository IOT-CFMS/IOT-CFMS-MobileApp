import 'package:flutter/material.dart';
import 'package:coffee_app/common/colors.dart'; // Your color file

class WeeklyTimetableScreen extends StatefulWidget {
  const WeeklyTimetableScreen({super.key});

  @override
  State<WeeklyTimetableScreen> createState() => _WeeklyTimetableScreenState();
}

class _WeeklyTimetableScreenState extends State<WeeklyTimetableScreen> {
  DateTime currentWeekStart = DateTime(2025, 7, 14);
  int selectedDayIndex = 0;

  void _changeWeek(int offset) {
    setState(() {
      currentWeekStart = currentWeekStart.add(Duration(days: offset * 7));
    });
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}";
  }

  List<String> weekDays = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];

  @override
  Widget build(BuildContext context) {
    DateTime weekEnd = currentWeekStart.add(const Duration(days: 6));

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Week navigation
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () => _changeWeek(-1),
                  ),
                  Column(
                    children: [
                      Text(
                        "Current week: ${_formatDate(currentWeekStart)} - ${_formatDate(weekEnd)}",
                        style: TextStyle(
                          color: AppColors.lightThemePrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${currentWeekStart.month.toString().padLeft(2, '0')}/${currentWeekStart.year}",
                        style: TextStyle(
                          color: AppColors.lightThemePrimaryColorLight,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () => _changeWeek(1),
                  ),
                ],
              ),
            ),

            // Day selector
            SizedBox(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(7, (index) {
                  DateTime day = currentWeekStart.add(Duration(days: index));
                  bool isSelected = index == selectedDayIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedDayIndex = index;
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          weekDays[index],
                          style: TextStyle(
                            color: isSelected
                                ? AppColors.white
                                : AppColors.lightThemePrimaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Container(
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.lightThemePrimaryColorLight
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            "${day.day}",
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.white
                                  : AppColors.lightThemePrimaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 8),

            // Timetable list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: 3, // sample
                itemBuilder: (context, index) {
                  return _buildClassCard();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildClassCard() {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Slot and time
            Row(
              children: [
                Column(
                  children: [
                    Text("Slot 1", style: TextStyle(color: AppColors.black)),
                    const SizedBox(height: 4),
                    Text("07:00\n09:15",
                        style: TextStyle(color: AppColors.black, fontSize: 12)),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Room: NVH 417",
                        style: TextStyle(
                          color: AppColors.lightThemePrimaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "Subject Code: VNR202",
                        style: TextStyle(color: Colors.brown),
                      ),
                      Text("SessionNo: 7"),
                      Text("Group class: SE1755"),
                      Text("Lecturer: thanhg"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Status & materials
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: const Text(
                    "present",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.orange,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  child: const Text(
                    "Materials",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
