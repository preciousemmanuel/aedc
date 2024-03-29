

import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:flutter/material.dart';

class DropDownList extends StatefulWidget {
  final String title;
  final String? fieldMap;
  final value;
  final List items;
  final Function onChange;
 final bool? isMap;
  const DropDownList({Key? key,required this.items,required this.title,required this.value,required this.onChange,this.isMap=false,this.fieldMap}) : super(key: key);

  @override
  State<DropDownList> createState() => _DropDownListState();
}

class _DropDownListState extends State<DropDownList> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title,style: TextStyle(fontWeight: FontWeight.w600),),
          SizedBox(height: Sizes.dimen_5,),
          SizedBox(
            width: MediaQuery.of(context).size.width,
            //padding: EdgeInsets.symmetric(horizontal: 20),
            child: DropdownButton(
                value: widget.value,
                hint: Text(widget.title),
                items: widget.items.map<DropdownMenuItem<dynamic>>((identity) {
                  return DropdownMenuItem(
                    child: widget.isMap! ?Text(identity[widget.fieldMap]) : Text(identity),
                    value: widget.isMap! ?identity:identity,
                  );
                }).toList(),
                onChanged:(dynamic e){
                  print("err#${e}");
widget.onChange(e);
                }
          ),)

        ]
      )
    
        // onSaved: (value) => email = value
      
    );
  }
}