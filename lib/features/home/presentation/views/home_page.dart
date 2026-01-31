import 'package:flutter/material.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/features/home/presentation/widgets/custom_drawer.dart';
import 'package:provider/provider.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/theme_provider.dart';
import '../widgets/home_page_body.dart';

class HomePage extends StatefulWidget {
  static const String screenRoute = '/homePage';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
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
      body: const Padding(
        padding:
            EdgeInsets.symmetric(horizontal: kHorizontal, vertical: kVertical),
        child: HomePageBody(),
      ),
    );
  }
}
