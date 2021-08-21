import 'package:idun_test/domain/usecases/usecases.dart';

import '../../domain/helpers/helpers.dart';
import '../../domain/entities/entities.dart';

import '../../data/models/data_model.dart';
import '../../data/http/http.dart';

class LoadData implements ILoadData{
  final HttpClient<List<Map>> httpclient;
  final String url;

  LoadData({required this.httpclient, required this.url});

  Future<List<IdunDataEntity>> call() async {
    try{
      final response = await httpclient.request(url: url, method: 'get');
      return response.map((json) => DataModel.fromJson(json).toEntity()).toList();
    }on HttpError{
      throw DomainError.Unexpected;
    }
  }
}
