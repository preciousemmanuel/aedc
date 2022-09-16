import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class CaptureImage extends StatelessWidget {
  final String title;
  final Function onTap;
  const CaptureImage({Key? key,required this.title,required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:()=> onTap(),
      child: Container(
        padding: EdgeInsets.all(Sizes.dimen_10),
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.mainColorDark,width: Sizes.dimen_2),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Row(
          children: [
              Icon(Icons.photo_camera),
              SizedBox(width: Sizes.dimen_10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[
                Text(title),
                SizedBox(height: Sizes.dimen_7,),
                Text("You can add upto 5 images",style: TextStyle(fontSize: Sizes.dimen_10),)
              ] )
        ]),
      ),
    );
  }
}