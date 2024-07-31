import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:metrogeniusorg/animation/route_animation.dart';
import 'package:metrogeniusorg/src/userside/screens/home/bloc/getcategory/getcategory_bloc.dart';
import 'package:metrogeniusorg/src/userside/screens/home/category/sub_category.dart';
import 'package:metrogeniusorg/utils/colors.dart';
import 'package:metrogeniusorg/utils/constants.dart';

// ignore: must_be_immutable
class AllServicesGrid extends StatelessWidget {
  AllServicesGrid({
    super.key,
    this.count,
    this.icon,
    this.action,
    this.title,
  });
  int? count;
  IconData? icon;
  void Function()? action;
  String? title;
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetcategoryBloc>().add(FetchCategoryData());
    });

    return SliverPadding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      sliver: BlocConsumer<GetcategoryBloc, GetcategoryState>(
        listener: (context, state) {
          if (state is GetCategoryFailed) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Failed to load categories')));
          }
        },
        builder: (context, state) {
          final int itemCount = state is GetCategoryLoaded
              ? (count != null ? count! + 1 : state.data.length + 1)
              : 0;

          if (state is GetCategoryLoading) {
            return const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()));
          } else if (state is GetCategoryLoaded) {
            return SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 180,
                mainAxisExtent: 100,
                mainAxisSpacing: 6,
                crossAxisSpacing: 6,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (index == itemCount - 1 && icon != null&&title!=null) {
                    return GestureDetector(
                      onTap: action,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.lightGrey),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(icon, color: Colors.blue),
                            Constants.spaceHight10,
                            Text(title!),
                          ],
                        ),
                      ),
                    );
                  } else {
                    if (index < state.data.length) {
                      final doc = state.data[index];
                      return GestureDetector(
                        onTap: () => Navigator.of(context).push(createRoute(SubCategory(categoryId: doc['Id'], categoryName: doc['Name']))),
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.seconderyColor,
                            boxShadow: [ BoxShadow(
                        color: AppColors.lightGrey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                                            
                        ),],
                            border: Border.all(color: AppColors.seconderyColor),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CircleAvatar(
                                        backgroundImage:
                                            NetworkImage(doc['Image'])),
                                  ],
                                ),
                                Text(
                                  doc['Name'],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 1),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  }
                },
                childCount: itemCount,
              ),
            );
          } else {
            return const SliverFillRemaining(
                child: Center(child: Text('Error loading services')));
          }
        },
      ),
    );
  }
}
