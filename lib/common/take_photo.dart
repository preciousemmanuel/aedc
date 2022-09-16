
import 'dart:io';

import 'package:aedc_disco/common/constants/text_literals.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

class TakePhoto{


  static takeCamera()async{
    try {
            final image = await ImagePicker().pickImage(source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
        if(image==null){
          return null;
        }else{
             final tempImage = File(image.path);
             return tempImage;
        }
      
    } catch (e) {
      return null;
    }
  }




  static takeGallery()async{
    try {
            final image = await ImagePicker().pickImage(source: ImageSource.gallery, preferredCameraDevice: CameraDevice.rear);
        if(image==null){
          return null;
        }else{
             final tempImage = File(image.path);
             return tempImage;
        }
      
    } catch (e) {
      return null;
    }
  }

  static takeMultipleImages()async{
    List<Asset> resultList = <Asset>[];
     List<Asset> images = <Asset>[];
    try {
      resultList = await MultiImagePicker.pickImages(
        maxImages: 5,
        enableCamera: true,
        selectedAssets: images,
        cupertinoOptions: CupertinoOptions(takePhotoIcon: "chat"),
        materialOptions: MaterialOptions(
          actionBarColor: "#abcdef",
          actionBarTitle:TextLiterials.app_name,
          allViewTitle: "All Photos",
          useDetailsView: false,
          selectCircleStrokeColor: "#000000",
        ),
      );
    } on Exception catch (e) {
     print(e.toString());
    }
    return {resultList,images};
  }
}