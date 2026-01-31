import 'package:dio/dio.dart';

class NewsApiService {
  final Dio dio;

  NewsApiService({
    required this.dio,
  });

  Future<Response> getNewsResponse() async {
    final response = await dio.get(
        options: Options(receiveTimeout: const Duration(seconds: 3)),
        "https://newsdata.io/api/1/latest?apikey=pub_0219af225c394dbaa95409f81f1babf1&q=nepal");
    return response;
  }
}
