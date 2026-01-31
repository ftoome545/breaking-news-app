import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/back_end_point.dart';
import 'package:my_app/constants.dart';
import 'package:my_app/features/auth/data/models/auth_model.dart';
import 'package:my_app/features/auth/data/repos/auth_repo.dart';
import 'package:my_app/core/services/firebase_auth_service.dart';
import 'package:my_app/core/error/custom_exception.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:my_app/core/services/firestore_service.dart';
import 'package:my_app/core/services/shared_preferences_service.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuthService authService;
  final FirestoreService firestoreService;
  AuthRepoImpl({required this.authService, required this.firestoreService});

  @override
  Future<Either<Failures, AuthModel>> createUserWithEmailAndPassword(
      String name, String email, String password) async {
    User? user;
    try {
      user = await authService.signUp(email: email, password: password);
      final authModel =
          AuthModel(name: name, email: user.email!, uId: user.uid);
      await addUserData(user: authModel);
      await saveUserData(user: authModel);
      return right(authModel);
    } catch (e) {
      if (user != null) {
        await user.delete();
        await signOutUser();
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failures, AuthModel>> signInUserWithEmailAndPassword(
      String email, String password) async {
    User? user;
    try {
      user = await authService.signIn(email: email, password: password);
      final authModel = await getUserData(uId: user.uid);
      await saveUserData(user: authModel);
      return right(authModel);
    } catch (e) {
      if (user != null) {
        await signOutUser();
      }
      return left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<void> signOutUser() async {
    try {
      await authService.signOut();
    } catch (e) {
      throw CustomException(message: 'Something went wrong');
    }
  }

  @override
  Future<void> addUserData({required AuthModel user}) async {
    try {
      await firestoreService.addUser(
        path: BackEndPoint.addUser,
        data: AuthModel.fromModel(user).toMap(),
        documentID: user.uId,
      );
    } catch (e) {
      throw CustomException(message: "Sign up failed: ${e.toString()}");
    }
  }

  @override
  Future<AuthModel> getUserData({required String uId}) async {
    try {
      final result =
          await firestoreService.getUser(path: BackEndPoint.getUser, uId: uId);
      if (result == null) {
        throw CustomException(message: "User document not found.");
      }
      return AuthModel.fromJson(result);
    } catch (e) {
      throw CustomException(message: "Login failed: $e");
    }
  }

  @override
  Future<void> saveUserData({required AuthModel user}) async {
    try {
      var jsonData = jsonEncode(AuthModel.fromModel(user).toMap());
      await SharedPreferencesService.setString(kuserData, jsonData);
    } on CustomException catch (e) {
      throw ServerFailure('saveUserData method: ${e.toString()}');
    }
  }

  @override
  Future<AuthModel?> getStoredUser() async {
    try {
      final userDataString = SharedPreferencesService.getString(kuserData);

      if (userDataString.isEmpty) {
        return null;
      }

      final userMap = jsonDecode(userDataString) as Map<String, dynamic>;

      return AuthModel.fromJson(userMap);
    } catch (e) {
      throw ServerFailure(
          'Error retrieving stored user data at getStoredUser: ${e.toString()}');
    }
  }

  @override
  Future<Either<Failures, void>> updateUserAvatar(
      {required String uId, required String data}) async {
    try {
      await firestoreService.updateUserData(
          path: BackEndPoint.updateUserData, uId: uId, data: data);
      return right(null);
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
