

import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class SuccessModal extends StatefulWidget {
 final String title;
final String description;
final Function onTap;
   SuccessModal({Key? key,required this.title,required this.description,required this.onTap}) : super(key: key);

  @override
  State<SuccessModal> createState() => _SuccessModalState();
}

class _SuccessModalState extends State<SuccessModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
                  height: MediaQuery.of(context).size.height / 1.70,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: Scaffold(
                      body: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                           Text(
                            widget.title,
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            height: 198,
                            width: 198,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: const DecorationImage(
                                    image: AssetImage(
                                      'assets/check.png',
                                    ),
                                    
                                    fit: BoxFit.fill)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                           Text(
                            widget.description,
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      bottomNavigationBar: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Container(
                          height: 50,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                            color:AppColor.mainColor,
                          ),
                          child: TextButton(
                            onPressed: () {
                           Navigator.of(context).pop();
                           widget.onTap();
                            },
                            child: const Text(
                              'Continue',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: Sizes.dimen_18),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
  }
}