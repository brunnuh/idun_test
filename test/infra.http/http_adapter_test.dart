import 'package:dio/dio.dart';
import 'package:faker/faker.dart';
import 'package:idun_test/data/http/http.dart';
import 'package:idun_test/domain/helpers/domain_error.dart';
import 'package:mocktail/mocktail.dart';

import 'package:test/test.dart';



class HttpAdapter{
  final Dio client;

  HttpAdapter(this.client);

  Future<void> request({required String url, required String method}) async {
    try{
      await client.get(url);
    } catch(e){

    }
  }
}

class HttpAdapterSpy extends Mock implements Dio{}

void main(){
  late HttpAdapterSpy client;
  late HttpAdapter sut;
  late String url;

  setUpAll((){
    url = faker.internet.httpUrl();
    client = HttpAdapterSpy();
    sut = HttpAdapter(client);
  });

   group("get", (){
     test('should call get with correct values', () async {
       await sut.request(url: url, method: 'get');

       verify(() => client.get(url));
     });
   });
}