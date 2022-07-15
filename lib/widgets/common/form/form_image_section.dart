

import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class FormImageSection extends StatelessWidget {
  final file;
  const FormImageSection({Key? key,required this.file}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    return Container(
        constraints: BoxConstraints(
          maxWidth: size.width,
          // maxHeight: Sizes.dimen_200,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            file == null
                ? Container()
                : Container(
              height: 267,
              width: 180,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                image: DecorationImage(
                    image: FileImage(file!),
                    fit: BoxFit.cover
                ),
              ),
            ),
            const SizedBox(height: Sizes.dimen_10,),
            
          ],
        )
    );
  }
}