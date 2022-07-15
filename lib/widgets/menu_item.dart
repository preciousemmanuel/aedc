import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {

  final String img;
  final String title;
  final Function ontap;
  const MenuItem({ Key? key ,required this.img,required this.ontap, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color _maincolor = Color(0xff000375);
     double deviceHeight = MediaQuery.of(context).size.height;
     double devicewidth= MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap:()=> ontap(),
      child: Container(
        width: (devicewidth/3)-30,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
              color: _maincolor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                )
              ]),
              child: Column(
                children: [
                  Image(
                    image: AssetImage(img),
                    width: 50,
                    height: 50,
                  ),
                  SizedBox(height: 10,),
                  Text(title,style: TextStyle(color: Colors.white,fontSize: 12),)
                ],
              ),
      ),
    );
  }
}