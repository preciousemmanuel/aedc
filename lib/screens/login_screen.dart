import 'dart:convert';

import 'package:aedc_disco/common/alert.dart';
import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:aedc_disco/config/api_constant.dart';
import 'package:aedc_disco/network/api_client.dart';
import 'package:aedc_disco/screens/home_screen.dart';
import 'package:aedc_disco/widgets/common/button_main.dart';
import 'package:aedc_disco/widgets/common/form_title.dart';
import 'package:aedc_disco/widgets/common/general_text_box.dart';
import 'package:aedc_disco/widgets/common/password_text_box.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _obscureText = false;
  bool isApiCallProcess = false;

  TextEditingController _emailController = new TextEditingController();
  TextEditingController _passwordController = new TextEditingController();

  final GlobalKey<ScaffoldState> scaffoldkey = new GlobalKey();

   final formKey = GlobalKey<FormState>();


@override
  initState(){
    super.initState();
  _emailController.text="test@thenextier.com";
  _passwordController.text="test@1";
}

submitLogin()async{
  
  AlertToast toaster = new AlertToast(scaffold: scaffoldkey);
  if (formKey.currentState != null && formKey.currentState!.validate()) {
setState(() {
    isApiCallProcess=true;
  });
try {

  APIClient apiClient=new APIClient();

var data={
  "userName":_emailController.text,
  "Password":_passwordController.text
};

print("reee#${data}");

   var response = await apiClient.submitPostRequest(url: "${APIConstants.BASE_URL}/Login",data: data);
setState(() {
    isApiCallProcess=false;
  });
  if (response["status"]=="success") {
    toaster.showSuccess("Login is Successful");
    final prefs = await SharedPreferences.getInstance();
    print("dsdsds##${response["data"]}");
    await prefs.setString("user", json.encode(response["data"]));
   Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => HomeScreen()),
                    (Route<dynamic> route) => false);
  } else {
    toaster.showError("Email and Password do not match");
  }

} catch (e) {
  setState(() {
    isApiCallProcess=false;
  });
    toaster.showError("Something went wrong");
  
}

   




  }
}

  @override
  Widget build(BuildContext context) {
    double deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldkey,
      appBar: AppBar(
        title: Text(
          "Login",
          style: TextStyle(letterSpacing: 1.2),
        ),
        backgroundColor: AppColor.mainColor,
      ),
      body: Container(
        height: deviceHeight,
        decoration: const BoxDecoration(
            color: Colors.white,
            image: DecorationImage(
                image: AssetImage("assets/background-img.jpg"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: EdgeInsets.all(Sizes.dimen_20),
              child: Column(
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Image(
                      image: AssetImage("assets/aedc.png"),
                      width: 150,
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                 
                      GeneralTextBox(
                          validator: (val){
                          if(val==""){
                            return "Email is required";
                          }
                        },
                          controller: _emailController,
                          labelTitle: "Email Address",
                          placeHolderText: "Email Addresss"),
                
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormTextTitle(text: "Enter Password"),
                      const SizedBox(height: Sizes.dimen_7),
                      PasswordTextBox(
                        validator: (val){
                          if(val==""){
                            return "Password is required";
                          }
                        },
                          controller: _passwordController,
                          isPassword: true,
                          labelTitle: "Enter Password",
                          placeHolderText: "Enter Password"),
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Container(
                      height: 50.0,
                      width: double.infinity,
                      child: ButtonMain(
                        isLoading: isApiCallProcess,
                        btn_txt: "Submit",
                          ontap: (){
                            submitLogin();
                          },  
                        // ontap: () => Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (_) => HomeScreen(),
                        //   ),
                        // ),
                      )),
                  SizedBox(
                    height: 50,
                  ),
                  Text(
                    'PowerConnect v2.4',
                    style: TextStyle(letterSpacing: 1.2),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
