import 'package:flutter/foundation.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/features/auth/data/models/auth_model.dart';
import 'package:my_app/core/services/shared_preferences_service.dart';

import '../../data/repos/auth_repo.dart';

class AuthStateManager extends ChangeNotifier {
  bool isSigningUp = false;
  String? signUpErrorMessage;
  AuthModel? _currentUser;

  AuthModel? get currentUser => _currentUser;

  bool get isLoggedIn => _currentUser != null;

  bool isLoggingIn = false;
  String? logInErrorMessage;

  final AuthRepo authRepo;

  bool avatarLoading = false;
  String? avatarErrorMessage;

  AuthStateManager({required this.authRepo});

  Future<void> signUp(
      {required String name,
      required String email,
      required String password}) async {
    isSigningUp = true;
    signUpErrorMessage = null;
    notifyListeners();
    final result =
        await authRepo.createUserWithEmailAndPassword(name, email, password);
    result.fold((failure) {
      signUpErrorMessage = failure.message;
      isSigningUp = false;
      notifyListeners();
    }, (user) {
      _currentUser = user;
      signUpErrorMessage = null;
      isSigningUp = false;
      notifyListeners();
    });
  }

  Future<void> signIn({required String email, required String password}) async {
    isLoggingIn = true;
    logInErrorMessage = null;
    notifyListeners();
    final result =
        await authRepo.signInUserWithEmailAndPassword(email, password);

    result.fold((failure) {
      logInErrorMessage = failure.message;
      isLoggingIn = false;
      notifyListeners();
    }, (user) {
      _currentUser = user;
      logInErrorMessage = null;
      isLoggingIn = false;
      notifyListeners();
    });
  }

  Future<void> initializeAuth() async {
    final user = await authRepo.getStoredUser();
    _currentUser = user;
  }

  Future<void> signOut() async {
    await authRepo.signOutUser();
    SharedPreferencesService.removeString(kuserData);
    _currentUser = null;
    signUpErrorMessage = null;
    isSigningUp = false;
    logInErrorMessage = null;
    isLoggingIn = false;
    notifyListeners();
  }

  void clearErrorMessage() {
    signUpErrorMessage = null;
    logInErrorMessage = null;
    notifyListeners();
  }

  Future<void> updateUserAvatar({required String data}) async {
    avatarLoading = true;
    avatarErrorMessage = null;
    notifyListeners();
    final result =
        await authRepo.updateUserAvatar(uId: _currentUser!.uId!, data: data);

    result.fold((failure) {
      avatarLoading = false;
      avatarErrorMessage = failure.message;
      notifyListeners();
    }, (value) {
      avatarLoading = false;
      notifyListeners();
    });
  }
}
