import 'dart:async';
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/core/error/custom_exception.dart';

class FirebaseAuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  Future<User> signUp({required String email, required String password}) async {
    try {
      final credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuth.createUserWithEmailAndPassword: ${e.toString()}. e code: ${e.code.toString()}');
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        throw CustomException(
            message: 'The account already exists for that email.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(
            message:
                'The email provided is invalid. Please use a valid email address.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Make sure from your internet connection.');
      } else if (e.code == 'invalid-credential') {
        throw CustomException(
            message:
                'Your email address or password is incorrect. Please try again');
      } else {
        throw CustomException(message: 'Something went wrong, try again');
      }
    } catch (e) {
      log('Exception in FirebaseAuth.createUserWithEmailAndPassword: ${e.toString()}.');
      throw CustomException(message: 'Something went wrong, try again');
    }
  }

  Future<User> signIn({required String email, required String password}) async {
    try {
      final credential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return credential.user!;
    } on FirebaseAuthException catch (e) {
      log('Exception in FirebaseAuth.signInWithEmailAndPassword: ${e.toString()}. e code: ${e.code.toString()}');
      if (e.code == 'weak-password') {
        throw CustomException(message: 'The password provided is too weak.');
      } else if (e.code == 'network-request-failed') {
        throw CustomException(
            message: 'Make sure from your internet connection.');
      } else if (e.code == 'invalid-email') {
        throw CustomException(
            message:
                'The email provided is invalid. Please use a valid email address.');
      } else if (e.code == 'user-not-found') {
        throw CustomException(message: "Your email or password is wrong");
      } else if (e.code == 'wrong-password') {
        throw CustomException(
            message:
                "Your email address or password is incorrect. Please try again");
      } else if (e.code == 'invalid-credential') {
        throw CustomException(
            message:
                'Your email address or password is incorrect. Please try again');
      } else {
        throw CustomException(message: 'Something went wrong, try again');
      }
    } catch (e) {
      log('Exception in FirebaseAuth.signInWithEmailAndPassword: ${e.toString()}.');
      throw CustomException(message: 'Something went wrong, try again');
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }

  bool isLogged() {
    return auth.currentUser != null;
  }
}
