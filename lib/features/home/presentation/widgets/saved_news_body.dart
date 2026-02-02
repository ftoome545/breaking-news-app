import 'package:flutter/material.dart';
import 'package:my_app/features/home/presentation/provider/news_provider.dart';
import 'package:my_app/features/home/presentation/widgets/news_container.dart';
import 'package:provider/provider.dart';

import '../../../../constants.dart';

class SavedNewsBody extends StatelessWidget {
  const SavedNewsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
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
