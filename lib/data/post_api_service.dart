import 'package:built_collection/built_collection.dart';
import 'package:chopper/chopper.dart';

import '../model/built_post.dart';
import 'built_value_converter.dart';
import 'mobile_data_interceptor.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response<BuiltList<BuiltPost>>> getPosts();

  @Get(path: '/{id}')
  Future<Response<BuiltPost>> getPost(@Path('id') int id);

  @Post()
  Future<Response<BuiltPost>> postPost(
    @Body() BuiltPost body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [_$PostApiService()],
      converter: BuiltValueConverter(),
      interceptors: [
        HttpLoggingInterceptor(), // logging the http interceptor
        MobileDataInterceptor(), // Custom interceptor

        // HeadersInterceptor({'Cache-Control': 'no-cache'}),  // Headers interceptor
        // CurlInterceptor(), // Curl interceptor
        // (Request request) async {
        //   if (request.method == HttpMethod.Post)
        //     chopperLogger.info('Performed a POST request');
        //   return request; // don't forget to return the request
        // },
        // (Response response) async {
        //   if (response.statusCode == 404) {
        //     chopperLogger.severe('404 Not Found');
        //   }
        //   return response;
        // },
      ],
    );

    return _$PostApiService(client);
  }
}
