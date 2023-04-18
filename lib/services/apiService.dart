import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:benecol_flutter/config/config.dart';

class ApiService {
  final String _apiUrl = apiUrl;

  Future<dynamic> get(String subPath) async {
    var responseJson;
    Uri requestUri = Uri.parse('$_apiUrl$subPath');
    try {
      final response = await http.get(requestUri);
      responseJson = _returnResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> post(String subPath, { Map<String, String>? headers, Object? sendObj }) async {
    var responseJson;
    Uri requestUri = Uri.parse('$_apiUrl$subPath');
    headers = headers ?? {HttpHeaders.contentTypeHeader: "application/json"};
    try {
      final response = await http.post(
        requestUri,
        headers: headers,
        body: sendObj
      );
      responseJson = _returnResponse(response);
    } on SocketException{
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postSingleImage(String subPath, { Map<String, dynamic>? params, List? imagePathList }) async {
    var responseJson;
    Uri requestUri = Uri.parse('$_apiUrl$subPath');

    print('==========================  $_apiUrl$subPath');
    if(params == null || imagePathList == null) return;
    print('=============================${imagePathList}');
    // var request;
    try {
      if(imagePathList.length==1){
        print('===============上传1张======================');

        final request = new http.MultipartRequest(
              "POST",
              requestUri
          );
          //Add params
          params.forEach((key, value) {
            request.fields[key] = value;
          });

          request.files.add(
                await http.MultipartFile.fromPath( 'file', imagePathList[0]),
          );
          var response = await request.send();
          // response.stream.asBroadcastStream();

          responseJson = await http.Response.fromStream(response);
          responseJson = _returnResponse(responseJson);
          print(request.fields);

      }else if(imagePathList.length==2){
        print('===============上传2张======================');
          final request = new http.MultipartRequest(
              "POST",
              requestUri
          );
          //Add params
          params.forEach((key, value) {
            request.fields[key] = value;
          });

          request.files.add(
                await http.MultipartFile.fromPath( 'file', imagePathList[0]),
          );
          request.files.add(
            await http.MultipartFile.fromPath( 'file2', imagePathList[1]),
          );
          var response = await request.send();
          // response.stream.asBroadcastStream();

          responseJson = await http.Response.fromStream(response);
          responseJson = _returnResponse(responseJson);
          print(request.fields);

      }else if(imagePathList.length ==3){
        print('===============上传3张======================');

        final request = new http.MultipartRequest(
            "POST",
            requestUri
        );
        //Add params
        params.forEach((key, value) {
          request.fields[key] = value;
        });

        request.files.add(
          await http.MultipartFile.fromPath( 'file', imagePathList[0]),
        );
        request.files.add(
          await http.MultipartFile.fromPath( 'file2', imagePathList[1]),
        );
        request.files.add(
          await http.MultipartFile.fromPath( 'file3', imagePathList[2]),
        );
        var response = await request.send();
        // response.stream.asBroadcastStream();

        responseJson = await http.Response.fromStream(response);
        responseJson = _returnResponse(responseJson);
        print(request.fields);
      }

      //Add image
      // for(int i = 0;i<imagePathList.length;i++){
      //   final request = new http.MultipartRequest(
      //       "POST",
      //       requestUri
      //   );
      //   //Add params
      //   params.forEach((key, value) {
      //     request.fields[key] = value;
      //   });
      //
      //   request.files.add(
      //         await http.MultipartFile.fromPath( 'file', imagePathList[i]),
      //   );
      //   print(request.fields);
      //
      //   var response = await request.send();
      //   // response.stream.asBroadcastStream();
      //
      //   responseJson = await http.Response.fromStream(response);
      //   responseJson = _returnResponse(responseJson);
      // }

      // var response = await request.send();
      // // response.stream.asBroadcastStream();
      //
      // responseJson = await http.Response.fromStream(response);
      // responseJson = _returnResponse(responseJson);


      print('responseJson =======${responseJson}');

    } on SocketException{
      print('No Internet connection');
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response){
    var responseStr = response.body.toString();
    var responseCode = response.statusCode;
    var responseJson = json.decode(responseStr);
    switch (responseCode){
      case 200:
        return responseJson;
      case 400:
        throw BadRequestException(responseJson);
      case 401:
      case 403:
        throw UnauthorisedException(responseJson);
      case 406:
        throw UnacceptableException(responseJson);
      case 500:
      default:
        throw FetchDataException(responseJson);
    }
  }
}

/// App Exceptions

class AppException implements Exception{
  final _type;
  final _body;

  //Constructor
  AppException([
    this._type,
    this._body
  ]);
  
  String toString(){
    final exceptionJson = json.encode({
      "type": _type,
      "body": _body,
    });
    return "$exceptionJson";
  }
}

class UnacceptableException extends AppException{
  UnacceptableException([
    dynamic body
  ]) : super('UnacceptableException', body);
}

class FetchDataException extends AppException{
  FetchDataException([
    dynamic body
  ]) : super("FetchDataException", body); 
}

class BadRequestException extends AppException{
  BadRequestException([
    dynamic body
  ]) : super("BadRequestException", body);
}

class UnauthorisedException extends AppException{
  UnauthorisedException([
    dynamic body
  ]) : super("UnauthorisedException", body);
}

class InvalidInputException extends AppException{
  InvalidInputException([
    dynamic body
  ]) : super("InvalidInputException", body);
}