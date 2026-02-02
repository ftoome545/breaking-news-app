import 'package:flutter/material.dart';
import 'package:my_app/features/home/presentation/provider/news_provider.dart';
import 'package:my_app/features/home/presentation/widgets/artical_date_and_time.dart';
import 'package:my_app/features/home/data/models/news_model.dart';
import 'package:my_app/theme/theme.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../theme/theme_provider.dart';

class NewsCard extends StatefulWidget {
  const NewsCard({
    super.key,
    required this.newsModel,
  });

  final NewsModel newsModel;

  @override
  State<NewsCard> createState() => _NewsCardState();
}

class _NewsCardState extends State<NewsCard> {
  void launchNewsArticleUrl(String newsUrl) async {
    final url = newsUrl;
    if (!await launchUrl(Uri.parse(url),
        mode: LaunchMode.externalApplication)) {
      throw Exception("Coudn't launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    bool isLight = themeProvider.themeData == lightMode;
    return Stack(
      alignment: Alignment.topRight,
      children: [
        GestureDetector(
          onTap: () {
            launchNewsArticleUrl(widget.newsModel.link);
          },
          child: Container(
            decoration: ShapeDecoration(
                color: isLight ? Colors.grey[300] : Colors.grey[500],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                )),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(4)),
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: widget.newsModel.imageUrl.isEmpty
                        ? Image.asset("images/news image.jpg",
                            fit: BoxFit.cover)
                        : Image.network(widget.newsModel.imageUrl,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "images/news image.jpg",
                              fit: BoxFit.cover,
                            );
                          }, loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }),
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ArticalDateAndTime(
                              text: dateFormate(widget.newsModel.publishedDate),
                              icon: Icons.calendar_month_outlined),
                          const SizedBox(
                            width: 12,
                          ),
                          ArticalDateAndTime(
                              text: timeFormate(widget.newsModel.publishedDate),
                              icon: Icons.watch_later_outlined),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(widget.newsModel.title,
                          style: TextStyle(
                              height: 1.2,
                              color: isLight ? Colors.black : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold)),
                      widget.newsModel.description.isNotEmpty
                          ? Column(
                              children: [
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                  widget.newsModel.description,
                                  style: TextStyle(
                                    color:
                                        isLight ? Colors.black : Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 8,
                                ),
                              ],
                            )
                          : const SizedBox(
                              height: 8,
                            ),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 10,
                            backgroundImage:
                                NetworkImage(widget.newsModel.sourceIcon),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(widget.newsModel.sourceName),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Wrap(
                        spacing: 6,
                        children: List.generate(
                            widget.newsModel.category.length, (indext) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 4),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 8),
                              decoration: ShapeDecoration(
                                  color: isLight
                                      ? const Color.fromARGB(58, 33, 149, 243)
                                      : const Color.fromARGB(44, 104, 58, 183),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25))),
                              child: Text(
                                widget.newsModel.category[indext],
                                style: TextStyle(
                                    color: isLight
                                        ? Colors.blue
                                        : Colors.deepPurple[400]),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(right: 12, top: 12),
          child: Consumer<NewsProvider>(
            builder: (context, newsProvider, state) {
              bool isSaved =
                  newsProvider.savedNewsList.contains(widget.newsModel);
              return GestureDetector(
                onTap: () {
                  newsProvider.manageSavedNews(widget.newsModel);
                },
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.all(8),
                  decoration: const ShapeDecoration(
                      color: Colors.white, shape: CircleBorder()),
                  child: Icon(
                    isSaved ? Icons.bookmark : Icons.bookmark_outline,
                    color: isSaved ? Colors.amber : Colors.black,
                  ),
                ),
              );
            },
          ),
        )
      ],
    );
  }

  String dateFormate(String date) {
    String extractedDate = date.split(' ').elementAt(0).toString();
    return extractedDate;
  }

  String timeFormate(String date) {
    String extractedTime = date.split(' ').elementAt(1).toString();
    return extractedTime;
  }
}
