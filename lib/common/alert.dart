

import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:flutter/material.dart';


class AlertToast  {
  final  scaffold;
  const AlertToast({Key? key,required this.scaffold}) ;

 showSuccess(text){
  final snackbar=SnackBar(content: Text(text),
      backgroundColor:  AppColor.primaryGreen);

      scaffold.currentState.showSnackBar(snackbar);
}

showError(text){
  final snackbar=SnackBar(content: Text(text),
      backgroundColor:  AppColor.primaryRed);

      scaffold.currentState.showSnackBar(snackbar);
}

}