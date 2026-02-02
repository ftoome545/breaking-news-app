import 'package:flutter/material.dart';
import 'package:my_app/features/auth/presentation/widgets/already_member_or_create_account.dart';
import 'package:my_app/features/auth/presentation/provider/auth_state_manager.dart';
import 'package:my_app/features/auth/presentation/views/sign_up_page.dart';
import 'package:my_app/shared/build_message_bar.dart';
import 'package:my_app/shared/custom_button.dart';
import 'package:my_app/shared/custom_password_field.dart';
import 'package:my_app/shared/custom_text_form_field.dart';
import 'package:provider/provider.dart';

import '../../../../routes_names.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/theme_provider.dart';

class LogInPage extends StatefulWidget {
  static const String screenRoute = '/logInPage';
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  String email = '';
  String password = '';

  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthStateManager>();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isLight = themeProvider.themeData == lightMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log In'),
        centerTitle: true,
      ),
      body: auth.isLoggingIn
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email',
                        style: TextStyle(
                            color:
                                isLight ? Colors.blue : Colors.deepPurple[400],
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomTextFormField(
                          onSaved: (value) {
                            email = value!;
                          },
                          hintText: 'user@gmail.com',
                          keyboardType: TextInputType.emailAddress),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Password',
                        style: TextStyle(
                            color:
                                isLight ? Colors.blue : Colors.deepPurple[400],
                            fontSize: 20),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      CustomPasswordField(onSaved: (value) {
                        password = value!;
                      }),
                      const SizedBox(
                        height: 12,
                      ),
                      if (auth.logInErrorMessage != null)
                        Text(
                          auth.logInErrorMessage!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      const SizedBox(
                        height: 25,
                      ),
                      AlreadyMemberOrCreateAccount(
                        title: 'New here? ',
                        subTitle: 'Sign UP',
                        onTap: () {
                          Provider.of<AuthStateManager>(context, listen: false)
                              .clearErrorMessage();
                          Navigator.pushNamed(context, SignUpPage.screenRoute);
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        text: 'LogIn',
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            await auth.signIn(
                                email: email.trim(), password: password.trim());

                            if (auth.currentUser != null) {
                              if (!context.mounted) return;
                              buildMessageBar(context,
                                  const Text("You logged in Successfully"));
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                bottomNavigationBar,
                                (route) => false,
                              );
                            }
                          } else {
                            autovalidateMode = AutovalidateMode.always;
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
