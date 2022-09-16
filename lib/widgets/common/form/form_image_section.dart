

import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:flutter/material.dart';

class FormImageSection extends StatelessWidget {
  final file;
  final Function? onRemove;
  const FormImageSection({Key? key,required this.file, this.onRemove}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
    
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 4;
    final double itemWidth = size.width / 2;
    return Container(
        constraints: BoxConstraints(
          maxWidth: size.width,
          // maxHeight: Sizes.dimen_200,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            file.length == 0
                ? Container()
                :
                Container(
                 
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
shrinkWrap: true,

                    gridDelegate:   SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:3,
                  // maxCrossAxisExtent: 200,
                  childAspectRatio:  itemWidth / itemHeight,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10),
                  itemCount: file.length,
                   itemBuilder: (BuildContext ctx,index){
                  
                     return Stack(
                       children:[ Container(
                                height: 100,
                                width: 100,
                                decoration: BoxDecoration(
                                  // color: Colors.blue,
                                       borderRadius: BorderRadius.circular(5),
                                       image: DecorationImage(
                        image: FileImage(file[index]!),
                        fit: BoxFit.cover
                                       ),
                                ),
                              ),
                
                              Positioned(
                                right: 0,
                                top: 0,
                                child: IconButton(onPressed: (){
                                  onRemove!(index);
                
                                }, icon: Icon(Icons.delete,color: AppColor.primaryRed,)))
                     
                          ])
                     ;
                    
                  }),
                ),
                 
            const SizedBox(height: Sizes.dimen_10,),
            
          ],
        )
    );
  }
}