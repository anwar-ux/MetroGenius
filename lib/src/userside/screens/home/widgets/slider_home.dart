import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:metrogeniusorg/utils/colors.dart';

class SliderHome extends StatelessWidget {
  const SliderHome({
    super.key,
    required this.slideItems,
  });

  final List<String> slideItems;

  @override
  Widget build(BuildContext context) {
    return CarouselSlider.builder(
      itemCount: slideItems.length,
      options: CarouselOptions(
        aspectRatio: 16 / 4,
        viewportFraction: 1,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: const Duration(seconds: 5),
        autoPlayAnimationDuration: const Duration(milliseconds: 800),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        scrollDirection: Axis.horizontal,
      ),
      itemBuilder: (context, index, realIndex) {
        return Container(
          width: MediaQuery.of(context).size.width,
          margin: const EdgeInsets.symmetric(horizontal: 5.0),
          decoration: BoxDecoration(
            color: AppColors.thirdColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Text(
              slideItems[index],
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.seconderyColor,
              ),
            ),
          ),
        );
      },
    );
  }
}
