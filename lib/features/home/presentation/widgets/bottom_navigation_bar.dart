import 'package:flutter/material.dart';
import 'package:my_app/features/home/presentation/views/home_page.dart';
import 'package:my_app/features/home/presentation/views/saved_news_page.dart';
import 'package:my_app/theme/theme.dart';
import 'package:my_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../provider/news_provider.dart';

class BottomNavBar extends StatefulWidget {
  static const String screenRoute = '/bottomNavBar';
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final newsProvider = Provider.of<NewsProvider>(context, listen: false);
      newsProvider.fetchNews();
      newsProvider.loadSavedNews();
    });
  }

  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    SavedNewsPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    bool isLight = themeProvider.themeData == lightMode;
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            label: 'Saved news',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedFontSize: 18,
        selectedIconTheme: IconThemeData(
            color: isLight ? Colors.blue : Colors.deepPurple[400], size: 28),
        selectedItemColor: isLight ? Colors.blue : Colors.deepPurple[400],
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
        onTap: _onItemTapped,
      ),
    );
  }
}
