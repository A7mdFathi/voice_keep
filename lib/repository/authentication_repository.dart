import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_procrew/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';

class SignUpFailure implements Exception {}

class LogInWithEmailAndPasswordFailure implements Exception {}

class LogInWithGoogleFailure implements Exception {}

class LogInWithFacebookFailure implements Exception {}

class LogOutFailure implements Exception {}

class LoginWithPhoneNumberFailure implements Exception {}

@singleton
class AuthenticationRepository {
  AuthenticationRepository({
    firebase_auth.FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
    FacebookAuth facebookAuth,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance;

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;

  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
//TODO shared pref
      return user;
    });
  }

  User get currentUser {
    final user = _firebaseAuth.currentUser;

    return user == null ? User.empty : user.toUser; //todo shared pref
  }

  Future<void> signUp({String email, String password}) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('users')
          .doc(credential.user.uid)
          .set({
        "username": credential.user.displayName,
        "email": credential.user.email,
        "id": credential.user.uid,
      });
    } on Exception {
      throw SignUpFailure();
    }
  }

  Future<void> logInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth?.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  Future<void> logInWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login(
        loginBehavior: LoginBehavior.webOnly,
      );
      // Create a credential from the access token
      final credential = firebase_auth.FacebookAuthProvider.credential(
          result.accessToken.token);
      // Once signed in, return the UserCredential
      await _firebaseAuth.signInWithCredential(credential);
      _firebaseAuth.currentUser.updatePhotoURL(
          'https://graph.facebook.com/v2.12/me/picture?height=500&access_token=${result.accessToken.token}');
    } on Exception {
      throw LogInWithFacebookFailure();
    }
  }

  Future<void> logInWithEmailAndPassword({
    String email,
    String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
        _facebookAuth.logOut(),
      ]);
    } on Exception {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
