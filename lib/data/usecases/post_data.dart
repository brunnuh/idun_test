import 'package:idun_test/data/http/http.dart';
import 'package:idun_test/data/models/data_model.dart';

import 'package:idun_test/domain/entities/entities.dart';
import 'package:idun_test/domain/helpers/helpers.dart';

class PostData {
  final HttpClient httpclient;
  final String url;

  PostData({required this.httpclient, required this.url});

  Future<IdunDataEntity> create({required IdunDataEntity entity}) async {
    try {
      throw DomainError.invalidFields;
      final body = DataModel.fromDomain(entity).toJson();
      final response = await httpclient.request(url: url, method: 'post', body: body);
      return DataModel.fromJson(response).toEntity();
    } on HttpError catch (e) {
      throw e == HttpError.badRequest
          ? DomainError.invalidFields
          : DomainError.Unexpected;
    }
  }
}
