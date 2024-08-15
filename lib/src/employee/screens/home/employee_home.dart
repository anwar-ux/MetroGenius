import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metrogeniusorg/src/employee/screens/home/commited.dart';
import 'package:metrogeniusorg/src/employee/screens/home/completed.dart';
import 'package:metrogeniusorg/src/employee/screens/home/requestes.dart';

class EmployeeHome extends StatelessWidget {
  const EmployeeHome({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 1,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(120),
          child: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(''),
            bottom: const TabBar(
              dividerColor: Colors.transparent,
              tabAlignment: TabAlignment.fill,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorPadding: EdgeInsets.symmetric(horizontal: 10),
              indicator: BoxDecoration(
                color: Color.fromARGB(71, 40, 56, 145),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              tabs: [
                Tab(text: 'Completed'),
                Tab(text: 'Commited'),
                Tab(text: 'Requestes'),
              ],
            ),
            titleTextStyle: GoogleFonts.urbanist(fontWeight: FontWeight.w500, color: Colors.black, fontSize: 25),
            centerTitle: true,
          ),
        ),
        body: const TabBarView(
          children: [CompletedServices(), CommitedServices(), RequestedServices()],
        ),
      ),
    );
  }
}
