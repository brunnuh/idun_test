import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class GetData {
  final Client client;
  final String url;

  GetData({required this.client, required this.url});

  Future call() async {
    await client.request(url: url, method: 'get');
  }
}

abstract class Client {
  Future<void>? request({required String url, required String method});
}

class ClientSpy extends Mock implements Client{}



void main() {
  late ClientSpy client;
  late GetData sut;
  late String url;

  setUp(() {
    url = faker.internet.httpsUrl();
    client = ClientSpy();
    sut = GetData(client: client, url: url);
  });

  test('Should call request client with correct values', () async {
    await sut.call();

    verify(client.request(url: url, method: 'get'));
  });
  
  test("", (){

  });
}
