
import '/data/http/http.dart';
import '/data/usecases/load_data.dart';

import '/main/http_client.dart';

import 'conf.dart';

LoadData getLoadData(){
  HttpClient httpClient = getHttpClient();
  return LoadData(httpclient: httpClient, url: url(path: "list"));
}