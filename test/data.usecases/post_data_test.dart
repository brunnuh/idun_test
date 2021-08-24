import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
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

  Future create({required IdunDataEntity entity}) async {
    try {
      await httpclient.request(url: url, method: 'post');
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
  late PostData sout;
  late IdunDataEntity idunDataEntity;

  When mockRequest() {
    return when(() => httpclient.request(
        url: any(named: "url"), method: any(named: "method")));
  }

  void mockHttpData() {
    mockRequest().thenAnswer((_) async => idunDataEntity);
  }

  void mockHttpError() {
    mockRequest().thenThrow(HttpError.badRequest);
  }

  setUp(() {
    httpclient = HttpClientSpy();
    url = faker.internet.httpUrl();
    sout = PostData(httpclient: httpclient, url: url);
    idunDataEntity = IdunDataEntity(
      guid: faker.guid.guid(),
      text: faker.lorem.sentence(),
      date: DateTime.now(),
    );
    mockHttpData();
  });

  test('Should call request client with correct value', () async {
    await sout.create(entity: idunDataEntity);

    verify(() => httpclient.request(url: url, method: 'post'));
  });

  test('should return client error 400 invalid fields ', () async {
    mockHttpError();

    var future = sout.create(entity: idunDataEntity);

    expect(future, throwsA(DomainError.invalidFields));
  });
}
