import 'package:flutter/material.dart';
import 'package:my_app/theme/theme.dart';
import 'package:my_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

import '../../../../routes_names.dart';

class NextScreen extends StatelessWidget {
  static const String screenRoute = '/nextPage';
  const NextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              Text(
                'WELCOME TO OUR BREAKING NEWS APP',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24,
                    color: themeProvider.themeData == lightMode
                        ? Colors.black
                        : Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              const SizedBox(
                height: 33,
              ),
              Center(
                child: SizedBox(
                  height: MediaQuery.sizeOf(context).height * .4,
                  child: Image.asset(
                    'images/breaking_news_image.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(
                height: 33,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 55,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, logInPage);
                        },
                        child: const Text(
                          'LOGIN',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                        height: 55,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, signUpPage);
                            },
                            child: const Text(
                              'SIGNUP',
                              style: TextStyle(fontSize: 20),
                            ))),
                  ),
                ],
              ),
              // const SizedBox(
              //   height: 12,
              // ),
              // IconButton(
              //   icon: themeProvider.themeData == lightMode
              //       ? const Icon(Icons.dark_mode)
              //       : const Icon(Icons.light_mode),
              //   onPressed: () {
              //     themeProvider.toggleTheme();
              //   },
              // )
            ],
          ),
        ),
      ),
    );
  }
}
