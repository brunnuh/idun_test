import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:idun_test/main/conf.dart';
import 'package:idun_test/presentation/presenters/mobx_fields_idun_presenter.dart';

import '/presentation/presenters/mobx_list_idun_presenter.dart';

import '/data/usecases/usecases.dart';

import '/infra/http/http.dart';

final  dio = Dio();
final HttpAdapter httpClient = HttpAdapter(client: dio);

void setupLocator(){

  final loadData = LoadData(httpclient: httpClient, url: url(path: "list"));
  final postData = PostData(httpclient: httpClient, url: url(path: "create"));

  GetIt.I.registerSingleton(MobxListIdunPresenter(loadData: loadData));

  GetIt.I.registerSingleton(MobxFieldsIdunPresenter(postData: postData));
}


