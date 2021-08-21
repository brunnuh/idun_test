import 'package:faker/faker.dart';
import 'package:idun_test/data/client/client.dart';
import 'package:idun_test/domain/helpers/helpers.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';


import 'package:idun_test/data/models/data_model.dart';

import 'package:idun_test/domain/entities/entities.dart';


class LoadData {
  final Client<List<Map>> client;
  final String url;

  LoadData({required this.client, required this.url});

  Future<List<IdunDataEntity>> call() async {
    try{
      final response = await client.request(url: url, method: 'get');
      return response.map((json) => DataModel.fromJson(json).toEntity()).toList();
    }on ClientError{
      throw DomainError.Unexpected;
    }
  }
}

abstract class Client<ResponseType> {
  Future<ResponseType> request({required String url, required String method});
}

class ClientSpy extends Mock implements Client<List<Map>> {}


void main() {
  late ClientSpy client;
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
    return when(() => client.request(url: any(named: "url"), method: any(named: "method")));
  }

  void mockHttpData(List<Map> list) {
    mockRequest().thenAnswer((_) async =>
        list);
  }

  void mockHttpError(ClientError error){
    mockRequest().thenThrow(error);
  }



  setUp(() {
    url = faker.internet.httpsUrl();
    client = ClientSpy();
    sut = LoadData(client: client, url: url);
    list = mockValidData();
    mockHttpData(list);
  });



  test('Should call request client with correct values', () async {
    await sut.call();

    verify(() => client.request(url: url, method: 'get')).called(1);
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
    mockHttpError(ClientError.NotFound);

    final future = sut.call();

    expect(future, throwsA(DomainError.Unexpected));
  });


}
