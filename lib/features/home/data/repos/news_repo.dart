import 'package:dartz/dartz.dart';
import 'package:my_app/core/network/exception_model.dart';
import 'package:my_app/features/home/data/models/news_model.dart';

import '../../../../core/error/failures.dart';

abstract class NewsRepo {
  Future<Either<ExceptionModel, List<NewsModel>>> getNews();
  Either<Failures, List<NewsModel>> getNewsCategories(
      {required String category, required List<NewsModel> allNews});
}
