

import 'package:aedc_disco/screens/network_assessment_edt.dart';
import 'package:aedc_disco/screens/network_assessment_eleven.dart';
import 'package:flutter/material.dart';

class TestSilvers extends StatefulWidget {
  const TestSilvers({Key? key}) : super(key: key);

  @override
  State<TestSilvers> createState() => _TestSilversState();
}

class _TestSilversState extends State<TestSilvers> {

List<double> data=[1,2,3,1,4,5,5.5,4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: DefaultTabController(
      length: 2,
      child: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              backgroundColor: Colors.red,
              title:  Text("App"),
            expandedHeight: 100,
            // pinned: true,
            flexibleSpace: FlexibleSpaceBar(background:Text("Description") ),
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.call), text: "Call"),
                  Tab(icon: Icon(Icons.message), text: "Message"),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            NetworkAssessmentEleven(),
            NetworkAssessmentDt(),
          ],
        ),
      ),
    ),
  );
  }
}