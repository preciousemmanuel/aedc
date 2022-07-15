




import 'package:aedc_disco/network/request_client.dart';
import 'package:dio/dio.dart';

class APIClient {
  Dio dio = Dio();
  ReqClient requestClient = new ReqClient();


Future submitPostRequestWithMedia({required String url, required data}) async {
    

    print('url in post:\n$url');

    try {
      Response response = await requestClient.postWithAuthClient(url, data,withMedia: true);
       print(response.statusCode);
        print(response.statusMessage);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('post response:\n $response');
       return {"status": "success", "message": "Success"};
      } else {
       
        return {"status": "error", "message": "Something happened"};
        // throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      final dioError = e;
      print("fdf#scv00${e.message}");
      switch (dioError.type) {
        case DioErrorType.cancel:
          return {"status": "error", "message": "Something happened"};
        case DioErrorType.response:
          // return ErrorResponseModel.fromJson(dioError.response!.data).message;
          return dioError.response!.data;
        case DioErrorType.connectTimeout:
          return {"status": "error", "message": 'Timed out!!'};

        case DioErrorType.other:
          return {
            "status": "error",
            "message": 'Could not ascertain the cause of this error'
          };
      }
    }
  }

Future submitPostRequest({required String url, required dynamic data}) async {
    

    print('url in post:\n$url');

    try {
      Response response = await requestClient.postWithAuthClient(url, data);
       print(response.statusCode);
        print(response.data);
      if (response.statusCode == 200 || response.statusCode == 201) {
        print('post response:\n $response');
       return {"status": "success", "message": "Success","data":response.data};
      } else {
       
        return {"status": "error", "message": "Something happened"};
        // throw Exception(response.statusMessage);
      }
    } on DioError catch (e) {
      final dioError = e;
      print("fdf#scv00${e.message}");
      switch (dioError.type) {
        case DioErrorType.cancel:
          return {"status": "error", "message": "Something happened"};
        case DioErrorType.response:
          // return ErrorResponseModel.fromJson(dioError.response!.data).message;
          return dioError.response!.data;
        case DioErrorType.connectTimeout:
          return {"status": "error", "message": 'Timed out!!'};

        case DioErrorType.other:
          return {
            "status": "error",
            "message": 'Could not ascertain the cause of this error'
          };
      }
    }
  }

}