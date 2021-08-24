import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:idun_test/data/models/data_model.dart';
import 'package:idun_test/domain/helpers/domain_error.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:idun_test/data/http/http.dart';

import 'package:idun_test/infra/http/http.dart';

import 'package:idun_test/domain/entities/entities.dart';

class PostData {
  final HttpClient httpclient;
  final String url;

  PostData({required this.httpclient, required this.url});

  Future<IdunDataEntity> create({required IdunDataEntity entity}) async {
    try {
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

class HttpClientSpy extends Mock implements HttpClient {}

void main() {
  late HttpClientSpy httpclient;
  late String url;
  late PostData sut;
  late IdunDataEntity idunDataEntity;
  late Map body;

  When mockRequest() {

      return when(() => httpclient.request(
          url: any(named: "url"), method: any(named: "method"), body: body));
  }

  void mockHttpData() {
    mockRequest().thenAnswer((_) async => DataModel.fromDomain(idunDataEntity).toJson());
  }

  void mockHttpError(HttpError error) {
    mockRequest().thenThrow(error);
  }

  setUp(() {
    httpclient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sut = PostData(httpclient: httpclient, url: url);
    idunDataEntity = IdunDataEntity(
      guid: faker.guid.guid(),
      text: faker.lorem.sentence(),
      date: DateTime.now(),
    );
    body = DataModel.fromDomain(idunDataEntity).toJson();
    mockHttpData();
  });

  test('Should call request client with correct value', () async {
    await sut.create(entity: idunDataEntity);

    verify(() => httpclient.request(url: url, method: 'post', body: body));
  });

  test('should return client error 400 invalid fields ', () async {
    mockHttpError(HttpError.badRequest);

    var future = sut.create(entity: idunDataEntity);

    expect(future, throwsA(DomainError.invalidFields));
  });

  test("should return client error 404 with invalid url", () {
    mockHttpError(HttpError.NotFound);

    final future = sut.create(entity: idunDataEntity);

    expect(future, throwsA(DomainError.Unexpected));
  });

  test("should return idun entity on client return 201", () async {
    final response = await sut.create(entity: idunDataEntity);

    expect(response, idunDataEntity);
  });
}
