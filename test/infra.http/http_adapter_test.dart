import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:idun_test/data/http/http.dart';
import 'package:idun_test/data/models/data_model.dart';
import 'package:idun_test/domain/entities/entities.dart';
import 'package:idun_test/infra/http/http_adapter.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpAdapterSpy extends Mock implements Dio {}

void main() {
  late HttpAdapterSpy client;
  late HttpAdapter sut;
  late String url;
  late Map body;
  late IdunDataEntity idunDataEntity;

  // dados especificos da api

  List<Map> listIdunResponse = [
    {"guid": "string", "date": "2021-08-22T15:16:15.730Z", "text": "string"},
    {"guid": "string", "date": "2021-08-22T15:16:15.730Z", "text": "string"}
  ];

  When mockGet(String url) {
    return when(() => client.get(url));
  }

  When mockPost(String url, dynamic data) {
    return when(() => client.post(url, data: data));
  }

  void mockResponse({int statuscode = 201, required String url, String method = "get", required dynamic data}) {
    (method == "get" ? mockGet(url) : mockPost(url, data)).thenAnswer(
      (_) async => Response(
        statusCode: statuscode,
        requestOptions: RequestOptions(path: url),
        data: data,
      ),
    );
  }

  setUpAll((){
    url = faker.internet.httpUrl();
    client = HttpAdapterSpy();
    sut = HttpAdapter(client: client);
  });

  group("get", () {
    setUp(() {
      mockResponse(url: url, data: listIdunResponse);
    });

    test('should call get with correct values', () async {
      await sut.request(url: url, method: 'get');

      verify(() => client.get(url));
    });

    test('should return notFound if get returns 404', () {
      mockResponse(statuscode: 404, url: url, data: null);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.NotFound));
    });
  });

  group("post", () {
    setUp(() {
      idunDataEntity = IdunDataEntity(
          guid: faker.guid.guid(),
          text: faker.lorem.sentence(),
          date: DateTime.now());
      body = DataModel.fromDomain(idunDataEntity).toJson();
      mockResponse(url: url, data: body, method: 'post');
    });
    test('should call client with correct method', () async {
      await sut.request(url: url, method: 'post', body: body);

      verify(() => client.post(url, data: body));
    });
  });
}
