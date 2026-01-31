import 'package:flutter/material.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/features/home/data/repos/news_repo.dart';
import 'package:my_app/core/services/shared_preferences_service.dart';

import '../../data/models/news_model.dart';

class NewsProvider extends ChangeNotifier {
  final NewsRepo newsRepo;
  NewsProvider({required this.newsRepo});
  List<NewsModel> _newsList = [];
  List<NewsModel> get newsList => _newsList;
  bool isLoading = false;
  String? errorMessage;
  IconData errorIcon = Icons.error;
  String? catErrorMessage;
  List<NewsModel> savedNewsList = [];

  List<NewsModel> _categoryBasedList = [];
  List<NewsModel> get catList => _categoryBasedList;

  String selectedCategory = 'all';

  List<NewsModel> get displayedNews {
    if (selectedCategory == 'all') {
      return newsList;
    }
    return catList;
  }

  Future<void> fetchNews() async {
    isLoading = true;
    notifyListeners();

    final result = await newsRepo.getNews();
    result.fold((failure) {
      isLoading = false;
      notifyListeners();
      errorMessage = failure.message;
      errorIcon = failure.icon;
    }, (news) {
      isLoading = false;
      errorMessage = null;
      notifyListeners();
      _newsList = news;
    });
  }

  Future<void> getNewsCategories(
      {required String category, required List<NewsModel> allNews}) async {
    selectedCategory = category;
    if (category == 'all') {
      _categoryBasedList = newsList;
      notifyListeners();
    } else {
      final result =
          newsRepo.getNewsCategories(category: category, allNews: allNews);
      result.fold((failure) {
        catErrorMessage = failure.message;
        notifyListeners();
      }, (filtredNews) {
        _categoryBasedList = filtredNews;
        catErrorMessage = null;
        notifyListeners();
      });
    }
  }

  Future<void> loadSavedNews() async {
    savedNewsList = SharedPreferencesService.getNewsModel(ksavedNewsList);
    notifyListeners();
  }

  void manageSavedNews(NewsModel item) {
    if (savedNewsList.contains(item)) {
      savedNewsList.remove(item);
    } else {
      savedNewsList.add(item);
    }
    SharedPreferencesService.setNewsList(ksavedNewsList, savedNewsList);
    notifyListeners();
  }
}
