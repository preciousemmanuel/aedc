import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:flutter/material.dart';



class PasswordTextBox extends StatefulWidget {

  final TextEditingController controller;
  final bool isPassword;
  final String labelTitle;
  final String placeHolderText;
  final dynamic validator;
  final Function? onChange;

  const PasswordTextBox({
    Key? key,
    required this.controller,
    required this.isPassword,
    required this.labelTitle,
    required this.placeHolderText,
    this.validator,
    this.onChange
  }) : super(key: key);

  @override
  _PasswordTextBoxState createState() => _PasswordTextBoxState();
}

class _PasswordTextBoxState extends State<PasswordTextBox> {

  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {

    return Container(
      constraints: const BoxConstraints(
        minHeight: Sizes.dimen_35,
      ),
      child: TextFormField(
        onChanged: (txt)=>widget.onChange!(txt),
        validator: widget.validator,
        controller: widget.controller,
        obscureText: !isPasswordVisible ? true : false,
        keyboardType: TextInputType.visiblePassword,
        style: const TextStyle(
          fontSize: Sizes.dimen_16,
          fontWeight: FontWeight.w400,
          color: Colors.black
        ),
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: widget.labelTitle,
          hintText: widget.placeHolderText,
          contentPadding: const EdgeInsets.symmetric(vertical: Sizes.dimen_10, horizontal: Sizes.dimen_22),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_6)),
              borderSide: BorderSide(
                  color: AppColor.gray,
                  width: Sizes.dimen_1
              )
          ),
          hintStyle: const TextStyle(
              fontSize: Sizes.dimen_14,
              fontWeight: FontWeight.w400,
              color: AppColor.hintTextColor
          ),
            suffixIcon: widget.isPassword
                ? IconButton(
              icon: Icon(
                isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: const Color(0xFF959595),
              ),
              onPressed: () {
                setState(()=> isPasswordVisible = !isPasswordVisible);
              },
            )
                : null
        ),
      ),
    );

  }

}