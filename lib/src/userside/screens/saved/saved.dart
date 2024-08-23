import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/savedservices/saved_services_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/subcategory_view.dart';
import 'package:metrogeniusorg/src/widgets/app_bar.dart';
import 'package:metrogeniusorg/src/widgets/snak_bar.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

class Saved extends StatelessWidget {
  const Saved({super.key,});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppbar(title: 'Saved'),
      body:BlocProvider(
      create: (context) => SavedServicesBloc()..add(FetchSavedServiceData()),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocConsumer<SavedServicesBloc, SavedServicesState>(
          listener: (context, state) {
            if (state is SavedServicesFailed) {
              showCustomSnackbar(context, 'Failed', state.errorMsg, Colors.red);
            }
          },
          builder: (context, state) {
            if (state is SavedServicesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is SavedServicesLoaded) {
              final itemCount = state.data.length;
              if (itemCount == 0) {
                return const Center(
                  child: Text('No saved services'),
                );
              } else {
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 500,
                    mainAxisExtent: 240,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    final doc = state.data[index];
                    return LayoutBuilder(
                      builder: (context, constraints) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(createRoute(SubcategoryView(data: doc,workType: doc['Name'],)));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.seconderyColor,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.lightGrey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                              border: Border.all(color: AppColors.seconderyColor),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                   SizedBox(
                                        height: constraints.maxHeight * 0.4,
                                        width: constraints.maxWidth ,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.network(doc['Image'], fit: BoxFit.cover),
                                        ),
                                      ),
                                      Constants.spaceHight5,
                                       Text(
                                        doc['Name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                          fontSize: 18
                                        ),
                                      ),
                                      Constants.spaceHight5,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text(
                                        'Price starts from',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                      Constants.spaceHight5,
                                      Text(
                                        '₹ ${doc['Price'].toString()}',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Constants.spaceHight5,
                                  // const Text(
                                  //   'Description',
                                  //   style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1, fontSize: 12),
                                  // ),
                                  Constants.spaceHight5,
                                  Text(
                                    doc['Discription'],
                                    style: const TextStyle(
                                      fontSize: 12,
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    )
    );
  }
}
