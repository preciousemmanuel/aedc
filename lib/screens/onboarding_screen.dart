import 'package:aedc_disco/screens/login_screen.dart';
import 'package:aedc_disco/widgets/common/button_main.dart';
import 'package:aedc_disco/widgets/clip_path.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.5,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage("assets/grid1.png"),
                      fit: BoxFit.cover,
                    )),
                  ),
                  Positioned(
                      bottom: 20.0,
                      child: Image(
                        image: AssetImage("assets/aedc.png"),
                      )),
                  // Positioned(
                  //   bottom: 0.0,
                  //   child: Container(
                  //     height: 70,
                  //     width: MediaQuery.of(context).size.width,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white.withOpacity(0.7),
                  //     ),
                  //   ),
                  // )
                ],
              ),
     SizedBox(
                height: 20,
              ),
    Text("Welcome to Power Connect",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),
              SizedBox(
                height: 60,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                    height: 50.0,
                    width: double.infinity,
                    child: ButtonMain(
                      
                      btn_txt: "Get Started",
                      ontap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoginScreen(),
                        ),
                      ),
                    )),
              )
              // Container(
              //   height:MediaQuery.of(context).size.height/2 ,
              //   child: Stack(
              //     children: [
              //      Image.asset("assets/about-bg.png",fit: BoxFit.cover)
              //     ],
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
