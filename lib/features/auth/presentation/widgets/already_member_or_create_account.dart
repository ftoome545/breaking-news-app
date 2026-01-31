import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_app/theme/theme.dart';
import 'package:provider/provider.dart';

import '../../../../theme/theme_provider.dart';

class AlreadyMemberOrCreateAccount extends StatelessWidget {
  const AlreadyMemberOrCreateAccount({
    super.key,
    required this.title,
    required this.subTitle,
    required this.onTap,
  });
  final String title;
  final String subTitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isLight = themeProvider.themeData == lightMode;
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: TextSpan(
            text: title,
            style: TextStyle(
              fontSize: 18.0,
              color: isLight ? Colors.black : Colors.white,
            ),
            children: [
              TextSpan(
                  text: subTitle,
                  style: TextStyle(
                      fontSize: 18,
                      color: isLight ? Colors.blue : Colors.deepPurple[400],
                      fontWeight: FontWeight.bold),
                  recognizer: TapGestureRecognizer()..onTap = onTap),
            ]),
      ),
    );
  }
}
