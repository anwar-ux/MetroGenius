import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusorg/src/screens/booking/Upcoming.dart';
import 'package:metrogeniusorg/src/screens/booking/history.dart';

class Booking extends StatelessWidget {
  const Booking({super.key,});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize:const Size.fromHeight(120),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const Text('Booking'),
            bottom: const TabBar( 
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 30),
              indicator: BoxDecoration(
              color:Color.fromARGB(71, 40, 56, 145),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              tabs: [
                Tab(text: 'Upcoming'),
                Tab(text: 'History'),
              ],
            ),
            titleTextStyle: GoogleFonts.urbanist(
                fontWeight: FontWeight.w500, color: Colors.black, fontSize: 25),
            centerTitle: true,
          ),
        ),
        body: const TabBarView(
          children: [
            Upcoming(),
            History(),
          ],
        ),
      ),
    );
  }
}
