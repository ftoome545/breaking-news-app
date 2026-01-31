import 'package:flutter/material.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/features/home/presentation/provider/news_provider.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme.dart';
import '../../../../theme/theme_provider.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/news_container.dart';

class SavedNewsPage extends StatelessWidget {
  const SavedNewsPage({super.key});
  static const String screenRoute = 'saved_news';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved news'),
        centerTitle: true,
        actions: [
          Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Consumer<ThemeProvider>(
                builder: (context, themeProvider, state) {
                  bool isLight = themeProvider.themeData == lightMode;
                  return IconButton(
                    icon: isLight
                        ? const Icon(Icons.dark_mode)
                        : const Icon(Icons.light_mode),
                    onPressed: () {
                      themeProvider.toggleTheme();
                    },
                  );
                },
              ))
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kHorizontal, vertical: kVertical),
        child: Consumer<NewsProvider>(
          builder: (context, newsProvider, state) {
            return newsProvider.savedNewsList.isEmpty
                ? const Center(
                    child: Text('No saved news yet',
                        style: TextStyle(fontSize: 24)))
                : ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: newsProvider.savedNewsList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: NewsCard(
                          newsModel: newsProvider.savedNewsList[index],
                        ),
                      );
                    },
                  );
          },
        ),
      ),
    );
  }
}
