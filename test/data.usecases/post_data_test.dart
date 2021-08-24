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
  late PostData sut;
  late IdunDataEntity idunDataEntity;

  When mockRequest() {
    return when(() => httpclient.request(
        url: any(named: "url"), method: any(named: "method")));
  }

  void mockHttpData() {
    mockRequest().thenAnswer((_) async => idunDataEntity);
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
    mockHttpData();
  });

  test('Should call request client with correct value', () async {
    await sut.create(entity: idunDataEntity);

    verify(() => httpclient.request(url: url, method: 'post'));
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
}
