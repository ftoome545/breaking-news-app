import 'package:flutter/material.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/core/services/push_messaging_service.dart';
import 'package:my_app/core/services/shared_preferences_service.dart';
import 'package:my_app/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme_provider.dart';

class SettingsPageBody extends StatefulWidget {
  const SettingsPageBody({super.key});

  static const screenRoute = '/settings_page';

  @override
  State<SettingsPageBody> createState() => _SettingsPageBodyState();
}

class _SettingsPageBodyState extends State<SettingsPageBody> {
  late bool _notifEnabled;

  @override
  void initState() {
    super.initState();
    _notifEnabled = SharedPreferencesService.getNotifications(kNotifications);
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    bool isLight = themeProvider.themeData == lightMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kHorizontal, vertical: kVertical),
        child: Column(
          children: [
            SettingsBox(
              title: 'Dark Mode',
              onChanged: (bool newValue) {
                themeProvider.toggleTheme();
              },
              value: !isLight,
            ),
            const SizedBox(
              height: 12,
            ),
            SettingsBox(
              title: 'Notification',
              onChanged: (value) async {
                setState(() {
                  _notifEnabled = value;
                });

                await SharedPreferencesService.setNotifications(
                    kNotifications, value);

                await PushMessagingService().toggleNotifications(value);
              },
              value: _notifEnabled,
            ),
          ],
        ),
      ),
    );
  }
}

class SettingsBox extends StatelessWidget {
  const SettingsBox({
    super.key,
    required this.title,
    required this.onChanged,
    required this.value,
  });

  final String title;
  final void Function(bool)? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    bool isLight = themeProvider.themeData == lightMode;
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: ShapeDecoration(
          color: isLight ? Colors.grey[300] : Colors.grey[500],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          )),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
                color: isLight ? Colors.black : Colors.white, fontSize: 18),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeTrackColor: isLight ? Colors.blue : Colors.deepPurple[400],
            // trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
          )
        ],
      ),
    );
  }
}
