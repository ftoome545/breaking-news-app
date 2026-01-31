import 'package:my_app/features/auth/data/models/auth_model.dart';
import 'package:my_app/core/error/failures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failures, AuthModel>> createUserWithEmailAndPassword(
      String name, String email, String password);

  Future<Either<Failures, AuthModel>> signInUserWithEmailAndPassword(
      String email, String password);

  Future<void> signOutUser();

  Future<void> addUserData({required AuthModel user});

  Future<AuthModel> getUserData({required String uId});

  Future<void> saveUserData({required AuthModel user});

  Future<AuthModel?> getStoredUser();

  Future<Either<Failures, void>> updateUserAvatar(
      {required String uId, required String data});
}
