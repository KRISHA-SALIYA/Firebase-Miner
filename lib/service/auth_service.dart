import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logger/logger.dart';

class AuthService {
  AuthService._();
  static final AuthService instnce = AuthService._();

  FirebaseAuth auth = FirebaseAuth.instance;
  Logger logger = Logger();

  Future<User?> anonymousLogIn() async {
    UserCredential credential = await auth.signInAnonymously();

    return credential.user;
  }

  Future<UserCredential> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<User?> signUp({required email, required psw}) async {
    UserCredential credential =
    await auth.createUserWithEmailAndPassword(email: email, password: psw);
    return credential.user;
  }

  Future<User?> sighIn({required email, required psw}) async {
    UserCredential credential =
    await auth.signInWithEmailAndPassword(email: email, password: psw);
    return credential.user;
  }

  Future<UserCredential> signInWithFacebook() async {
    LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(loginResult.accessToken!.tokenString);


    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  Future<void> logOut() async {
    await auth.signOut();
    await GoogleSignIn().signOut();
  }
}