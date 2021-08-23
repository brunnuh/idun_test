import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:idun_test/data/http/http.dart';
import 'package:idun_test/data/usecases/load_data.dart';
import 'package:idun_test/presentation/presenters/mobx_list_idun_presenter.dart';

import './ui.components/pages/listIdun/list_idun_page.dart';
import 'infra/http/http_adapter.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListIdunPage(),
    );
  }
}

void setupLocator(){
  final url = "https://idun-tests.herokuapp.com/api/v1/post/list";
  final  dio = Dio();
  final HttpClient httpClient = HttpAdapter(client: dio);

  LoadData loadData = LoadData(httpclient: httpClient, url: url);

  GetIt.I.registerSingleton(MobxListIdunPresenter(loadData: loadData));
}

