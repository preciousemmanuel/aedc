import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/screens/network_assessment_edt.dart';
import 'package:aedc_disco/screens/network_assessment_eleven.dart';
import 'package:aedc_disco/screens/network_assessment_substation.dart';
import 'package:aedc_disco/screens/network_assessment_three.dart';
import 'package:aedc_disco/widgets/menu_item.dart' as menu;
import 'package:flutter/material.dart';

class NetworkAssessmentScreen extends StatelessWidget {
  const NetworkAssessmentScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
     Color _maincolor = Color(0xff000375);
     double deviceHeight = MediaQuery.of(context).size.height;
     double devicewidth= MediaQuery.of(context).size.width;
    return Scaffold(
       appBar: AppBar(
        title: Text(
          "Network Assessment",
          style: TextStyle(letterSpacing: 1.2),
        ),
        //  leading: IconButton(
        //   icon: Icon(
        //     Icons.menu,
        //     color: Colors.white,
        //   ),
        //  onPressed: (){},
        // ),
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
                SizedBox(height: 45,),
                // Align(
                //   alignment: Alignment.centerLeft,
                //   child: Text("Welcome!",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,letterSpacing: 1.2),)),

                  // SizedBox(height: 50,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      menu.MenuItem(img: "assets/global.png", ontap: ()=>
                        Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NetworkAssessmentThree()
                      )
                      )
                    ,
                       title: "Network Assessment 33kv"),
                  
                      menu.MenuItem(img: "assets/global.png", ontap: ()=>Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NetworkAssessmentEleven()
                      )
                      ), title: "Network Assessments 11kv"),
                      menu.MenuItem(img: "assets/global.png", ontap: ()=>Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NetworkAssessmentDt()
                      )
                      ), title: "Network Assessments DTR"),

                       
                    ],
                  
                  ),

                  SizedBox(height: Sizes.dimen_10,),

                //  Row(
                //    children: [
                //       menu.MenuItem(img: "assets/global.png", ontap: ()=>Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (_) => NetworkAssessmentSubStation()
                //       )
                //       ), title: "Network Assessments Substation"),
                  
                //    ],
                //  )
              ],
            ),

          )
        )
      )
    );
  }
}