import 'dart:convert';

import 'package:dio/dio.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient{
  final Dio client;

  HttpAdapter({required this.client});


  _handleResponse(Response response) {
    if (response.data != null && response.statusCode == 201) {
      return response.data;
    } else if (response.statusCode == 404) {
      throw HttpError.NotFound;
    } else {
      throw HttpError.serverError;
    }
  }

  @override
  Future request({required String url, required String method, Map? body}) async {
    Response response = Response(requestOptions: RequestOptions(path: url), statusCode: 404, data: '');
    if(method == "get"){
      response = await client.get(url);
    }else if(method == "post"){
      response = await client.post(url, data: body);
    }
    return _handleResponse(response);
  }

}
