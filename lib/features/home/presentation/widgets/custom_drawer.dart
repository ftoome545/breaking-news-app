import 'package:flutter/material.dart';
import 'package:my_app/features/auth/presentation/provider/auth_state_manager.dart';
import 'package:my_app/features/home/presentation/widgets/privacy_policy_screen.dart';
import 'package:my_app/features/home/presentation/widgets/profile_page_body.dart';
import 'package:my_app/features/home/presentation/widgets/settings_page_body.dart';
import 'package:my_app/routes_names.dart';
import 'package:my_app/shared/build_message_bar.dart';
import 'package:my_app/theme/theme.dart';
import 'package:my_app/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthStateManager>(context);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: true);
    bool isLight = themeProvider.themeData == lightMode;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: isLight ? Colors.blue : Colors.deepPurple[400],
            ),
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const ProfilePageBody()),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundImage: auth.currentUser?.profileImg == null
                        ? const AssetImage("images/profile icon.png")
                        : NetworkImage(
                            auth.currentUser?.profileImg ??
                                'https://cdn.pixabay.com/photo/2023/02/18/11/00/icon-7797704_1280.png',
                          ) as ImageProvider,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    auth.currentUser == null
                        ? 'user name'
                        : auth.currentUser!.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    auth.currentUser == null
                        ? 'user@gmail.com'
                        : auth.currentUser!.email,
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ProfilePageBody()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: const Text(
              'Privacy Policy',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrivacyPolicyScreen()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
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
          ListTile(
            leading: const Icon(
              Icons.logout,
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
        ],
      ),
    );
  }
}
