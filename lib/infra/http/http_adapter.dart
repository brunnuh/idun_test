import 'dart:convert';

import 'package:dio/dio.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient{
  final Dio client;

  HttpAdapter({required this.client});


  List _handleResponse(Response response) {
    if (response.data != null && response.statusCode == 200) {
      return response.data;
    } else if (response.statusCode == 404) {
      throw HttpError.NotFound;
    } else {
      throw HttpError.serverError;
    }
  }

  @override
  Future request({required String url, required String method, Map? body}) async {
    var response = await client.get(url);
    return _handleResponse(response);
  }

}
