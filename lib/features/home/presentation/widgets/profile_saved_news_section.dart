import 'package:flutter/material.dart';
import 'package:my_app/features/home/presentation/widgets/saved_news_body.dart';

class ProfileSavedNewsSection extends StatelessWidget {
  const ProfileSavedNewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved news'),
        centerTitle: true,
      ),
      body: const SavedNewsBody(),
    );
  }
}
