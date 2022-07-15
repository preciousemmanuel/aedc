import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:flutter/material.dart';


class FormTextTitle extends StatelessWidget {
  final String text;

  const FormTextTitle({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.left,
      style: TextStyle(
        fontSize: Sizes.dimen_14,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }
}
