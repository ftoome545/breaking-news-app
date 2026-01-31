import 'package:flutter/material.dart';
import 'package:my_app/features/auth/presentation/views/next_screen.dart';
import 'package:provider/provider.dart';

import '../../../home/presentation/widgets/bottom_navigation_bar.dart';
import '../provider/auth_state_manager.dart';

class DecisionScreen extends StatefulWidget {
  const DecisionScreen({super.key});

  @override
  State<DecisionScreen> createState() => _DecisionScreenState();
}

class _DecisionScreenState extends State<DecisionScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAuthStatus();
    });
  }

  void _checkAuthStatus() async {
    final authManager = Provider.of<AuthStateManager>(context, listen: false);

    await authManager.initializeAuth();

    if (authManager.isLoggedIn) {
      if (!context.mounted) return;
      Navigator.of(context).pushReplacementNamed(BottomNavBar.screenRoute);
    } else {
      Navigator.of(context).pushReplacementNamed(NextScreen.screenRoute);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
