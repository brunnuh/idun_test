import 'package:dio/dio.dart';

import '../../data/http/http.dart';

class HttpAdapter implements HttpClient{

  final HttpClientAdapter client;

  HttpAdapter({required this.client});

  @override
  Future request({required String url, required String method, Map? body}) async {

  }

}