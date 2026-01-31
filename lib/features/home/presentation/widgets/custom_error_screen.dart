import 'package:flutter/material.dart';
import 'package:my_app/features/home/presentation/provider/news_provider.dart';
import 'package:provider/provider.dart';

class CustomErrorScreen extends StatelessWidget {
  const CustomErrorScreen(
      {super.key, required this.errorMessage, required this.icon});
  final String errorMessage;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Column(
        children: [
          errorMessage.isEmpty
              ? Container(
                  height: 200,
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                      color: Colors.purple[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      )),
                  child: Image.asset('images/no-data.png'))
              : Container(
                  height: 200,
                  padding: const EdgeInsets.all(15),
                  decoration: ShapeDecoration(
                      color: Colors.purple[100],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      )),
                  child: errorMessage.contains('internet')
                      ? Image.asset('images/no-wifi.png')
                      : Image.asset('images/warning.png')),

          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                    textAlign: TextAlign.center,
                    errorMessage.isEmpty
                        ? 'No news found for this category'
                        : errorMessage,
                    style: const TextStyle(fontSize: 24)),
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          errorMessage.isEmpty
              ? const SizedBox()
              : Row(
                  children: [
                    Expanded(
                        child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                          onPressed: () async {
                            Future.delayed(const Duration(seconds: 1));
                            Provider.of<NewsProvider>(context, listen: false)
                                .fetchNews();
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.refresh),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Reload the screen',
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          )),
                    )),
                  ],
                )
          // : const SizedBox(),
        ],
      ),
    );
  }
}
