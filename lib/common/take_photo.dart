
import 'dart:io';

import 'package:image_picker/image_picker.dart';

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
}