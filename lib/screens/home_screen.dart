import 'dart:convert';

import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/screens/network_assessment_three.dart';
import 'package:aedc_disco/screens/network_assessmet_screen.dart';
import 'package:aedc_disco/widgets/menu_item.dart' as menu;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  State<HomeScreen> createState() => _HomeScreenState();

}

class _HomeScreenState extends State<HomeScreen> {

var _user;
String greetings = "";

@override
  initState(){
  super.initState();
  _getLogginUser();
  getTimeOfDay();
}

_getLogginUser() async {
    final prefs = await SharedPreferences.getInstance();

    var user = prefs.getString('user');
    if (user!=null) {
      print("dew#rr${json.decode(user)}");
      setState(() {
      _user = json.decode(user);
    });
    }
    
  }

  getTimeOfDay() {
    //0-11:59
    //12-13:59
    //16-23:39
    int hour = DateTime.now().hour;

    if (hour >= 0 && hour <= 11) {
      greetings = "morning";
    }
    if (hour >= 12 && hour <= 15) {
      greetings = "afternoon";
    }
    if (hour >= 16 && hour <= 23) {
      greetings = "evening";
    }
  }

  @override
  Widget build(BuildContext context) {
     Color _maincolor = Color(0xff000375);
     double deviceHeight = MediaQuery.of(context).size.height;
     double devicewidth= MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
        title: Text(
          "Home",
          style: TextStyle(letterSpacing: 1.2),
        ),
         leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
         onPressed: (){},
        ),
        backgroundColor: _maincolor,
      ),
      body: Container(
        height: deviceHeight,
        width: devicewidth,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/background-img.jpg"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                SizedBox(height: 15,),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Welcome!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,letterSpacing: 1.2),)),
                  Align( alignment: Alignment.centerLeft,child: Text('Good $greetings, ${_user!=null?_user["StaffName"]:""}')),
                  SizedBox(height: Sizes.dimen_10,),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text('PowerConnect v2.4',style: TextStyle(letterSpacing: 1.2,fontSize: 9),)),

                  SizedBox(height: 50,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menu.MenuItem(img: "assets/failure.png", ontap: ()=>
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NetworkAssessmentScreen()
                      )
                      )
                    ,
                       title: "Network Assessment"),
                  
                      menu.MenuItem(img: "assets/transformer.png", ontap: (){}, title: "DTR Mapping"),
                      menu.MenuItem(img: "assets/wire.png", ontap: (){}, title: "Map 11kv Feeder"),
                  
                    ],
                  
                  ),

                  SizedBox(height: 20,),

                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menu.MenuItem(img: "assets/av-cable.png", ontap: (){}, title: "Map 11kv Feeder"),
                  
                      menu.MenuItem(img: "assets/verification.png", ontap: (){}, title: "Verify Customer"),
                      menu.MenuItem(img: "assets/bird-feeder.png", ontap: (){}, title: "Feeder Alignment"),
                  
                    ],
                  ),
                  SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menu.MenuItem(img: "assets/user.png", ontap: (){}, title: "Customer Mapping"),
                  
                      menu.MenuItem(img: "assets/report.png", ontap: (){}, title: "Reports"),
                      menu.MenuItem(img: "assets/collection.png", ontap: (){}, title: "Collections"),
                    ]),

                      SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menu.MenuItem(img: "assets/immigration.png", ontap: (){}, title: "Verify Staff"),
                  
                      menu.MenuItem(img: "assets/electric-meter.png", ontap: (){}, title: "Meter Installation"),
                      menu.MenuItem(img: "assets/electric-meter2.png", ontap: (){}, title: "Manage Meters"),
                  
                    ],
                  ),
                   SizedBox(height: 20,),
                   Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menu.MenuItem(img: "assets/news-reporter.png", ontap: (){}, title: "iReport"),
                  
                      menu.MenuItem(img: "assets/customer-feedback.png", ontap: (){}, title: "Feedback"),
                      menu.MenuItem(img: "assets/network.png", ontap: (){}, title: "Others"),
                  
                    ],
                  )
              ],
            ),

          )
        )
      )
    );
  }
}