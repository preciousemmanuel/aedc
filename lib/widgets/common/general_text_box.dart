import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:aedc_disco/widgets/common/form_title.dart';
import 'package:flutter/material.dart';



class GeneralTextBox extends StatefulWidget {

  final TextEditingController controller;
  final String labelTitle;
  final String placeHolderText;
  final dynamic validator;
  final Function? onChange;
  final bool? isNumeric;

  const GeneralTextBox({
    Key? key,
    required this.controller,
    required this.labelTitle,
    required this.placeHolderText,
    this.validator,
    this.onChange,
    this.isNumeric=false
  }) : super(key: key);

  @override
  _GeneralTextBoxState createState() => _GeneralTextBoxState();
}

class _GeneralTextBoxState extends State<GeneralTextBox> {

  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FormTextTitle(text: widget.labelTitle),
                      const SizedBox(height: Sizes.dimen_7),
      Container(
        constraints: const BoxConstraints(
          minHeight: Sizes.dimen_35,
        ),
        child: TextFormField(
          onChanged:(text)=> widget.onChange!(text),
          validator: widget.validator,
          controller: widget.controller,
          keyboardType:widget.isNumeric!? TextInputType.number: TextInputType.text,
          style: const TextStyle(
            fontSize: Sizes.dimen_16,
            fontWeight: FontWeight.w400,
            color: Colors.black,
          ),
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            hintText: widget.placeHolderText,
            contentPadding: const EdgeInsets.symmetric(vertical: Sizes.dimen_10, horizontal: Sizes.dimen_22),
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(Sizes.dimen_6)),
              borderSide: BorderSide(
                color: AppColor.gray,
                width: Sizes.dimen_1
              )
            ),
            focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: AppColor.mainColor)),
            hintStyle: const TextStyle(
              fontSize: Sizes.dimen_14,
              fontWeight: FontWeight.w400,
              color: AppColor.hintTextColor
            ),
          ),
        ),
      ),
      ]
    );

  }

}