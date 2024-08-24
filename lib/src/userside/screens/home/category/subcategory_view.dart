import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/services/user/saved/saved_request.dart';
import 'package:metrogeniusorg/src/userside/screens/home/appbar/subcategoryappbar.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/getratingreview/get_rating_review_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/savedservices/saved_services_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/bottom_sheet.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/custombookingbutton.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/subcategorydetails.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/widgets/usercheckboxes.dart';
import 'package:metrogeniusorg/src/userside/screens/home/home.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';


class SubcategoryView extends StatefulWidget {
  final dynamic data;
  final String workType;

  const SubcategoryView({Key? key, required this.data, required this.workType}) : super(key: key);

  @override
  _SubcategoryViewState createState() => _SubcategoryViewState();
}

class _SubcategoryViewState extends State<SubcategoryView> {
  String? value;
  bool serviceIsSaved = false;

  @override
  void initState() {
    super.initState();
    _checkIfServiceIsSaved();
  }

  void _checkIfServiceIsSaved() async {
    final isSaved = await SavedService.isServiceSaved(widget.data['Id']);
    setState(() {
      serviceIsSaved = isSaved;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
            slivers: [
              SubcategoryViewAppBar(
                data: widget.data,
              ),
              UserCheckBoxes(
                data: widget.data,
                onChanged: (selectedKey) {
                  value = selectedKey;
                },
              ),
              Subcategorydetails(data: widget.data),
              RatingsAndReviews(
                serviceName: widget.data['Name'],
              )
            ],
          ),
          CustomBookingButton(
            saveName: serviceIsSaved ? 'Unsave' : 'Save',
            cartAction: () async {
              if (serviceIsSaved) {
                context.read<SavedServicesBloc>().add(RemoveFromSaved(widget.data['Id']));
              } else {
                context.read<SavedServicesBloc>().add(AddToSave(widget.data));
              }
              _checkIfServiceIsSaved();
            },
            bookAction: () {
              if (value != null) {
                bottomSheet(context, widget.data, value!, widget.workType);
              } else {
                showCustomSnackbar(
                  context,
                  'Select a service',
                  '',
                  AppColors.thirdColor,
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class RatingsAndReviews extends StatefulWidget {
  final String serviceName;

  RatingsAndReviews({super.key, required this.serviceName});

  @override
  _RatingsAndReviewsState createState() => _RatingsAndReviewsState();
}

class _RatingsAndReviewsState extends State<RatingsAndReviews> {
  bool showAllReviews = false;

  void toggleShowReviews() {
    setState(() {
      showAllReviews = !showAllReviews;
    });
  }

  Future<Map<String, String>> getWorkerDetails(String userId) async {
   
    final userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();
    if (userDoc.exists) {
      return {
        'name': userDoc['Name'],
        'photoUrl': userDoc['Image'],
      };
    } else {
      return {
        'name': 'Unknown User',
        'photoUrl': 'https://example.com/default-photo.jpg',
      };
    }
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: BlocProvider(
          create: (context) => GetRatingReviewBloc()..add(FetchRatingData(widget.serviceName)),
          child: BlocConsumer<GetRatingReviewBloc, GetRatingReviewState>(
            listener: (context, state) {},
            builder: (context, state) {
              return Column(
                children: [
                  ServiceHeadings(title: 'Ratings & Reviews'),
                  if (state is GetRatingLoaded)
                    Column(
                      children: [
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: showAllReviews ? state.data.length : (state.data.length > 2 ? 2 : state.data.length),
                          itemBuilder: (context, index) {
                            final data = state.data[index];
                            return FutureBuilder<Map<String, String>>(
                              future: getWorkerDetails(data['UserID']),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const CircularProgressIndicator();
                                }
                                if (snapshot.hasError || !snapshot.hasData) {
                                  return const Text('Error loading worker details');
                                }

                                final workerName = snapshot.data!['name']!;
                                final workerPhoto = snapshot.data!['photoUrl']!;

                                return ListTile(
                                  contentPadding: EdgeInsets.all(0),
                                  leading: CircleAvatar(
                                    backgroundImage: NetworkImage(workerPhoto),
                                    radius: 25,
                                  ),
                                  title: Text(workerName, style: const TextStyle(fontWeight: FontWeight.bold)),
                                  subtitle: Text(data['Review']),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: List.generate(5, (starIndex) {
                                      return Icon(
                                        starIndex < data['Rating'] ? Icons.star : Icons.star_border,
                                        color: starIndex < data['Rating'] ? Colors.amber : Colors.grey,
                                        size: 16,
                                      );
                                    }),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        if (state.data.length > 2)
                          TextButton(
                            onPressed: toggleShowReviews,
                            child: Text(showAllReviews ? 'Show Less' : 'Show More'),
                          ),
                          Constants.spaceHight40,
                          Constants.spaceHight15
                      ],
                    )
                  else if (state is GetRatingLoading)
                    const CircularProgressIndicator(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
