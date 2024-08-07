import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class TimeSelector extends StatefulWidget {
  final ValueChanged<String> onTimeSelected;

  const TimeSelector({
    super.key,
    required this.onTimeSelected,
  });

  @override
  _TimeSelectorState createState() => _TimeSelectorState();
}

class _TimeSelectorState extends State<TimeSelector> {
  String? selectedTime;

  List<String> _generateTimeSlots() {
    List<String> timeSlots = [];
    DateTime startTime = DateTime(0, 1, 1, 8, 0);
    DateTime endTime = DateTime(0, 1, 1, 18, 0);
    while (startTime.isBefore(endTime) || startTime == endTime) {
      String time = DateFormat('hh:mm a').format(startTime);
      timeSlots.add(time);
      startTime = startTime.add(const Duration(minutes: 60));
    }
    return timeSlots;
  }

  @override
  Widget build(BuildContext context) {
    List<String> timeSlots = _generateTimeSlots();
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
      itemBuilder: (context, index) {
        bool isSelected = selectedTime == timeSlots[index];
        return GestureDetector(
          onTap: () {
            setState(() {
              selectedTime = timeSlots[index];
            });
            widget.onTimeSelected(timeSlots[index]);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: AppColors.thirdColor),
              color: isSelected ? AppColors.thirdColor.withOpacity(0.2) : Colors.transparent,
            ),
            child: Center(
              child: Text(
                timeSlots[index],
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        );
      },
      itemCount: timeSlots.length,
    );
  }
}
