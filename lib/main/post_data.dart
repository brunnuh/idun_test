
import '/data/usecases/usecases.dart';

import 'package:idun_test/main/conf.dart';

import 'http_client.dart';

PostData getPostData(){
  final httpClient = getHttpClient();
  return PostData(httpclient: httpClient, url: url(path: "create"));
}