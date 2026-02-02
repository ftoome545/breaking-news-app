import 'package:flutter/material.dart';
import 'package:my_app/features/auth/presentation/widgets/already_member_or_create_account.dart';
import 'package:my_app/features/auth/presentation/provider/auth_state_manager.dart';
import 'package:my_app/features/auth/presentation/views/login_page.dart';
import 'package:provider/provider.dart';

import '../../../../routes_names.dart';
import '../../../../shared/build_message_bar.dart';
import '../../../../shared/custom_button.dart';
import '../../../../shared/custom_password_field.dart';
import '../../../../shared/custom_text_form_field.dart';
import '../../../../theme/theme.dart';
import '../../../../theme/theme_provider.dart';

class SignUpPage extends StatefulWidget {
  static const String screenRoute = '/signUpPage';
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String name = '';
  String email = '';
  String password = '';

  final GlobalKey<FormState> _formKey = GlobalKey();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) {
    var authProvider = context.watch<AuthStateManager>();
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    bool isLight = themeProvider.themeData == lightMode;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
      ),
      body: authProvider.isSigningUp
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Form(
                  key: _formKey,
                  autovalidateMode: autovalidateMode,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'User name',
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
                            name = value!;
                          },
                          hintText: 'user name',
                          keyboardType: TextInputType.name),
                      const SizedBox(
                        height: 16,
                      ),
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
                        keyboardType: TextInputType.emailAddress,
                      ),
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
                      CustomPasswordField(
                        onSaved: (value) {
                          password = value!;
                        },
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      if (authProvider.signUpErrorMessage != null)
                        Text(
                          authProvider.signUpErrorMessage!,
                          style:
                              const TextStyle(color: Colors.red, fontSize: 16),
                        ),
                      const SizedBox(
                        height: 25,
                      ),
                      AlreadyMemberOrCreateAccount(
                        title: 'Already Member? ',
                        subTitle: 'Log In',
                        onTap: () {
                          Provider.of<AuthStateManager>(context, listen: false)
                              .clearErrorMessage();
                          Navigator.pushNamed(context, LogInPage.screenRoute);
                        },
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      CustomButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();

                            await authProvider.signUp(
                                name: name.trim(),
                                email: email.trim(),
                                password: password.trim());

                            if (authProvider.currentUser != null) {
                              if (!context.mounted) return;
                              buildMessageBar(context,
                                  const Text("You sign up Successfully"));

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
                        text: 'Sign Up',
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
