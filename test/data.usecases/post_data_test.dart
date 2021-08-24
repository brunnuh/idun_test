import 'package:faker/faker.dart';
import 'package:idun_test/data/http/http.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';

import 'package:idun_test/domain/entities/entities.dart';
import 'package:idun_test/domain/usecases/usecases.dart';

class HttpClientSpy extends Mock implements HttpClient{}

class PostData {
  final HttpClient httpclient;
  final String url;

  PostData({required this.httpclient, required this.url});

  Future create({required IdunDataEntity entity}) async {
    await httpclient.request(url: url, method: 'post');
  }
}

void main() {

  late HttpClientSpy httpclient;
  late String url;
  late PostData sout;
  late IdunDataEntity idunDataEntity;

  When mockRequest() {
    return when(()=> httpclient.request(url: any(named: "url"), method: any(named: "method")));
  }

  void mockHttpData() {
    mockRequest().thenAnswer((_) async => idunDataEntity);
  }

  setUp((){
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


}
