import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_app/features/auth/data/repos/auth_repo.dart';
import 'package:my_app/features/auth/presentation/views/next_screen.dart';
import 'package:my_app/features/auth/presentation/provider/auth_state_manager.dart';
import 'package:my_app/features/home/presentation/provider/news_provider.dart';
import 'package:my_app/features/home/presentation/views/saved_news_page.dart';
import 'package:my_app/features/home/presentation/widgets/news_details_page.dart';
import 'package:my_app/features/home/presentation/widgets/privacy_policy_screen.dart';
import 'package:my_app/features/home/presentation/widgets/profile_page_body.dart';
import 'package:my_app/features/home/presentation/widgets/settings_page_body.dart';
import 'package:my_app/features/home/data/repos/news_repo.dart';
import 'package:my_app/features/home/presentation/widgets/bottom_navigation_bar.dart';
import 'package:my_app/core/services/push_messaging_service.dart';
import 'package:my_app/core/services/get_it_service.dart';
import 'package:my_app/features/home/presentation/views/home_page.dart';
import 'package:my_app/features/auth/presentation/views/login_page.dart';
import 'package:my_app/features/auth/presentation/views/sign_up_page.dart';
import 'package:my_app/splash_page.dart';
import 'package:my_app/core/services/shared_preferences_service.dart';
import 'package:my_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferencesService.init();
  setUpGetIt();
  await PushMessagingService().initNotifications();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(
            create: (context) => AuthStateManager(authRepo: getIt<AuthRepo>())),
        ChangeNotifierProvider(
            create: (context) => NewsProvider(newsRepo: getIt<NewsRepo>())),
      ],
      child: const MyApp(),
    ),
  );
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Provider.of<ThemeProvider>(context).themeData,
      home: const SplashScreen(),
      navigatorKey: navigatorKey,
      routes: {
        LogInPage.screenRoute: (context) => const LogInPage(),
        SignUpPage.screenRoute: (context) => const SignUpPage(),
        HomePage.screenRoute: (context) => const HomePage(),
        NextScreen.screenRoute: (context) => const NextScreen(),
        SplashScreen.screenRoute: (context) => const SplashScreen(),
        BottomNavBar.screenRoute: (context) => const BottomNavBar(),
        NewsDetailsPage.screenRoute: (context) => const NewsDetailsPage(),
        SettingsPageBody.screenRoute: (context) => const SettingsPageBody(),
        ProfilePageBody.screenRoute: (context) => const ProfilePageBody(),
        SavedNewsPage.screenRoute: (context) => const SavedNewsPage(),
        PrivacyPolicyScreen.screenRoute: (context) =>
            const PrivacyPolicyScreen(),
      },
    );
  }
}
