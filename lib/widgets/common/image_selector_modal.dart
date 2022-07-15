

import 'package:aedc_disco/common/constants/sizes_constants.dart';
import 'package:aedc_disco/common/themes/app_colors.dart';
import 'package:flutter/material.dart';

class ImageSelectorModal extends StatefulWidget {
  final Function OnHandleImage;
  final Function OnHandleGallery;

  const ImageSelectorModal({Key? key,required this.OnHandleGallery,required this.OnHandleImage}) : super(key: key);

  @override
  State<ImageSelectorModal> createState() => _ImageSelectorModalState();
}

class _ImageSelectorModalState extends State<ImageSelectorModal> {
  @override
  Widget build(BuildContext context) {
    var size=MediaQuery.of(context).size;
      return ClipRRect(
      borderRadius: const BorderRadius.only(topRight: Radius.circular(Sizes.dimen_10), topLeft: Radius.circular(Sizes.dimen_10)),
      child: Container(
        width: size.width,
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.dimen_28,
            vertical: Sizes.dimen_11
        ),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: ()=> Navigator.pop(context),
                  child: Container(
                    width: Sizes.dimen_24,
                    height: Sizes.dimen_24,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColor.mainColor.withOpacity(0.2),
                    ),
                    child: Icon(Icons.close),
                  ),
                ),
              ),
              const SizedBox(height: Sizes.dimen_10),

              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                  widget.OnHandleImage();
                  // selectImage(source: ImageSource.camera, context: context);
                },
                child: Container(
                  width: size.width,
                  height: Sizes.dimen_80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_15,
                    vertical: Sizes.dimen_20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    color: AppColor.mainColor.withOpacity(0.1),
                  ),
                  child: Row(
                      children: [
                        Container(
                          width: Sizes.dimen_40,
                          height: Sizes.dimen_40,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child:Icon(Icons.photo_camera),
                        ),
                        const SizedBox(width: Sizes.dimen_10),
                        const Text(
                            "Take Picture",
                            style: TextStyle(
                              fontSize: Sizes.dimen_16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )
                        )
                      ]
                  ),
                ),
              ),
              const SizedBox(height: Sizes.dimen_19),

              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                  // selectImage(source: ImageSource.gallery, context: context);
                   widget.OnHandleGallery();
                },
                child: Container(
                  width: size.width,
                  height: Sizes.dimen_80,
                  padding: const EdgeInsets.symmetric(
                    horizontal: Sizes.dimen_15,
                    vertical: Sizes.dimen_20,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
                    color: AppColor.mainColor.withOpacity(0.1),
                  ),
                  child: Row(
                      children: [
                        Container(
                          width: Sizes.dimen_40,
                          height: Sizes.dimen_40,
                          decoration: BoxDecoration(
                            color: AppColor.mainColor.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(Icons.photo_album),
                        ),
                        const SizedBox(width: Sizes.dimen_10),
                        const Text(
                            "Upload From Gallery",
                            style: TextStyle(
                              fontSize: Sizes.dimen_16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            )
                        )
                      ]
                  ),
                ),
              ),
              const SizedBox(height: Sizes.dimen_19),

              // GestureDetector(
              //   onTap: ()=> {
              //     Navigator.pop(context),
              //     // selectDocument(),
              //   },
              //   child: Container(
              //     width: size.width,
              //     height: Sizes.dimen_80,
              //     padding: const EdgeInsets.symmetric(
              //       horizontal: Sizes.dimen_15,
              //       vertical: Sizes.dimen_20,
              //     ),
              //     decoration: BoxDecoration(
              //       borderRadius: const BorderRadius.all(Radius.circular(Sizes.dimen_7)),
              //       color: AppColor.mainColor.withOpacity(0.1),
              //     ),
              //     child: Row(
              //         children: [
              //           Container(
              //             width: Sizes.dimen_40,
              //             height: Sizes.dimen_40,
              //             decoration: BoxDecoration(
              //               color: AppColor.mainColor.withOpacity(0.2),
              //               shape: BoxShape.circle,
              //             ),
              //             child: Image.asset('assets/images/gallery.png'),
              //           ),
              //           const SizedBox(width: Sizes.dimen_10),
              //           const Text(
              //               "Upload Document",
              //               style: TextStyle(
              //                 fontSize: Sizes.dimen_16,
              //                 fontWeight: FontWeight.w600,
              //                 color: Colors.black,
              //               )
              //           )
              //         ]
              //     ),
              //   ),
              // ),

            ],
          ),
        ),
      ),
    );
  
  }
}