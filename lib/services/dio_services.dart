import 'dart:developer';

import 'package:dio/dio.dart' as dio_service;
import 'package:dio/dio.dart';
import 'package:mc_crud_test/Routs.dart';

class DioService {
  Dio dio = Dio();

  Future<dynamic> getData() async {
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(Routes.getData,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      // log(response.toString());
      return response;
    }).catchError((err) {
      if (err is DioError) {
        return err.response!;
      }
    });
  }

  Future<dynamic> postData(Map<String, dynamic> map) async {
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .post(Routes.postData,
            data: dio_service.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: 'POST'))
        .then((response) {
      log(response.headers.toString());
      log(response.data.toString());
      log(response.statusCode.toString());
      return response;
    }).catchError((err){
        return err.response;
    });
  }
  Future<dynamic> deleteData(String id)async{
    dio.options.headers['content-Type'] = 'application/json';
    Map<String,dynamic> map = {
      'id' : id,
    };
    return await dio.post(Routes.deleteData,
      data: dio_service.FormData.fromMap(map), options: Options(responseType: ResponseType.json, method: 'POST')
    ).then((response) {
      return response;
    }).catchError((err){
      return err.response;
    });
  }
  Future<dynamic> editData(Map<String, dynamic> map)async{
    dio.options.headers['content-Type'] = 'application/json';
    return await dio.post(Routes.editData,
        data: dio_service.FormData.fromMap(map), options: Options(responseType: ResponseType.json, method: 'POST')
    ).then((response) {
      log(response.data);
      return response;
    }).catchError((err){
      return err.response;
    });
  }

}
