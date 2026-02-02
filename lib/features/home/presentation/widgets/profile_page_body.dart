import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/features/auth/presentation/provider/auth_state_manager.dart';
import 'package:my_app/features/home/presentation/widgets/profile_saved_news_section.dart';
import 'package:my_app/features/home/presentation/widgets/settings_page_body.dart';
import 'package:provider/provider.dart';

import '../../../../routes_names.dart';
import '../../../../shared/build_message_bar.dart';
import 'privacy_policy_screen.dart';

class ProfilePageBody extends StatefulWidget {
  const ProfilePageBody({super.key});

  static const String screenRoute = 'profile_page';

  @override
  State<ProfilePageBody> createState() => _ProfilePageBodyState();
}

class _ProfilePageBodyState extends State<ProfilePageBody> {
  String? profileImagePath;
  void _showImagePickerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'Choose Profile Image',
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Take a new photo'),
                  onTap: () {
                    _chooseImage(ImageSource.camera);
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 16.0),
                GestureDetector(
                  child: const Text('Select from gallery'),
                  onTap: () {
                    _chooseImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _chooseImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        profileImagePath = pickedImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthStateManager>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 16,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontal),
              child: Container(
                height: 100,
                decoration: const BoxDecoration(),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _showImagePickerDialog();
                      },
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: profileImagePath != null
                            ? FileImage(File(profileImagePath!))
                            : const AssetImage('images/profile icon.png')
                                as ImageProvider,
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            user.currentUser!.name.isEmpty
                                ? 'User Name'
                                : user.currentUser!.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            user.currentUser!.email.isEmpty
                                ? 'User email'
                                : user.currentUser!.email,
                            style: const TextStyle(
                              overflow: TextOverflow.ellipsis,
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Divider(
              color: Colors.grey[300],
              height: 24,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontal),
              child: ListTile(
                leading: const Icon(Icons.bookmark_outline),
                title: const Text(
                  'Saved News',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProfileSavedNewsSection()));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontal),
              child: ListTile(
                leading: const Icon(Icons.privacy_tip_outlined),
                title: const Text(
                  'Privacy Policy',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyPolicyScreen()),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontal),
              child: ListTile(
                leading: const Icon(Icons.settings_outlined),
                title: const Text(
                  'Settings',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pushNamed(SettingsPageBody.screenRoute);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kHorizontal),
              child: ListTile(
                leading: const Icon(
                  Icons.logout_outlined,
                ),
                title: const Text(
                  'Log out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                  ),
                ),
                onTap: () async {
                  final auth =
                      Provider.of<AuthStateManager>(context, listen: false);
                  await auth.signOut();
                  if (!context.mounted) return;
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    nextPage,
                    (route) => false,
                  );
                  buildMessageBar(
                      context, const Text("You signed out successfully"));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
