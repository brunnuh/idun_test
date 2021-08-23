import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:idun_test/data/http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

class HttpAdapter {
  final Dio client;

  HttpAdapter(this.client);

  Future request({required String url, required String method}) async {
    var response = await client.get(url);
    return _handleResponse(response);
  }

  List _handleResponse(Response response) {
    if (response.data != null && response.statusCode == 200) {
      return jsonDecode(response.data);
    } else if (response.statusCode == 404) {
      throw HttpError.NotFound;
    } else {
      throw HttpError.serverError;
    }
  }
}

class HttpAdapterSpy extends Mock implements Dio {}

void main() {
  late HttpAdapterSpy client;
  late HttpAdapter sut;
  late String url;

  // dados especificos da api

  List<Map> listIdunResponse = [
    {"guid": "string", "date": "2021-08-22T15:16:15.730Z", "text": "string"},
    {"guid": "string", "date": "2021-08-22T15:16:15.730Z", "text": "string"}
  ];

  void mockResponse({int statuscode = 200, required String url}) {
    when(() => client.get(
              url,
            ))
        .thenAnswer((_) async => Response(
            statusCode: statuscode,
            requestOptions: RequestOptions(path: url),
            data: jsonEncode(listIdunResponse)));
  }

  group("get", () {
    setUp(() {
      url = faker.internet.httpUrl();
      client = HttpAdapterSpy();
      sut = HttpAdapter(client);
      mockResponse(url: url);
    });

    test('should call get with correct values', () async {
      await sut.request(url: url, method: 'get');

      verify(() => client.get(url));
    });

    test('should return notFound if get returns 404', () {
      mockResponse(statuscode: 404, url: url);

      final future = sut.request(url: url, method: 'get');

      expect(future, throwsA(HttpError.NotFound));
    });
  });
}
