import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class DateSelector extends StatefulWidget {
  final ValueChanged<DateTime> onDateSelected;

  const DateSelector({
    super.key,
    required this.onDateSelected,
  });

  @override
  _DateSelectorState createState() => _DateSelectorState();
}

class _DateSelectorState extends State<DateSelector> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        DateTime nextDate = DateTime.now().add(Duration(days: index + 1));
        bool isSelected = selectedDate != null &&
            selectedDate!.year == nextDate.year &&
            selectedDate!.month == nextDate.month &&
            selectedDate!.day == nextDate.day;
        
        return Padding(
          padding: const EdgeInsets.only(right: 15),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedDate = nextDate;
              });
              widget.onDateSelected(nextDate);
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color:  AppColors.thirdColor),
                color: isSelected ? AppColors.thirdColor.withOpacity(0.2) : Colors.transparent,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(DateFormat('EEEE').format(nextDate)), // Day name
                  Constants.spaceHight10,
                  Text(DateFormat('dd').format(nextDate), style: const TextStyle(fontWeight: FontWeight.bold)), // Date
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
