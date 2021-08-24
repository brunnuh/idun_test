import 'package:faker/faker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:idun_test/domain/helpers/helpers.dart';
import 'package:idun_test/data/usecases/usecases.dart';
import 'package:idun_test/domain/entities/entities.dart';

import 'package:idun_test/data/models/data_model.dart';
import 'package:idun_test/data/http/http.dart';


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
