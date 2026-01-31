import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});
  static const String screenRoute = 'privacy_policy';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
        centerTitle: true,
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Privacy Matters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      'We respect your privacy and are committed to protecting your personal information. '
                      'This app does not collect or store any personal data without your consent.',
                      style: TextStyle(height: 1.4),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Data Usage',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '• News content is fetched from third-party APIs.\n'
                      '• We do not sell, trade, or share your personal information.\n'
                      '• Images and content are displayed as provided by the source.',
                      style: TextStyle(height: 1.4),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Changes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'This policy may be updated from time to time. '
                      'Any changes will be reflected within the app.',
                      style: TextStyle(height: 1.4),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Last updated: January 2026',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
