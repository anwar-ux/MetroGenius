import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/src/employee/screens/home/bloc/get_service_requestes/get_service_request_bloc.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class EmployeeSchedule extends StatefulWidget {
  EmployeeSchedule({super.key});

  @override
  _EmployeeScheduleState createState() => _EmployeeScheduleState();
}

class _EmployeeScheduleState extends State<EmployeeSchedule> {
  DateTime _selectedDate = DateTime.now(); // Initialize to today's date
  final Set<DateTime> bookedSlots = {};

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

  List<DateTime> _generateDates() {
    DateTime today = DateTime.now();
    int daysInMonth = DateTime(today.year, today.month + 1, 0).day;

    return List.generate(daysInMonth, (index) => DateTime(today.year, today.month, index + 1));
  }

  @override
  Widget build(BuildContext context) {
    final List<DateTime> dates = _generateDates();
    final List<String> timeSlots = _generateTimeSlots();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Schedule'),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: BlocProvider(
        create: (context) => GetServiceRequestBloc()..add(FetchCommitedRequestData()),
        child: BlocConsumer<GetServiceRequestBloc, GetServiceRequestState>(
          listener: (context, state) {
            if (state is GetRequestLoaded) {
              bookedSlots.clear();
              for (var doc in state.data) {
                final scheduledString = doc['DateTime'] as String;
                try {
                  final bookedSlot = parseScheduledDateTime(scheduledString);
                  bookedSlots.add(bookedSlot);
                } catch (e) {
                  print('Error parsing date: $e');
                }
              }
              // Update the state to reflect any changes in booked slots
              setState(() {});
            }
          },
          builder: (context, state) {
            if (state is GetRequestLoaded) {
              // Filter booked slots for the selected date
              final filteredBookedSlots = bookedSlots.where((slot) =>
                  slot.year == _selectedDate.year &&
                  slot.month == _selectedDate.month &&
                  slot.day == _selectedDate.day).toList();

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Date Slots:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Constants.spaceHight10,
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: dates.length,
                        itemBuilder: (context, index) {
                          final nextDate = dates[index];
                          // Check if the date is the selected date
                          final isSelected = nextDate.year == _selectedDate.year &&
                              nextDate.month == _selectedDate.month &&
                              nextDate.day == _selectedDate.day;

                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDate = nextDate; // Update selected date
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: AppColors.thirdColor),
                                  color: isSelected ? AppColors.thirdColor.withOpacity(0.2) : Colors.transparent,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(DateFormat('EEEE').format(nextDate)), // Day name
                                    Constants.spaceHight10,
                                    Text(
                                      DateFormat('dd').format(nextDate),
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ), // Date
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Constants.spaceHight10,
                    const Divider(
                      color: AppColors.lightGrey,
                    ),
                    Constants.spaceHight10,
                    const Text(
                      'Time Slots:',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Constants.spaceHight10,
                    SizedBox(
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          final timeSlot = timeSlots[index];
                          final isBooked = filteredBookedSlots.any((slot) => DateFormat('hh:mm a').format(slot) == timeSlot);

                          return GestureDetector(
                            onTap: () {
                              // Handle time slot selection
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: AppColors.thirdColor),
                                color: isBooked ? AppColors.thirdColor.withOpacity(0.2) : Colors.transparent,
                              ),
                              child: Center(
                                child: Text(
                                  timeSlot,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: timeSlots.length,
                      ),
                    ),
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

// Function to extract and parse the scheduled DateTime from the combined string
DateTime parseScheduledDateTime(String combinedString) {
  try {
    final datePattern = RegExp(r'Scheduled Date : ([^ ]+ \d{1,2})'); // e.g., "August 14"
    final timePattern = RegExp(r'Scheduled Time : (.+)'); // e.g., "09:00 AM"

    final dateMatch = datePattern.firstMatch(combinedString);
    final timeMatch = timePattern.firstMatch(combinedString);

    if (dateMatch == null || timeMatch == null) {
      throw FormatException('Invalid format: unable to match date or time');
    }

    final dateString = dateMatch.group(1);
    final timeString = timeMatch.group(1);

    if (dateString == null || timeString == null) {
      throw FormatException('Invalid format: date or time string is null');
    }

    final dateFormat = DateFormat('MMMM d'); // Format for "August 14"
    final timeFormat = DateFormat('hh:mm a'); // Format for "09:00 AM"

    final date = dateFormat.parse(dateString);
    final time = timeFormat.parse(timeString);

    return DateTime(DateTime.now().year, date.month, date.day, time.hour, time.minute);
  } catch (e) {
    throw FormatException('Invalid scheduled date-time format: $e');
  }
}
