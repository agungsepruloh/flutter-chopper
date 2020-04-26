import 'package:chopper/chopper.dart';

part 'post_api_service.chopper.dart';

@ChopperApi(baseUrl: '/posts')
abstract class PostApiService extends ChopperService {
  @Get()
  Future<Response> getPosts();

  @Get(path: '/{id}')
  Future<Response> getPost(@Path('id') int id);

  @Post()
  Future<Response> postPost(
    @Body() Map<String, dynamic> body,
  );

  static PostApiService create() {
    final client = ChopperClient(
      baseUrl: 'https://jsonplaceholder.typicode.com',
      services: [_$PostApiService()],
      converter: JsonConverter(),
      interceptors: [
        HeadersInterceptor({'Cache-Control': 'no-cache'}),  // Headers interceptor
        HttpLoggingInterceptor(), // logging the http interceptor
        CurlInterceptor(), // Curl interceptor
        (Request request) async {
          if (request.method == HttpMethod.Post)
            chopperLogger.info('Performed a POST request');
          return request; // don't forget to return the request
        },
        (Response response) async {
          if (response.statusCode == 404) {
            chopperLogger.severe('404 Not Found');
          }
          return response;
        }
      ],
    );

    return _$PostApiService(client);
  }
}
