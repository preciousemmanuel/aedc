import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonMain extends StatelessWidget {
  final String btn_txt;
  final Function ontap;
  final bool? isLoading;
  const ButtonMain(
      {Key? key, required this.btn_txt, required this.ontap, this.isLoading=false})
      : super(key: key);

  Widget _progress() {
    return SizedBox(
      height: Sizes.dimen_20,
      width: Sizes.dimen_20,
      child: Center(
        child: CircularProgressIndicator(
          color: AppColor.white,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: isLoading! ? _progress() : Text(btn_txt),
        onPressed: () {
          isLoading! ? null : ontap();
        },
        style: ElevatedButton.styleFrom(primary: AppColor.mainColor));
  }
}
