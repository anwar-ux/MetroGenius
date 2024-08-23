import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:metrogeniusorg/src/employee/screens/home/widgets/custom_worker_button.dart';
import 'package:metrogeniusorg/src/userside/screens/booking/bloc/rating_and_review_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/booking/widgets/rating_star.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/servicebooking/service_booking_bloc.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class RequestListBuilder extends StatefulWidget {
  final List<DocumentSnapshot<Object?>> requests;

  RequestListBuilder({required this.requests});

  @override
  _RequestListBuilderState createState() => _RequestListBuilderState();
}

class _RequestListBuilderState extends State<RequestListBuilder> {
  int? selectedIndex; // Tracks which item is selected to show the rating screen

  Future<Map<String, String>> getWorkerDetails(String workerId) async {
    try {
      final workerSnapshot = await FirebaseFirestore.instance.collection("Workers").doc(workerId).get();

      if (workerSnapshot.exists) {
        return {
          'name': workerSnapshot['Name'] as String,
          'photoUrl': workerSnapshot['Image'] as String,
        };
      } else {
        return {
          'name': 'Unknown',
          'photoUrl': '', // Provide a placeholder image URL if needed
        };
      }
    } catch (e) {
      return {
        'name': 'Error',
        'photoUrl': '', // Provide a placeholder image URL if needed
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: widget.requests.length,
      itemBuilder: (context, index) {
        final doc = widget.requests[index];
        final Timestamp time = doc['CreatAt'];
        final String workerId = doc['WorkerId'];
        context.read<RatingAndReviewBloc>().add(ServiceNameChanged(serviceName: doc['ServiceTitle']));
        return Padding(
          padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.primaryColor,
              boxShadow: [
                BoxShadow(
                  color: AppColors.lightGrey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                  blurStyle: BlurStyle.normal,
                ),
              ],
              borderRadius: BorderRadius.circular(6),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${doc['ServiceTitle']}",
                            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            DateFormat('hh:mm a').format(time.toDate()),
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                      Text('${doc['Discription']}'),
                      Constants.spaceHight5,
                      Row(
                        children: [
                          Icon(Icons.location_on_rounded),
                          SizedBox(width: 8), // Add some space between the icon and the text
                          Flexible(
                            child: Text(
                              '${doc['Address']}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      Constants.spaceHight5,
                      Row(
                        children: [
                          Icon(Icons.calendar_month_outlined),
                          SizedBox(width: 8), // Add some space between the icon and the text
                          Flexible(
                            child: Text(
                              '${doc['DateTime']}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: AppColors.lightGrey,
                      ),
                      if (doc['RequestStatus'] == RequestStatus.accepted.toString())
                        FutureBuilder<Map<String, String>>(
                          future: getWorkerDetails(workerId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasError || !snapshot.hasData) {
                              return const Text('Error loading worker details');
                            }

                            final workerName = snapshot.data!['name']!;
                            final workerPhoto = snapshot.data!['photoUrl']!;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(workerPhoto),
                                      radius: 25,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(workerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text(
                                          'Service provider',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                ElevatedButton(
                                  onPressed: () {},
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.message_rounded,
                                        color: AppColors.primaryColor,
                                      ),
                                      Constants.spaceWidth10,
                                      Text(
                                        'Chat',
                                        style: TextStyle(color: AppColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                  style: ButtonStyle(backgroundColor: WidgetStatePropertyAll(AppColors.thirdColor)),
                                )
                              ],
                            );
                          },
                        )
                      else if (doc['RequestStatus'] == RequestStatus.completed.toString())
                        FutureBuilder<Map<String, String>>(
                          future: getWorkerDetails(workerId),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasError || !snapshot.hasData) {
                              return const Text('Error loading worker details');
                            }

                            final workerName = snapshot.data!['name']!;
                            final workerPhoto = snapshot.data!['photoUrl']!;

                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(workerPhoto),
                                      radius: 25,
                                    ),
                                    const SizedBox(width: 10),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(workerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                        Text(
                                          'Service provider',
                                          style: TextStyle(color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = selectedIndex == index ? null : index;
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      const Text('Rating', style: TextStyle(fontWeight: FontWeight.bold)),
                                      Constants.spaceWidth10,
                                      selectedIndex == index ? const Icon(Icons.keyboard_arrow_up) : const Icon(Icons.keyboard_arrow_down),
                                    ],
                                  ),
                                )
                              ],
                            );
                          },
                        )
                      else
                        const Text('Request not accepted yet'),
                      if (selectedIndex == index)
                        BlocConsumer<RatingAndReviewBloc, RatingAndReviewState>(
                          listener: (context, state) {},
                          builder: (context, state) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Constants.spaceHight10,
                                const Text('Select service Rating'),
                                Constants.spaceHight5,
                                const StarRatingWidget(),
                                Constants.spaceHight5,
                                const Text('Enter Review'),
                                Constants.spaceHight5,
                                TextFormField(
                                  onChanged: (value) => context.read<RatingAndReviewBloc>().add(ReviewChanged(review: value)),
                                ),
                                Constants.spaceHight5,
                                customWorkerButton(
                                    doc: doc,
                                    buttonName: 'Done',
                                    action: () {
                                      context.read<RatingAndReviewBloc>().add(SubmitRating());
                                      selectedIndex = null;
                                    }),
                              ],
                            );
                          },
                        ),
                    ],
                  ),
                ),
                Container(
                  height: 3,
                  width: double.infinity,
                  color: doc['RequestStatus'] == RequestStatus.accepted.toString()
                      ? Colors.green.shade200
                      : doc['RequestStatus'] == RequestStatus.completed.toString()
                          ? Colors.grey.shade400
                          : Colors.orangeAccent,
                  // child:doc['RequestStatus'] == RequestStatus.accepted.toString()? Text('Accepted'):doc['RequestStatus'] == RequestStatus.completed.toString()?Text('Completed'):Text('Pending'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
