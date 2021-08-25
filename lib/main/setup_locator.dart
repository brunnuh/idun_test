import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:idun_test/presentation/presenters/mobx_fields_idun_presenter.dart';

import '/presentation/presenters/mobx_list_idun_presenter.dart';

import '/data/usecases/usecases.dart';

import '/infra/http/http.dart';

void setupLocator(){
  final url = "https://idun-tests.herokuapp.com/api/v1/post/list";
  final  dio = Dio();
  final HttpAdapter httpClient = HttpAdapter(client: dio);

  LoadData loadData = LoadData(httpclient: httpClient, url: url);

  GetIt.I.registerSingleton(MobxListIdunPresenter(loadData: loadData));
  GetIt.I.registerSingleton(MobxFieldsIdunPresenter());
}