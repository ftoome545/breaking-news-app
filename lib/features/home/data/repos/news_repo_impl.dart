import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/network/dio_exception_handler.dart';
import 'package:my_app/core/network/exception_model.dart';
import 'package:my_app/core/network/news_api_service.dart';
import 'package:my_app/features/home/data/models/news_model.dart';
import 'package:my_app/features/home/data/repos/news_repo.dart';

class NewsRepoImpl implements NewsRepo {
  final NewsApiService service;
  NewsRepoImpl({required this.service});

  @override
  Future<Either<ExceptionModel, List<NewsModel>>> getNews() async {
    try {
      final Response response = await service.getNewsResponse();
      final dynamic data = response.data;
      final List<NewsModel> news = [];
      for (var item in data['results']) {
        news.add(NewsModel.fromJson(item));
      }
      return right(news);
    } catch (e) {
      return left(DioExceptionHandler.dioHandler(e));
    }
  }

  @override
  Either<Failures, List<NewsModel>> getNewsCategories(
      {required String category, required List<NewsModel> allNews}) {
    try {
      final List<NewsModel> result = allNews.where((news) {
        return news.category.contains(category);
      }).toList();
      return right(result);
    } catch (e) {
      return left(ServerFailure("getNewsCategories: ${e.toString()}"));
    }
  }
}
