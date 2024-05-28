// Firebase Authentification Logics
// import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:bkni/src/control.dart';
import 'package:bkni/src/profile.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // 1. handleAuthState

  // 2. Sign in with Google()

  // 3. Signout()
  signOut() {
    FirebaseAuth.instance.signOut();
  }

  //Determine if the user is authenticated.
  handleAuthState() {
    return StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            return const ControlPage(customIndex: 0,);
          } else {
            return const ProfilePage();
          }
        });
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Trigger the flow
      final GoogleSignInAccount? googleUser =
      await GoogleSignIn(scopes: <String>["email"]).signIn();

      if (googleUser == null) {
        return null; // User might have canceled sign-in
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      // Once signed in, return the UserCredential
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      print("Error signing in with Google: ${e.code}");
      // Handle specific FirebaseAuthException codes here
      // (e.g., show error message to user)
      return null;
    } catch (e) {
      print("Error signing in: $e");
      // Handle other exceptions
      return null;
    }
  }


}



