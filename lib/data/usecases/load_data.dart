import 'package:idun_test/domain/usecases/usecases.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/entities/entities.dart';

import '../../data/models/data_model.dart';
import '../../data/http/http.dart';

class LoadData implements ILoadData{
  final HttpClient httpclient;
  final String url;

  LoadData({required this.httpclient, required this.url});

  Future<List<IdunDataEntity>> call() async {
    try{
      List<IdunDataEntity> listResponse = [];
      final response = await httpclient.request(url: url, method: 'get');
      response.forEach((json){
        listResponse.add(DataModel.fromJson(json).toEntity());
      });
      return listResponse;
    }on HttpError{
      throw DomainError.Unexpected;
    }
  }
}
