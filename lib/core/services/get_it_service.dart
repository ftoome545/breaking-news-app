import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:my_app/features/auth/data/repos/auth_repo.dart';
import 'package:my_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:my_app/core/services/firebase_auth_service.dart';
import 'package:my_app/core/network/news_api_service.dart';
import 'package:my_app/features/home/data/repos/news_repo.dart';
import 'package:my_app/features/home/data/repos/news_repo_impl.dart';
import 'package:my_app/core/services/firestore_service.dart';

final getIt = GetIt.instance;

void setUpGetIt() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<FirestoreService>(FirestoreService());
  getIt.registerSingleton<AuthRepo>(
    AuthRepoImpl(
        authService: FirebaseAuthService(),
        firestoreService: FirestoreService()),
  );
  getIt.registerSingleton<NewsApiService>(NewsApiService(dio: Dio()));
  getIt.registerSingleton<NewsRepo>(
      NewsRepoImpl(service: NewsApiService(dio: Dio())));
}
