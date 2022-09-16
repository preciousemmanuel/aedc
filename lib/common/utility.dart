import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';

class Utitlity{

  static Future<CloudinaryResponse> uploadFileOnCloudinary(String filePath) async {
  String result;
  late CloudinaryResponse response;
  try {
    var cloudinary = CloudinaryPublic('dao4owynh', 'jr9qe5sn', cache: false);
    response = await cloudinary.uploadFile(
      CloudinaryFile.fromFile(filePath, resourceType: CloudinaryResourceType.Image),
    );
    
  } on CloudinaryException catch (e, s) {
    print(e.message);
    print(e.request);
  }
  return response;
}

 static Future<List<CloudinaryResponse>> uploadMultiFileOnCloudinary(List<File?>  filePath) async {
  String result;
  late List<CloudinaryResponse> response;
  try {
    print("dsdd####");
    var cloudinary = CloudinaryPublic('dao4owynh', 'jr9qe5sn', cache: false);
    response = await cloudinary.multiUpload(filePath.map((image) async=> CloudinaryFile.fromFile(image!.path,resourceType:CloudinaryResourceType.Image )).toList());
      print(response);
    
    
  } on CloudinaryException catch (e, s) {
    print(e.message);
    print(e.request);
  }
  return response;
}

static convertArrayToString(List< CloudinaryResponse> array){
  String files=array.map((e) => e.secureUrl).toList().join(",");
  print("filesssd###,${files}");
  return files;
}

}