import 'package:dio/dio.dart';
import 'dart:convert' as convert;
import 'dart:developer';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';


class ReqClient {
  Dio dio = Dio();

  Future<Response> postWithoutHeaderClient(url, data) async {
    print(url);
    return await dio.post(url,
        data: data,
        options: Options(
          contentType:  'application/json',
          followRedirects: false,
          validateStatus: (status) => true,
          headers: {
            "Accept":"application/json",
          },
        ));
  }

  Future<Response> getWithoutHeaderClient(url) async {
    return await dio.get(url,
        options: Options(
          headers: {
            // 'Accept': '*/*',     
          },
        ));
  }

  Future<Response> getWithAuthHeaderClient(url) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? id = prefs.getInt('userId');

    print("yuoptoken ${id}");
    print(token);
    print(url);
    return await dio.get(url,
        options: Options(
          headers: {
            // 'Accept': '*/*',
            'authorizationToken': token,
           
            "authid": id
          },
        ));
  }

  Future<Response> postWithAuthClient(url, data, {withMedia = false}) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? id = prefs.getInt('userId');
    print(id.toString());
    return await dio.post(url,
        data: data,
        options: Options(
          headers: withMedia
              ? {
                  // 'Accept': '*/*',
                  'authorizationToken': token,
                 
                  'Content-Type': 'multipart/form-data',
                  "authid": id
                }
              : {
                  // 'Accept': '*/*',
                  'authorizationToken': token,
                 
                  "authid": id
                },
        ));
  }

  Future<Response> puttWithAuthClient(url, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? id = prefs.getInt('userId');
    return await dio.put(url,
        data: data,
        options: Options(
          headers: {
            // 'Accept': '*/*',
            'authorizationToken': token,
           
            "authid": id
          },
        ));
  }

   Future<Response> deleteClient(url, data) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('token');
    final int? id = prefs.getInt('userId');
    return await dio.delete(url,
        data: data,
        options: Options(
          headers: {
            // 'Accept': '*/*',
            'authorizationToken': token,
           
            "authid":id
          },
        ));
  }

//   Future<Response> puttWithAuthClient(url,data)async{
//      final prefs = await SharedPreferences.getInstance();
//     final String? token = prefs.getString('token');
//   return await dio
//           .put(url,data: data,options:  Options(
//                 headers: {
//                   // 'Accept': '*/*',
// 'authorizationToken': token,
//                   "x-api-key":APIConstants.API_KEY
//                 },
//               ));
//  }

}
