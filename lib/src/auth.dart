// Firebase Authentification Logics
// import 'package:firebase_core/firebase_core.dart';
import 'package:bkni/src/home.dart';
import 'package:bkni/src/product.dart';
import 'package:bkni/src/product_service.dart';
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
  // handleAuthState() {
  //   return StreamBuilder(
  //       stream: FirebaseAuth.instance.authStateChanges(),
  //       builder: (BuildContext context, snapshot) {
  //         if (snapshot.hasData) {
  //           return const ControlPage(
  //             customIndex: 0,
  //             product: widget.product,
  //           );
  //         } else {
  //           return const ProfilePage();
  //         }
  //       });
  // }
   
 handleAuthState() {
  return StreamBuilder(
    stream: FirebaseAuth.instance.authStateChanges(),
    builder: (BuildContext context, snapshot) {
      if (snapshot.hasData) {
        return FutureBuilder<List<ProductData>>(
          future: ProductService.getProductList(),
          builder: (context, productSnapshot) {
            if (productSnapshot.connectionState == ConnectionState.done) {
              if (productSnapshot.hasData && productSnapshot.data!.isNotEmpty) {
                // Ensure the list is not empty before accessing the first element
                return ControlPage(
                  customIndex: 0,
                  product: productSnapshot.data!.first, // Pass the first product
                );
              } else {
                return const Center(child: Text('No products available'));
              }
            } else {
              return const Scaffold(
                backgroundColor: Colors.white,
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          },
        );
      } else {
        return const ProfilePage();
      }
    },
  );
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
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

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
