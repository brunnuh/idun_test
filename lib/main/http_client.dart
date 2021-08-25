import 'package:dio/dio.dart';

import '/data/http/http.dart';

import '/infra/http/http_adapter.dart';

HttpClient getHttpClient(){
  final  dio = Dio();
  return  HttpAdapter(client: dio);

}