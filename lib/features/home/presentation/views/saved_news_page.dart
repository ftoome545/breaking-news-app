import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme.dart';
import '../../../../theme/theme_provider.dart';
import '../widgets/custom_drawer.dart';
import '../widgets/saved_news_body.dart';

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
      body: const SavedNewsBody(),
    );
  }
}
