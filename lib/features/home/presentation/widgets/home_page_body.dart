import 'package:flutter/material.dart';
import 'package:my_app/features/home/presentation/provider/news_provider.dart';
import 'package:my_app/features/home/presentation/widgets/custom_error_screen.dart';
import 'package:my_app/features/home/presentation/widgets/news_categories.dart';
import 'package:my_app/features/home/presentation/widgets/news_container.dart';
import 'package:provider/provider.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        Future.delayed(const Duration(seconds: 1));
        Provider.of<NewsProvider>(context, listen: false).fetchNews();
      },
      child: CustomScrollView(
        slivers: [
          const SliverToBoxAdapter(
            child: Column(
              children: [
                NewsCategories(),
                SizedBox(
                  height: 16,
                ),
              ],
            ),
          ),
          Consumer<NewsProvider>(
            builder: (context, newsProvider, state) {
              if (newsProvider.isLoading) {
                return const SliverToBoxAdapter(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (newsProvider.displayedNews.isEmpty) {
                return SliverToBoxAdapter(
                  child: CustomErrorScreen(
                    errorMessage: newsProvider.errorMessage ?? '',
                    icon: newsProvider.errorIcon,
                  ),
                );
              } else {
                return SliverToBoxAdapter(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: newsProvider.displayedNews.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: NewsCard(
                          newsModel: newsProvider.displayedNews[index],
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
