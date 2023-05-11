import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:interview_demo_application/screens/home.dart';
import 'package:interview_demo_application/screens/login.dart';

class GoogleApis extends ChangeNotifier {
  bool isLoading = false;
  bool isValidLogin = false;
  Widget homePage = const LoginScreen();

  //create an instance of firebas auth and google signin
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  GoogleSignIn signIn = GoogleSignIn();

  Future<void> googleSignIn() async {
    try {
      isLoading = true;
      notifyListeners();

      //start the authentication flow
      final GoogleSignInAccount? googleUser = await signIn.signIn();

      if (googleUser == null) {
        isLoading = false;
        notifyListeners();
        return;
      }

      //get auth details from request
      final GoogleSignInAuthentication googleSignInAuth =
          await googleUser.authentication;
      //create new credentials
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuth.accessToken,
        idToken: googleSignInAuth.idToken,
      );
      //Signin the user with credentials
      await firebaseAuth.signInWithCredential(credential);

      isValidLogin = true;
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> googleSignOut() async {
    await firebaseAuth.signOut();
    await signIn.signOut();
  }

  Future<void> checkIfUserIsAlreadyLoggedIn() async {
    final user = firebaseAuth.currentUser;

    if (user != null) {
      homePage = const HomePage();
    } else {
      homePage = const LoginScreen();
    }
    notifyListeners();
  }
}
