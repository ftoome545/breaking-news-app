import 'package:firebase_auth/firebase_auth.dart';

class AuthModel {
  final String name;
  final String email;
  String? uId;
  String? profileImg;

  AuthModel(
      {required this.name, required this.email, this.uId, this.profileImg});

  factory AuthModel.fromFirebaseUser(User user) {
    return AuthModel(
        name: user.displayName ?? '', email: user.email ?? '', uId: user.uid);
  }

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
        name: json['name'],
        email: json['email'],
        uId: json['uId'],
        profileImg: json['profileImg']);
  }

  factory AuthModel.fromModel(AuthModel authModel) {
    return AuthModel(
        name: authModel.name,
        email: authModel.email,
        uId: authModel.uId,
        profileImg: authModel.profileImg);
  }

  toMap() {
    return {'name': name, 'email': email, 'uId': uId, 'profileImg': profileImg};
  }
}
