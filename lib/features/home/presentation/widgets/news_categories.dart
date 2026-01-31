import 'package:flutter/material.dart';
import 'package:my_app/features/home/presentation/provider/news_provider.dart';
import 'package:provider/provider.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/theme_provider.dart';

class NewsCategories extends StatefulWidget {
  const NewsCategories({super.key});
  @override
  State<NewsCategories> createState() => _NewsCategoriesState();
}

class _NewsCategoriesState extends State<NewsCategories> {
  String selectedCategory = 'All';
  List<String> categorites = [
    'All',
    'Top',
    'Politics',
    'Sports',
    'Business',
    'Lifestyle',
    'Breaking',
    'Crime',
    'top news',
    'world',
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    bool isLight = themeProvider.themeData == lightMode;
    final newsProvider = Provider.of<NewsProvider>(context, listen: true);
    return SizedBox(
      height: 50,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: categorites.map((category) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: ChoiceChip(
              label: Text(category),
              selected: selectedCategory == category,
              showCheckmark: false,
              selectedColor: isLight ? Colors.blue : Colors.deepPurple[400],
              backgroundColor: Colors.white,
              labelStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: selectedCategory == category
                      ? Colors.white
                      : const Color(0xff84888B)),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                  side: selectedCategory == category
                      ? BorderSide.none
                      : const BorderSide(width: 1, color: Color(0xffE0E3EA))),
              onSelected: (selected) {
                setState(() {
                  selectedCategory = category;
                });
                newsProvider.getNewsCategories(
                    category: category.toLowerCase(),
                    allNews: newsProvider.newsList);
              },
            ),
          );
        }).toList(),
      ),
    );
  }
}
