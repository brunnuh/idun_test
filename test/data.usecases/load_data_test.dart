import 'package:flutter_test/flutter_test.dart';
import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';

import 'package:idun_test/data/http/http.dart';
import 'package:idun_test/data/usecases/usecases.dart';

import 'package:idun_test/domain/entities/entities.dart';
import 'package:idun_test/domain/helpers/helpers.dart';


class HttpClientSpy extends Mock implements HttpClient<List<Map>> {}


void main() {
  late HttpClientSpy httpclient;
  late LoadData sut;
  late String url;
  late List<Map> list;

  List<Map> mockValidData() =>
      [
        {
          'guid': faker.guid.guid(),
          'text': faker.lorem.sentence(),
          'date': faker.date.dateTime().toIso8601String(),
        },
        {
          'guid': faker.guid.guid(),
          'text': faker.lorem.sentence(),
          'date': faker.date.dateTime().toIso8601String(),
        }
      ];
  When mockRequest() {
    return when(()=>httpclient.request(url: any(named: "url"), method: any(named: "method")));
  }

  void mockHttpData(List<Map> list) {
    mockRequest().thenAnswer((_) async =>
    list);
  }

  void mockHttpError(HttpError error){
    mockRequest().thenThrow(error);
  }


  setUp(() {
    url = faker.internet.httpsUrl();
    httpclient = HttpClientSpy();
    sut = LoadData(httpclient: httpclient, url: url);
    list = mockValidData();
    mockHttpData(list);
  });



  test('Should call request client with correct values', () async {
    await sut.call();

    verify(() => httpclient.request(url: url, method: 'get'));
  });

  test("Should return Idun data on 200", () async {
    final response = await sut.call();

    expect(response, [
      IdunDataEntity(guid: list[0]['guid'], date: DateTime.parse(list[0]['date']), text: list[0]['text']),
      IdunDataEntity(guid: list[1]['guid'], date: DateTime.parse(list[1]['date']), text: list[1]['text']),
    ]);
  });

  test("Should throw UnexpectError if Client return 200 with invalid data", () {
    mockHttpData([{"key_invalid" : "value_invalid"}]);

    final future = sut.call();

    expect(future, throwsA(DomainError.Unexpected));
  });

  test("should return client error 404 with invalid url", () async {
    mockHttpError(HttpError.NotFound);

    final future = sut.call();

    expect(future, throwsA(DomainError.Unexpected));
  });


}